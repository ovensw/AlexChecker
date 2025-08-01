@echo off
chcp 65001 > nul
title AlexChecker

REM *** AlexChecker: диагностика компьютера ***
echo *** AlexChecker: диагностика компьютера ***
echo.

REM Создание рабочей папки
set "outputDir=%TEMP%\AlexChecker"
if not exist "%outputDir%" mkdir "%outputDir%"
set "reportFile=%outputDir%\report.txt"

REM Сбор информации о системе
(
 echo ===== СИСТЕМНАЯ ИНФОРМАЦИЯ =====
 systeminfo
 echo.
 echo ===== ПРОЦЕССОР И ПАМЯТЬ =====
 wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed /value
 wmic memorychip get Capacity /value
 echo.
 echo ===== ДИСКОВОЕ ПРОСТРАНСТВО =====
 wmic logicaldisk get DeviceID,Description,FileSystem,FreeSpace,Size /value
) > "%reportFile%"
echo Завершено.
echo.

REM Генерация и вывод Base64‑строки. Скрипт PowerShell сохраняется во временный файл.
set "psScript=%outputDir%\encode.ps1"
(
 echo $bytes = [System.IO.File]::ReadAllBytes('%reportFile%')
 echo $encoded = [System.Convert]::ToBase64String($bytes)
 echo Set-Content -Path '%outputDir%\code.txt' -Value $encoded
 echo Write-Host '-----КОД-----'
 echo Write-Host $encoded
 echo Write-Host '--------------'
) > "%psScript%"

powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%psScript%"

REM Удаление временного PS1-файла
if exist "%psScript%" del "%psScript%"

REM Указание, где сохраняется код
echo Код также сохранён в "%outputDir%\code.txt".
echo Скопируйте этот код и вставьте его на сайт AlexChecker.
echo Нажмите любую клавишу для выхода.
pause > nul
