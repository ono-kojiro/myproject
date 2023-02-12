SET PERL_ROOT=C:\opt\strawberry-perl-5.32.1.1-64bit-portable

IF EXIST %PERL_ROOT%\portableshell.bat (
	CALL %PERL_ROOT%\portableshell.bat /SETENV
) ELSE (
	ECHO ERROR: no such directory, %PERL_ROOT%
	EXIT /B 1
)

SET PYTHON_ROOT=C:\opt\python-3.11.2-embed-amd64

IF EXIST %PYTHON_ROOT% (
	SET PATH%PYTHON_ROOT%;%PYTHON_ROOT%\Scripts;%PATH%
) ELSE (
	ECHO ERROR: no such directory, %PYTHON_ROOT%
	EXIT /B 1
)

SET DEBUG=1
