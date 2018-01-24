#!/usr/bin/env bash
nohup java -Dspring.profiles.active=$2 -jar $1 1>/dev/null 2>&1 &