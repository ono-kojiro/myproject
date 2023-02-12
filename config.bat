ECHO setting perl...

SET PERL_ROOT=C:\opt\strawberry-perl-5.32.1.1-64bit-portable

IF EXIST %PERL_ROOT%\portableshell.bat (
	CALL %PERL_ROOT%\portableshell.bat /SETENV
) ELSE (
	ECHO ERROR: no such directory, %PERL_ROOT%
	EXIT /B 1
)

ECHO setting python...

SET PYTHON_ROOT=C:\opt\python-3.11.2-embed-amd64

IF EXIST %PYTHON_ROOT% (
	SET PATH=%PYTHON_ROOT%;%PYTHON_ROOT%\Scripts;%PATH%
) ELSE (
	ECHO ERROR: no such directory, %PYTHON_ROOT%
	EXIT /B 1
)

ECHO setting cmake...

SET CMAKE_ROOT=C:\opt\cmake-3.25.2-windows-x86_64
IF EXIST %CMAKE_ROOT% (
	SET PATH=%CMAKE_ROOT%\bin;%PATH%
) ELSE (
	ECHO ERROR: no such directory, %CMAKE_ROOT%
	EXIT /B 1
)

SET DEBUG=1
