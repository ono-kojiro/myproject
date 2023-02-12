@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

FOR /F "delims=" %%i IN ('CD') DO SET TOP_DIR=%%i

REM ŠÂ‹«•Ï”PATH‚ðsystem32‚Ì‚Ý‚ÉÝ’è‚µ‚ÄŠÂ‹«‚ð‰Šú‰»‚·‚é
SET PATH=%SYSTEMROOT%\system32

CALL config.bat

SET BUILD_DIR=_build

IF "x%1" == "x" (
	CALL :ALL
	IF "!ERRORLEVEL!" == "0" (
		ECHO CALL :ALL passed
	) ELSE (
		ECHO CALL :ALL failed
	)
) else (
	FOR %%i IN (%*) DO (
		CALL :_CHECK_LABEL %%i
		IF NOT "!ERRORLEVEL!" == "0" (
			ECHO ERROR: no such label, "%%i"
			GOTO :_FINISHED
		)
		
		CALL :%%i
		IF "!ERRORLEVEL!" == "0" (
			ECHO CALL :%%i passed
		) ELSE (
			ECHO CALL :%%i failed
			GOTO :_FINISHED
		)
	)
)

:_FINISHED
SET RETVAL=!ERRORLEVEL!
ENDLOCAL & SET RETVAL=!RETVAL!
@ECHO ON
@EXIT /B !RETVAL!

REM ===============================
REM === All
REM ===============================
:ALL
ECHO %DATE%%TIME% %0 (%~dpnx0)
CALL :BUILD
GOTO :EOF

REM ===============================
REM === Configure
REM ===============================
:CONFIGURE
ECHO %DATE%%TIME% %0 (%~dpnx0)
RMDIR /S /Q !BUILD_DIR!
MD !BUILD_DIR!
CD !BUILD_DIR!
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="" ..
CD !TOP_DIR!

GOTO :EOF

REM ===============================
REM === Config
REM ===============================
:Config
CALL :CONFIGURE
GOTO :EOF

REM ===============================
REM === Build
REM ===============================
:BUILD
ECHO %DATE%%TIME% %0 (%~dpnx0)
gmake -C !BUILD_DIR!
GOTO :EOF

REM ===============================
REM === Test
REM ===============================
:TEST
ECHO %DATE%%TIME% %0 (%~dpnx0)
gmake -C !BUILD_DIR! test
GOTO :EOF

REM ===============================
REM === Install
REM ===============================
:INSTALL
ECHO %DATE%%TIME% %0 (%~dpnx0)
RMDIR /Q /S !TOP_DIR!\dest
gmake -C !BUILD_DIR! install DESTDIR=!TOP_DIR!\!BUILD_DIR!\dest\hello-0.0.1\usr
GOTO :EOF

REM ===============================
REM === Package
REM ===============================
:PACKAGE
ECHO %DATE%%TIME% %0 (%~dpnx0)
gmake -C !BUILD_DIR! package
GOTO :EOF

REM ===============================
REM === Package
REM ===============================
:PACKAGE
ECHO %DATE%%TIME% %0 (%~dpnx0)
gmake -C !BUILD_DIR! package
GOTO :EOF

REM ===============================
REM === Upload
REM ===============================
:UPLOAD
ECHO %DATE%%TIME% %0 (%~dpnx0)
gmake -C !BUILD_DIR! upload
GOTO :EOF

REM ===============================
REM === Publish
REM ===============================
:PUBLISH
ECHO %DATE%%TIME% %0 (%~dpnx0)
IF NOT DEFINED JOB_NAME (
	SET JOB_NAME=Manual
)

IF NOT DEFINED BUILD_NUMBER (
	SET BUILD_NUMBER=1
)

gmake -C !BUILD_DIR! publish
GOTO :EOF

REM ===============================
REM === Clean
REM ===============================
:CLEAN
ECHO %DATE%%TIME% %0 (%~dpnx0)
GOTO :EOF

REM ===============================
REM === DEFAULT
REM ===============================
:_DEFAULT
ECHO %DATE%%TIME% %0 (%~dpnx0)
make %1
GOTO :EOF

REM ===============================
REM === _CHECK_LABEL
REM ===============================
:_CHECK_LABEL
FINDSTR /I /R /C:"^[ ]*:%1\>" "%~f0" >NUL 2>NUL
EXIT /B !ERRORLEVEL!
