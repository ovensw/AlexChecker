@echo off
chcp 65001 > NUL
title AlexChecker

echo *** AlexChecker: Диагностика компьютера ***
echo.

REM Создание рабочей папки во временном каталоге
set "outputDir=%TEMP%\AlexChecker"
if not exist "%outputDir%" mkdir "%outputDir%"

REM Имя файла для отчета
set "reportFile=%outputDir%\report.txt"

echo Сбор информации о системе...
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

echo Генерация кода...
REM Генерация и вывод Base64 строки
powershell -NoLogo -NoProfile -Command ^
    "$content = Get-Content -Raw -Path '%reportFile%'; $bytes = [System.Text.Encoding]::UTF8.GetBytes($content); $encoded = [System.Convert]::ToBase64String($bytes); Write-Output $encoded"
echo.
echo Код также сохранён в файле "%outputDir%\code.txt".
REM Сохранение Base64 в файл
powershell -NoLogo -NoProfile -Command ^
    "$content = Get-Content -Raw -Path '%reportFile%'; $bytes = [System.Text.Encoding]::UTF8.GetBytes($content); $encoded = [System.Convert]::ToBase64String($bytes); Set-Content -Path '%outputDir%\code.txt' -Value $encoded"
echo.
echo Скопируйте этот код и вставьте на сайт AlexChecker.
echo Нажмите любую клавишу для выхода...
pause > nul
