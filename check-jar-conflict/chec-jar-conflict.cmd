@REM ----------------------------------------------------------------------------
@REM check jar conflict
@REM
@REM this script use to find class confict in java jars
@REM
@REM Required ENV vars:
@REM JAVA_HOME - location of a JDK Home directory
@REM
@REM usage:
@REM chcek_jar_conflict.cmd <jars dir> <class name>
@REM 
@REM author: taly.w.y@gmail.com
@REM date: 2018/4/4
@REM ----------------------------------------------------------------------------

@echo off

@REM ==== START VALIDATION ====
if not "%JAVA_HOME%" == "" goto OkJHome

echo.
echo Error: JAVA_HOME not found in your environment. >&2
echo Please set the JAVA_HOME variable in your environment to match the >&2
echo location of your Java installation. >&2
echo.
goto error

:OkJHome
if exist "%JAVA_HOME%\bin\jar.exe" goto init

echo.
echo Error: JAVA_HOME is set to an invalid directory. >&2
echo JAVA_HOME = "%JAVA_HOME%" >&2
echo Please set the JAVA_HOME variable in your environment to match the >&2
echo location of your Java installation. >&2
echo.
goto error

:init
set JAR_EXE="%JAVA_HOME%\bin\jar.exe"
set JARS_DIR=%1
set CHECK_CLASS_NAME= %2

if not exist %JARS_DIR% goto error_dir 

echo beign to search
echo. 
 
for /R %JARS_DIR% %%s in (*.jar) do ( 
	%JAR_EXE% -tvf %%s | findstr %CHECK_CLASS_NAME%
	if not errorlevel 1 (	
		echo %%s 
		echo.
	)
)

echo search end...
goto end

:error_dir
echo ERROR: %JARS_DIR% is not a valid directory, pleass check...
goto error

:error
set ERROR_CODE=1

exit /B %ERROR_CODE%

:end
exit /B 0

