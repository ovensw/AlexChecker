@echo off
chcp 65001 > NUL
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
echo Генерация кода...
REM Генерация и вывод Base64-строки, а также сохранение её в файл
powershell -NoLogo -NoProfile -Command "$content = Get-Content -Raw -Path '%reportFile%'; $bytes = [System.Text.Encoding]::UTF8.GetBytes($content); $encoded = [Convert]::ToBase64String($bytes); $encoded | Set-Content -Path '%outputDir%\code.txt'; $encoded"

echo.
echo Код также сохранён в файле "%outputDir%\code.txt".
echo Скопируйте этот код и вставьте его на сайт AlexChecker.
echo Нажмите любую клавишу для выхода...
pause > nul
