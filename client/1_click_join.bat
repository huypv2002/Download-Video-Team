@echo off
chcp 65001 >nul
title [CLIENT] Ket noi Kho Video Team

echo ======================================================
echo          KET NOI KHO VIDEO CHO THANH VIEN TEAM
echo               Du an: Download-Video-Team
echo ======================================================
echo.

:: -----------------------------------------------------------------------------
:: CAU HINH CO BAN (Admin co the sua san IP va Auth Key vao day de gui cho team)
:: -----------------------------------------------------------------------------
set "SERVER_IP=100.x.y.z"
set "SERVER_PORT=3923"
set "TAILSCALE_AUTH_KEY="

:: Kiem tra neu Admin chua dien SERVER_IP
if "%SERVER_IP%"=="100.x.y.z" (
    echo [*] Nhap dia chi IP Tailscale cua May Chu Video:
    set /p SERVER_IP=">> IP May Chu: "
)

echo.
echo [*] Dang kiem tra phan mem mang Tailscale tren may...
where tailscale >nul 2>&1
if %errorlevel% neq 0 (
    echo [-] Chua tim thay Tailscale tren may ban.
    echo [*] Dang mo trinh duyet de ban tai va cai dat Tailscale (Chi mat 1 phut)...
    start https://tailscale.com/download/windows
    echo.
    echo Sau khi cai dat xong Tailscale, vui long mo lai file nay de hoan tat!
    echo.
    pause
    exit /b 0
)

:: Neu co san Auth Key thi tu dong login, neu khong thi hoi hoac nhan Enter de dung giao dien
if not "%TAILSCALE_AUTH_KEY%"=="" (
    echo [*] Dang tu dong ket noi mang an toan qua Auth Key...
    tailscale up --authkey=%TAILSCALE_AUTH_KEY% --accept-routes
) else (
    echo [*] Kiem tra trang thai ket noi Tailscale...
    tailscale status >nul 2>&1
    if %errorlevel% neq 0 (
        echo [*] Dang kich hoat ket noi Tailscale...
        tailscale up
    )
)

:: Tao Shortcut ra man hinh Desktop
echo.
echo [*] Dang tao bieu tuong "Kho Video Team" tren Desktop...
set "DESKTOP_DIR=%USERPROFILE%\Desktop"
set "URL_FILE=%DESKTOP_DIR%\Kho Video Team.url"

(
    echo [InternetShortcut]
    echo URL=http://%SERVER_IP%:%SERVER_PORT%/
    echo IconIndex=0
    echo IconFile=C:\Windows\System32\shell32.dll
) > "%URL_FILE%"

if exist "%URL_FILE%" (
    echo   + Da tao bieu tuong tren man hinh Desktop thanh cong!
) else (
    echo   [-] Khong the tao shortcut Desktop, ban co the luu bookmark link sau:
    echo       http://%SERVER_IP%:%SERVER_PORT%/
)

echo.
echo ======================================================
echo                  KET NOI THANH CONG!
echo.
echo  Ban co the ra man hinh Desktop va bam dup vao icon:
echo  [ Kho Video Team ]
echo.
echo  Hoac mo trinh duyet go dia chi:
echo  http://%SERVER_IP%:%SERVER_PORT%/
echo.
echo  Tai khoan dang nhap:
echo  - User: member
echo  - Pass: TeamVideoPass@123
echo ======================================================
echo.
pause
