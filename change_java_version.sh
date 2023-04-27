#!/bin/bash
if [ $# -ne 1 ]
then
    echo "Missing arg: java version"
    exit 1
fi

JAVA_VERSION=$1

sed -i -E "s@<maven.compiler.(source|target)>[0-9]+</maven.compiler.(source|target)>@<maven.compiler.\1>${JAVA_VERSION}</maven.compiler.\2>@" pom.xml 