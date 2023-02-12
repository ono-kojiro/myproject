@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM ŠÂ‹«•Ï”PATH‚ðsystem32‚Ì‚Ý‚ÉÝ’è‚µ‚ÄŠÂ‹«‚ð‰Šú‰»‚·‚é
SET PATH=%SYSTEMROOT%\system32

CALL config.bat

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
gmake
GOTO :EOF

REM ===============================
REM === Test
REM ===============================
:TEST
ECHO %DATE%%TIME% %0 (%~dpnx0)
gmake test
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
