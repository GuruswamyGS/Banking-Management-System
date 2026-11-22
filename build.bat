@echo off
setlocal enabledelayedexpansion
title Banking Management System - Build & Deploy

echo ========================================================
echo   Banking Management System (BMS) - Build Script
echo   VTU MCA Dissertation - G S Guruswamy
echo ========================================================
echo.

set "PROJECT_DIR=%~dp0"
set "SRC_DIR=%PROJECT_DIR%src"
set "WEB_DIR=%PROJECT_DIR%WebContent"
set "CLASSES_DIR=%WEB_DIR%\WEB-INF\classes"
set "LIB_DIR=%WEB_DIR%\WEB-INF\lib"
set "TOMCAT_LIB=C:\xampp\tomcat\lib"
set "TOMCAT_WEBAPPS=C:\xampp\tomcat\webapps"

if not exist "%CLASSES_DIR%" mkdir "%CLASSES_DIR%"

echo [1/4] Compiling Java Source Files with javac...
set "CLASSPATH=%TOMCAT_LIB%\servlet-api.jar;%TOMCAT_LIB%\jsp-api.jar;%LIB_DIR%\*"

dir /s /b "%SRC_DIR%\*.java" > "%PROJECT_DIR%sources.txt"
javac -encoding UTF-8 -cp "%CLASSPATH%" -d "%CLASSES_DIR%" @"%PROJECT_DIR%sources.txt"
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Compilation failed!
    del "%PROJECT_DIR%sources.txt"
    pause
    exit /b %ERRORLEVEL%
)
del "%PROJECT_DIR%sources.txt"
echo [SUCCESS] Java Compilation complete.

echo.
echo [2/4] Packaging WAR file...
cd /d "%WEB_DIR%"
"C:\Program Files\Java\jdk-17\bin\jar.exe" -cvf "%PROJECT_DIR%BankingManagementSystem.war" * > nul
echo [SUCCESS] WAR generated: %PROJECT_DIR%BankingManagementSystem.war

echo.
echo [3/4] Deploying to Tomcat Webapps...
if exist "%TOMCAT_WEBAPPS%" (
    if not exist "%TOMCAT_WEBAPPS%\BankingManagementSystem" mkdir "%TOMCAT_WEBAPPS%\BankingManagementSystem"
    xcopy /s /e /y "%WEB_DIR%\*" "%TOMCAT_WEBAPPS%\BankingManagementSystem\" > nul
    
    if not exist "%TOMCAT_WEBAPPS%\bms" mkdir "%TOMCAT_WEBAPPS%\bms"
    xcopy /s /e /y "%WEB_DIR%\*" "%TOMCAT_WEBAPPS%\bms\" > nul
    echo [SUCCESS] Deployed to %TOMCAT_WEBAPPS%\BankingManagementSystem
    echo [SUCCESS] Deployed to %TOMCAT_WEBAPPS%\bms
) else (
    echo [WARNING] Tomcat webapps folder not found at %TOMCAT_WEBAPPS%.
)

echo.
echo [4/4] Build & Deploy Finished Successfully!
echo Accessible at: http://localhost:8080/BankingManagementSystem/
echo ========================================================
cd /d "%PROJECT_DIR%"
pause
