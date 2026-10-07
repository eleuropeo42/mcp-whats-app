@echo off
title WhatsApp Bridge
cd /d "%~dp0whatsapp-bridge"

rem Already running? Then there is nothing to do.
netstat -an | findstr /C:"127.0.0.1:8080" | findstr /C:"LISTENING" >nul
if not errorlevel 1 (
    echo.
    echo   WhatsApp Bridge is already running. You can close this window.
    echo.
    timeout /t 6 >nul
    exit /b 0
)

rem Build the program the first time (needs Go and gcc installed).
if not exist "whatsapp-bridge.exe" (
    echo   First start: building the bridge, this takes a minute...
    go build -o whatsapp-bridge.exe .
    if errorlevel 1 (
        echo.
        echo   Could not build the bridge. Check that Go and gcc are installed.
        pause
        exit /b 1
    )
)

echo.
echo   WhatsApp Bridge is starting.
echo   KEEP THIS WINDOW OPEN while you use WhatsApp in Claude.
echo   You can minimize it. To stop the bridge, close this window.
echo.
echo   If a QR code appears, scan it with your phone:
echo   WhatsApp - Settings - Linked devices - Link a device
echo.

"%~dp0whatsapp-bridge\whatsapp-bridge.exe"

echo.
echo   The bridge has stopped. Open "Start WhatsApp Bridge" again to restart it.
pause
