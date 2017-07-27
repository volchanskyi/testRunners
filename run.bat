@ECHO OFF

:: ====================================================================================
SET GITHUB=%1
SET WS_DIR=%2
SET REPO=%3
SET VERSION=%4
SET MAIN_CLASS=%5
:: ===================================================================================

IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
IF "%M2%" == "" GOTO EXIT_MVN
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
GOTO NEXT

:NEXT
IF NOT EXIST D:\projects\Workspace\%WS_DIR% GOTO NO_WORKSPACE
IF EXIST D:\projects\Workspace\%WS_DIR%\%REPO% RMDIR /S /Q C:\%WS_DIR%\%REPO%
CD C:\%WS_DIR%
git clone https://github.com/%GITHUB%/%REPO%.git
CD %REPO%
SLEEP 2
CALL mvn package
ECHO.
ECHO Executing Java program .....................................
java -cp D:\projects\Workspace\%WS_DIR%\%REPO%\target\%REPO%-%VERSION%-jar-with-dependencies.jar %MAIN_CLASS%
GOTO END

:EXIT_JAVA
ECHO No Java installed
GOTO END

:EXIT_MVN
ECHO No Maven installed
GOTO END

:EXIT_GIT
ECHO No Git installed
GOTO END

:NO_WORKSPACE
ECHO %WS_DIR% is not exist
GOTO END

:END
CD\