@echo off
chcp 65001 >nul
title [SETUP] Cai dat Kho Video Server 24/7

echo ======================================================
echo       TRIEN KHAI KHO VIDEO SERVER WINDOWS 24/7
echo                  Du an: Download-Video-Team
echo ======================================================
echo.

:: 1. Chay script tinh chinh Windows (Sleep, NIC, Firewall)
echo [1/4] Dang chay tinh chinh Windows 24/7 (Yeu cau quyen Admin)...
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "win_power_keepalive.ps1"

:: 2. Kiem tra va cai dat Python / Copyparty
echo.
echo [2/4] Kiem tra Python va goi phan mem Copyparty...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [CANH BAO] May tinh chua cai Python hoac chua them vao PATH!
    echo Vui long tai va cai Python 3.10+ tai: https://www.python.org/downloads/
    echo LUU Y: Nho tich chon "[x] Add python.exe to PATH" truoc khi bam Install.
    pause
    exit /b 1
)

echo [*] Dang cai dat/nang cap Copyparty len ban moi nhat...
pip install --upgrade copyparty

:: 3. Tao Shortcut khoi dong cung Windows
echo.
echo [3/4] Cau hinh tu khoi dong server khi may bat (Startup)...
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "SHORTCUT_PATH=%STARTUP_FOLDER%\Kho_Video_Server.lnk"
set "TARGET_BAT=%~dp0start_server_manual.bat"

powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT_PATH%'); $Shortcut.TargetPath = '%TARGET_BAT%'; $Shortcut.WorkingDirectory = (Resolve-Path '%~dp0..\..').Path; $Shortcut.WindowStyle = 7; $Shortcut.Save()"

if exist "%SHORTCUT_PATH%" (
    echo   + Da tao shortcut tu khoi dong tai Startup thanh cong!
) else (
    echo   [-] Khong the tao Startup shortcut, ban co the chay thu cong.
)

:: 4. Hoi kich hoat Ten mien Domain HTTPS Let's Encrypt
echo.
echo [4/4] Kich hoat Ten mien Domain HTTPS mien phi (Tailscale Serve)...
where tailscale >nul 2>&1
if %errorlevel% equ 0 (
    tailscale status >nul 2>&1
    if %errorlevel% equ 0 (
        echo [*] Dang tu dong cap phat Ten mien va chung chi SSL Let's Encrypt...
        tailscale serve --bg 3923
        echo   + Trang thai Domain HTTPS:
        tailscale serve status
    ) else (
        echo [-] Tailscale chua dang nhap. Ban co the chay file enable_domain_https.bat sau.
    )
) else (
    echo [-] Chua cai Tailscale. Hay cai Tailscale va chay enable_domain_https.bat sau.
)

echo.
echo ======================================================
echo             HOAN TAT CAI DAT MAY CHU!
echo  - Thu muc video mac dinh: D:\Videos
echo  - File cau hinh: server\config\copyparty.conf
echo  - File bat Ten mien HTTPS: server\scripts\enable_domain_https.bat
echo  - De chay ngay bay gio: Chay file start_server_manual.bat
echo ======================================================
echo.
pause
