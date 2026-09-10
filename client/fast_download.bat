@echo off
chcp 65001 >nul
title [CLIENT] Cong cu Tai Video Toc do cao (Resume / Ho tro file lon)

echo ======================================================
echo    CONG CU TAI VIDEO TOC DO CAO & TAI TIEP KHI DUT
echo               Du an: Download-Video-Team
echo ======================================================
echo.
echo Cong cu nay su dung cong nghe HTTP Range Request co san tren Windows
echo Giup tai cac file video 10GB - 50GB khong bi loi, tu dong tai tiep neu rot mang.
echo.

:: Nhap URL can tai
set /p VIDEO_URL=">> Dan link Video tren web vao day: "
if "%VIDEO_URL%"=="" (
    echo [LOI] Ban chua nhap link video!
    pause
    exit /b 1
)

:: Thu muc luu file (mac dinh la thu muc Downloads cua may)
set "DOWNLOAD_DIR=%USERPROFILE%\Downloads"
echo [*] Video se duoc luu vao: %DOWNLOAD_DIR%
echo [*] Dang bat dau tai (neu dut mang giua chung, chay lai file nay se tai tiep)...
echo.

:: Su dung curl co san tren Windows 10/11
:: Co -C - : Resume tai tiep neu file bi gian doan
:: Co -O   : Giu nguyen ten file goc tu URL
:: Co -#   : Hien thi thanh tien trinh (Progress bar)
cd /d "%DOWNLOAD_DIR%"
curl.exe -C - -O -# "%VIDEO_URL%"

if %errorlevel% equ 0 (
    echo.
    echo ======================================================
    echo           TAI HOAN TAT VA THANG CONG!
    echo  File da duoc luu tai: %DOWNLOAD_DIR%
    echo ======================================================
    explorer.exe "%DOWNLOAD_DIR%"
) else (
    echo.
    echo [-] Qua trinh tai bi gian doan hoac link khong hop le.
    echo     Ban chi can mo lai file nay va dan link de TAI TIEP ma khong bi mat du lieu.
)

echo.
pause
