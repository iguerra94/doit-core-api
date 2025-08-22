#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

bash ./scripts/build.sh

# Set Java options for the application
JAVA_OPTS="-Dfile.encoding=UTF-8 \
           -Dsun.stdout.encoding=UTF-8 \
           -Dsun.stderr.encoding=UTF-8 \
           -Dspring.output.ansi.enabled=always"

# Build the classpath from Maven dependencies
CLASSPATH="../..target/classes:$(./mvnw -q exec:exec -Dexec.executable=echo -Dexec.args='%classpath')"

# Run the application
java $JAVA_OPTS \
     -classpath $CLASSPATH \
     com.doit.core_api.DoItCoreApiApplication
