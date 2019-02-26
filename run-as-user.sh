#!/usr/bin/env bash

set -eu

WORK_DIR="/home/mxnetuser/app"

NEW_UID=$(stat -c '%u' ${WORK_DIR})
NEW_GID=$(stat -c '%g' ${WORK_DIR})

groupmod -g "$NEW_GID" -o mxnetuser >/dev/null 2>&1
usermod -u "$NEW_UID" -o mxnetuser >/dev/null 2>&1

exec chpst -u mxnetuser:mxnetuser:sudo -U mxnetuser:mxnetuser env HOME="/home/mxnetuser" "$@"
