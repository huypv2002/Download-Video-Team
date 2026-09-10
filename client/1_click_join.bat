@echo off
chcp 65001 >nul
title [CLIENT] Ket noi Kho Video Team

echo ======================================================
echo          KET NOI KHO VIDEO CHO THANH VIEN TEAM
echo               Du an: Download-Video-Team
echo ======================================================
echo.

:: -----------------------------------------------------------------------------
:: CAU HINH CO BAN
:: Admin co the dien san link Domain HTTPS hoac IP cua Server vao day truoc khi gui cho team:
:: Vi du: set "SERVER_URL=https://kho-video.tail1234.ts.net"
:: -----------------------------------------------------------------------------
set "SERVER_URL="
set "SERVER_IP=100.x.y.z"
set "SERVER_PORT=3923"
set "TAILSCALE_AUTH_KEY="

:: 1. Kiem tra va cai dat Tailscale tren may
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

:: 2. Tu dong ket noi Tailscale
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

:: 3. Xac dinh duong link truy cap (Uu tien Domain HTTPS)
if "%SERVER_URL%"=="" (
    if not "%SERVER_IP%"=="100.x.y.z" (
        set "SERVER_URL=http://%SERVER_IP%:%SERVER_PORT%/"
    ) else (
        echo.
        echo ======================================================
        echo NHAP LINK HOAC IP MAY CHU DO QUAN LY CAP:
        echo Vi du: https://kho-video.tailxxxx.ts.net
        echo Hoac  : 100.85.12.34
        echo ======================================================
        set /p INPUT_URL=">> Nhap link hoac IP: "
        
        echo !INPUT_URL! | findstr /i "^http" >nul
        if %errorlevel% equ 0 (
            set "SERVER_URL=!INPUT_URL!"
        ) else (
            set "SERVER_URL=http://!INPUT_URL!:%SERVER_PORT%/"
        )
    )
)

:: 4. Tao Shortcut ra man hinh Desktop
echo.
echo [*] Dang tao bieu tuong "Kho Video Team" tren Desktop...
set "DESKTOP_DIR=%USERPROFILE%\Desktop"
set "URL_FILE=%DESKTOP_DIR%\Kho Video Team.url"

(
    echo [InternetShortcut]
    echo URL=%SERVER_URL%
    echo IconIndex=0
    echo IconFile=C:\Windows\System32\shell32.dll
) > "%URL_FILE%"

if exist "%URL_FILE%" (
    echo   + Da tao bieu tuong tren man hinh Desktop thanh cong!
) else (
    echo   [-] Khong the tao shortcut Desktop, ban co the luu bookmark link sau:
    echo       %SERVER_URL%
)

echo.
echo ======================================================
echo                  KET NOI THANH CONG!
echo.
echo  Ban co the ra man hinh Desktop va bam dup vao icon:
echo  [ Kho Video Team ]
echo.
echo  Hoac mo trinh duyet truy cap:
echo  👉 %SERVER_URL%
echo.
echo  Tai khoan dang nhap:
echo  - User: member  (hoac tai khoan do quan ly cap)
echo  - Pass: TeamVideoPass@123
echo ======================================================
echo.
pause
