@echo off
cd /d "%~dp0"

echo Checking Git...

git --version >nul 2>&1
if %errorlevel% neq 0 (
  echo Git is not installed.
  echo Installing Git...
  
  winget install --id Git.Git -e --source winget
  
  if %errorlevel% neq 0 (
    echo Failed to install Git.
    pause
    exit /b 1
  )
  
  echo.
  echo Git installation completed.
  echo Please restart this script if Git is not yet available.
  pause
  exit /b
  
)

echo.
echo Pulling repository...
git pull

echo.
pause
