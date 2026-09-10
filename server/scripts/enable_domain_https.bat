@echo off
chcp 65001 >nul
title [DOMAIN HTTPS] Kich hoat Ten mien Bao mat Tailscale

echo ======================================================
echo    KICH HOAT TEN MIEN HTTPS CHO KHO VIDEO (TAILSCALE)
echo               Du an: Download-Video-Team
echo ======================================================
echo.

:: Kiem tra Tailscale
where tailscale >nul 2>&1
if %errorlevel% neq 0 (
    echo [LOI] Khong tim thay Tailscale tren he thong!
    echo Vui long cai dat Tailscale tai: https://tailscale.com/download/windows
    pause
    exit /b 1
)

echo [*] Kiem tra trang thai ket noi Tailscale...
tailscale status >nul 2>&1
if %errorlevel% neq 0 (
    echo [LOI] Tailscale chua dang nhap!
    echo Vui long dang nhap vao ung dung Tailscale duoi khay he thong truoc.
    pause
    exit /b 1
)

echo.
echo ======================================================
echo CHON THAO TAC:
echo [1] Kich hoat Ten mien HTTPS (tailscale serve 3923)
echo [2] Xem Ten mien HTTPS hien tai
echo [3] Tat Ten mien HTTPS (reset)
echo ======================================================
set /p CHOICE=">> Nhap lua chon cua ban (1, 2 hoac 3): "

if "%CHOICE%"=="1" (
    echo.
    echo [*] Dang kich hoat Ten mien HTTPS va chung chi Let's Encrypt...
    tailscale serve --bg 3923
    echo.
    echo ======================================================
    echo          KICH HOAT TEN MIEN HTTPS THANH CONG!
    echo.
    echo Trang thai hien tai:
    tailscale serve status
    echo ======================================================
    echo.
    echo Ban hay copy duong link Domain HTTPS co duoi [.ts.net] o tren
    echo va gui cho cac thanh vien trong team (co kem o khoa xanh HTTPS)!
)

if "%CHOICE%"=="2" (
    echo.
    echo [*] Thong tin Ten mien HTTPS hien tai:
    tailscale serve status
)

if "%CHOICE%"=="3" (
    echo.
    echo [*] Dang huy kich hoat Ten mien HTTPS...
    tailscale serve reset
    echo   + Da reset thanh cong!
)

echo.
pause
