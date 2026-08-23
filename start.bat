@echo off
setlocal

:: ========================================
:: Request administrator privileges
:: ========================================

net session >nul 2>&1

if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ========================================
:: Set working directory to this script's folder
:: ========================================

cd /d "%~dp0"

title GTA VI Rich Presence

echo ========================================
echo       GTA VI Rich Presence
echo ========================================
echo.
echo Running from:
echo %cd%
echo.

:: ========================================
:: Check Python
:: ========================================

where py >nul 2>&1

if %errorlevel% neq 0 (
    echo Python was not found.
    echo.
    echo Please install Python 3 from:
    echo https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

echo Python found.
echo.

:: ========================================
:: Check pypresence
:: ========================================

echo Checking required libraries...
echo.

py -c "import pypresence" >nul 2>&1

if %errorlevel% neq 0 (
    echo pypresence is not installed.
    echo Installing pypresence...
    echo.

    py -m pip install pypresence

    if %errorlevel% neq 0 (
        echo.
        echo Failed to install pypresence.
        echo Make sure Python and pip are installed correctly.
        echo.
        pause
        exit /b 1
    )

    echo.
    echo pypresence installed successfully.
) else (
    echo pypresence is already installed.
)

:: ========================================
:: Start program
:: ========================================

echo.
echo Starting GTA VI Rich Presence...
echo.
echo Keep Discord running.
echo Press Ctrl+C to stop.
echo.

py "%~dp0main.py"

echo.
echo GTA VI Rich Presence has stopped.
pause