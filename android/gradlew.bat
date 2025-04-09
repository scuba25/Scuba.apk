@REM
@REM Copyright 2016 the original author or authors.
@REM
@REM Licensed under the Apache License, Version 2.0 (the "License");
@REM you may not use this file except in compliance with the License.
@REM You may obtain a copy of the License at
@REM
@REM      http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing, software
@REM distributed under the License is distributed on an "AS IS" BASIS,
@REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM See the License for the specific language governing permissions and
@REM limitations under the License.
@REM

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  Gradle startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the environment variables which may be set FOR /F
@setlocal

@rem Find Gradle home directory. Either it is set via GRADLE_HOME environment variable
@rem or we search upwards starting from the location of this script.
@set GRADLE_HOME=
if "%GRADLE_HOME%" == "" (
  set PWD=%CD%
  setlocal enabledelayedexpansion
  :findGradleHome
  if exist "%PWD%\gradle\bin\gradle" (
    endlocal
    set GRADLE_HOME=%PWD%\gradle
    goto init
  )
  cd ..
  set PWD=%CD%
  if "%PWD%" == "\" goto fail
  if "!PWD!" == "!CD!" goto fail
  goto findGradleHome
  :fail
  endlocal
  echo.
  echo ERROR: Could not find Gradle distribution within this project.
  echo        Please either
  echo          - add a gradle wrapper to your project using the "gradle wrapper" task
  echo          - set the GRADLE_HOME environment variable pointing to your Gradle installation
  echo.
  goto end
)

:init
@rem Check minimum version of Java is available
@rem The Gradle wrapper گردانده شده with Gradle 1.0-rc-1 or newer.
if "%JAVA_HOME%" == "" (
  for /f "tokens=*" %%i in ('java -version 2>&1') do (
    echo %%i|findstr /i "java version" > nul
    if errorlevel 0 set foundJava=Y
  )
) else (
  if exist "%JAVA_HOME%\bin\java.exe" (
    set foundJava=Y
  )
)
if not defined foundJava goto noJava

@rem Set command line arguments for Gradle
set CMD_LINE_ARGS=
@rem Skip the first argument if it is equal to //NOLOGO
if /i "%1" == "//NOLOGO" (
  set ARG_SKIP=1
)

:setArgs
@rem Add arguments to the command line for Gradle
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %*

@rem Launch Gradle
:launch
if "%GRADLE_HOME%" == "" (
  "%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% -classpath "%APP_HOME%\gradle\wrapper\gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain %CMD_LINE_ARGS%
) else (
  "%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% -classpath "%GRADLE_HOME%\lib\gradle-launcher-*.jar" org.gradle.launcher.GradleMain %CMD_LINE_ARGS%
)
goto end

:noJava
echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME environment variable to match the location of your Java installation.
echo.
goto end

:end
@rem End local scope for the environment variables which may be set FOR /F
@endlocal
@goto :eof
