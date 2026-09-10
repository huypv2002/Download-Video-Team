@echo off
chcp 65001 >nul
title [SERVER] Kho Video Team - Dang chay...

echo ======================================================
echo    KHO VIDEO TEAM - CHAY SERVER THU CONG (MANUAL)
echo ======================================================
echo.

:: Kiem tra Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [LOI] Khong tim thay Python tren he thong!
    echo Vui long cai dat Python tai https://www.python.org/
    echo (Nho tich vao o "Add python.exe to PATH" khi cai dat)
    echo.
    pause
    exit /b 1
)

:: Kiem tra copyparty da duoc cai dat chua
python -c "import copyparty" >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] Dang cai dat thu vien Copyparty...
    pip install copyparty
    if %errorlevel% neq 0 (
        echo [LOI] Cai dat Copyparty that bai! Kiem tra ket noi Internet.
        pause
        exit /b 1
    )
)

echo [*] Dang khoi dong Video Server voi cau hinh toi uu...
echo [*] Cac may con trong Tailnet co the truy cap vao port 3923 hoac 8080.
echo [*] De dung server, bam to hop phim Ctrl + C.
echo.

:: Chay copyparty voi file config tu thu muc goc du an
cd /d "%~dp0..\.."
python -m copyparty -c "server\config\copyparty.conf"

pause
