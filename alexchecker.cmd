@echo off
chcp 65001 > NUL
title AlexChecker
echo *** AlexChecker: Диагностика компьютера ***
echo.
echo Сбор информации о системе...
set "tempfile=%TEMP%\alexchecker_systeminfo.txt"
systeminfo > "%tempfile%"
echo Завершено.
echo.
echo Генерация кода...
powershell -NoLogo -NoProfile -Command ^
  "$content = Get-Content -Raw -Path '%tempfile%';" ^
  "$bytes   = [System.Text.Encoding]::UTF8.GetBytes($content);" ^
  "$encoded = [System.Convert]::ToBase64String($bytes);" ^
  "Write-Output $encoded"
echo.
echo Скопируйте этот код и вставьте на сайт AlexChecker.
del "%tempfile%"
pause
