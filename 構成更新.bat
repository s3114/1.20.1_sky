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
echo Please run this script again.
pause
exit /b

)

echo.
echo Detecting current branch...

for /f %%i in ('git branch --show-current') do set BRANCH=%%i

if "%BRANCH%"=="" (
echo Failed to detect current branch.
pause
exit /b 1
)

echo Current branch: %BRANCH%
echo.

echo Fetching latest changes...
git fetch origin

if %errorlevel% neq 0 (
echo Fetch failed.
pause
exit /b 1
)

echo.
echo Overwriting local Git-managed files...
git reset --hard origin/%BRANCH%

if %errorlevel% neq 0 (
echo Reset failed.
pause
exit /b 1
)

echo.
echo Update completed successfully.
pause
