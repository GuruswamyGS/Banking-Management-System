@echo off
title Start BMS Servers (MySQL & Tomcat)
echo ========================================================
echo   Starting Banking Management System Servers
echo ========================================================

echo.
echo [1/2] Starting MySQL Daemon...
start "" /b "C:\xampp\mysql\bin\mysqld.exe" --defaults-file="C:\xampp\mysql\bin\my.ini" --standalone

timeout /t 2 /nobreak > nul

echo.
echo [2/2] Starting Apache Tomcat Server...
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "CATALINA_HOME=C:\xampp\tomcat"
start "Apache Tomcat" "%CATALINA_HOME%\bin\catalina.bat" run

timeout /t 3 /nobreak > nul

echo.
echo ========================================================
echo   Servers are up and running!
echo   Open your browser at:
echo   - http://localhost:8080/BankingManagementSystem/
echo   - http://localhost:8080/bms/
echo ========================================================
start http://localhost:8080/BankingManagementSystem/
pause
