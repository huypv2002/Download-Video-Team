<#
=============================================================================
SCRIPT TINH CHINH WINDOWS CHAY 24/7 CHO KHO VIDEO
Du an: Download-Video-Team
Tac dung:
1. Chuyen Power Plan sang High Performance
2. Tat che do Sleep/Hibernate cua may tinh
3. Tat tinh nang tat o cung sau thoi gian nghi (Disk Timeout = 0)
4. Tat tinh nang tiet kiem dien tren Card mang (Chong ngat mang ngam)
5. Mo cong Windows Firewall cho Port 3923 va 8080
6. Chặn Windows tu dong reboot giua chung do Update
=============================================================================
#>

# 1. Kiem tra quyen Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[!] Script yeu cau quyen Administrator de tinh chinh he thong." -ForegroundColor Yellow
    Write-Host "[*] Dang khoi dong lai duoi quyen Administrator..." -ForegroundColor Cyan
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Clear-Host
Write-Host "======================================================" -ForegroundColor Green
Write-Host "   BAT DAU TOI UU HOA WINDOWS CHAY SERVER 24/7" -ForegroundColor Green
Write-Host "======================================================" -ForegroundColor Green

# 2. Cau hinh Power Plan High Performance
Write-Host "[1/6] Cau hinh Che do Nguon dien (High Performance)..." -ForegroundColor Cyan
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
# Tat Sleep may tinh (cam nguon)
powercfg -change -standby-timeout-ac 0
powercfg -change -hibernate-timeout-ac 0
# Tat Sleep o dia (cam nguon)
powercfg -change -disk-timeout-ac 0
# Man hinh co the tat sau 30 phut de tiet kiem dien (may van chay 100%)
powercfg -change -monitor-timeout-ac 30

# 3. Tat Power Management tren Card mang (Network Adapters)
Write-Host "[2/6] Tat tinh nang tiet kiem dien tren Card mang (Chong rot ket noi)..." -ForegroundColor Cyan
$adapters = Get-NetAdapter -Physical | Get-NetAdapterPowerManagement
foreach ($nic in $adapters) {
    try {
        Set-NetAdapterPowerManagement -Name $nic.Name -AllowComputerToTurnOffDevice Disabled -ErrorAction SilentlyContinue
        Write-Host "   + Da tat Sleep tren Card: $($nic.Name)" -ForegroundColor Gray
    } catch {
        # Bo qua neu card mang khong ho tro
    }
}

# 4. Mo cong Windows Firewall cho Server (Port 443 HTTPS, 3923 & 8080)
Write-Host "[3/6] Mo cong Windows Firewall (Port 443, 3923 & 8080)..." -ForegroundColor Cyan
Remove-NetFirewallRule -DisplayName "Video Server Port 443" -ErrorAction SilentlyContinue
Remove-NetFirewallRule -DisplayName "Video Server Port 3923" -ErrorAction SilentlyContinue
Remove-NetFirewallRule -DisplayName "Video Server Port 8080" -ErrorAction SilentlyContinue

New-NetFirewallRule -DisplayName "Video Server Port 443" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow -Profile Any | Out-Null
New-NetFirewallRule -DisplayName "Video Server Port 3923" -Direction Inbound -LocalPort 3923 -Protocol TCP -Action Allow -Profile Any | Out-Null
New-NetFirewallRule -DisplayName "Video Server Port 8080" -Direction Inbound -LocalPort 8080 -Protocol TCP -Action Allow -Profile Any | Out-Null
Write-Host "   + Da mo port 443 (HTTPS), 3923 va 8080 thanh cong." -ForegroundColor Gray

# 5. Chặn Windows Update tu dong khoi dong lai khi co nguoi dang ket noi
Write-Host "[4/6] Cau hinh Windows Update khong tu y Reboot..." -ForegroundColor Cyan
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
# NoAutoRebootWithLoggedOnUsers = 1 (Khong bao gio tu restart khi co session)
Set-ItemProperty -Path $regPath -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -Type DWord -Force | Out-Null
# AUOptions = 2 (Thong bao khi co update chu khong tu cai va tu khoi dong lai)
Set-ItemProperty -Path $regPath -Name "AUOptions" -Value 2 -Type DWord -Force | Out-Null

# 6. Kiem tra thu muc D:\Videos
Write-Host "[5/6] Kiem tra thu muc chia se video..." -ForegroundColor Cyan
$videoDir = "D:\Videos"
if (-not (Test-Path $videoDir)) {
    Write-Host "   [*] Thu muc D:\Videos chua ton tai. Dang tao thu muc..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $videoDir -Force | Out-Null
}
Write-Host "   + Thu muc video san sang: $videoDir" -ForegroundColor Gray

# 7. Hoan tat
Write-Host "[6/6] Kiem tra hoan tat!" -ForegroundColor Green
Write-Host ""
Write-Host "======================================================" -ForegroundColor Green
Write-Host "   MAY CHU DA DUOC CAU HINH CHAY ON DINH 24/7!" -ForegroundColor Green
Write-Host "   - O cung & Card mang se KHONG bi ngat khi nghi." -ForegroundColor Green
Write-Host "   - Port 3923 & 8080 da duoc mo tren Windows Firewall." -ForegroundColor Green
Write-Host "======================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Nhan phim bat ky de thoat..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
