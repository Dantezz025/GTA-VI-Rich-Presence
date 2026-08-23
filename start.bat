@echo off
title GTA VI Rich Presence

echo ========================================
echo       GTA VI Rich Presence
echo ========================================
echo.

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

if not exist ".venv" (
    echo Creating virtual environment...
    py -m venv .venv

    if %errorlevel% neq 0 (
        echo Failed to create virtual environment.
        pause
        exit /b 1
    )
)

echo Installing required libraries...
.venv\Scripts\python.exe -m pip install -r requirements.txt

if %errorlevel% neq 0 (
    echo.
    echo Failed to install required libraries.
    pause
    exit /b 1
)

echo.
echo Starting GTA VI Rich Presence...
echo.
echo Keep Discord running.
echo Press Ctrl+C to stop.
echo.

.venv\Scripts\python.exe main.py

echo.
echo GTA VI Rich Presence has stopped.
pause