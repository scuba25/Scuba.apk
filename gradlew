#!/usr/bin/env bash
#
# Copyright 2016 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=""

# Use the supplied Gradle installation.
USE_CLASSPATH="NO"

# Set the Gradle user home directory. By default it uses the user's home directory.
#GRADLE_USER_HOME=

# Set the maximum Java heap size used for Gradle build processes. The default is 1g.
#GRADLE_OPTS="-Xmx2g"

export JAVA_HOME

APP_BASE_NAME=`basename "$0"`
DIRNAME=`dirname "$0"`

# OS specific support (must be 'cygwin', 'darwin', 'os2', 'os/400', 'hpux', 'aix', 'linux', 'sunos')
case "`uname -s`" in
  cygwin*)
    cygwin=true
    ;;
  darwin*)
    darwin=true
    ;;
  os2*)
    os2=true
    ;;
  os/400*)
    os400=true
    ;;
  hpux*)
    hpux=true
    ;;
  aix*)
    aix=true
    ;;
  linux*)
    linux=true
    ;;
  sunos*)
    sunos=true
    ;;
  *)
    ;;
esac

if [ -n "$JAVA_HOME" ]; then
  if [ ! -x "$JAVA_HOME/bin/java" ]; then
    echo "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME"
    echo "Please set the JAVA_HOME variable in your environment to match the"
    echo "location of your Java installation."
    exit 1
  fi
fi

# For Cygwin, ensure path is in UNIX format before using it
if
fi

# Change current directory to where the script is located
cd "$DIRNAME"

# Find the best way to run java
if [ -n "$JAVA_HOME" ]; then
  RUN_JAVA="$JAVA_HOME/bin/java"
else
  if [ -n "`which java`" ]; then
    RUN_JAVA="java"
  else
    echo "ERROR: Neither JAVA_HOME nor java command in PATH found"
    echo "Please set the JAVA_HOME variable in your environment to match the"
    echo "location of your Java installation."
    exit 1
  fi
fi

# Increase maxPermSize for running Gradle under Java 8
case "`$RUN_JAVA -version 2>&1 | head -n 1`" in
  *"version \"1.8."*)
    DEFAULT_JVM_OPTS="$DEFAULT_JVM_OPTS -XX:MaxPermSize=256m"
    ;;
esac

# Collect JVM options and arguments for Gradle
JVM_OPTS="$DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS"
ARGS=""

# Add arguments passed to this script
for ARG in "$@"; do
  ARGS="$ARGS \"$ARG\""
done

# Determine the classpath for running Gradle
if [ "$USE_CLASSPATH" = "YES" ]; then
  CLASSPATH=$(ls -d "$DIRNAME/gradle/lib/"*.jar | tr '\n' ':')
  CLASSPATH="$CLASSPATH$(ls -d "$DIRNAME/gradle/lib/plugins/"*.jar | tr '\n' ':')"
  RUN_ARGS="$RUN_JAVA $JVM_OPTS -classpath \"$CLASSPATH\" org.gradle.launcher.GradleMain $ARGS"
else
  RUN_ARGS="$RUN_JAVA $JVM_OPTS -Dorg.gradle.appname=\"$APP_BASE_NAME\" -classpath \"$DIRNAME/gradle/wrapper/gradle-wrapper.jar\" org.gradle.wrapper.GradleWrapperMain $ARGS"
fi

# Execute Gradle
eval exec "$RUN_ARGS"
