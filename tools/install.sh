#!/bin/sh

#
# Copyright (2019) Petr Ospalý <petr@ospalax.cz>
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

set -e

# Installation artifacts
BUILD_DIR="$1" # mandatory first argument to this script
BUILD_ARTIFACTS="bin/baka lib/libbaka.a"

# Executor's target
EXECUTOR_TARGET=baka-manager.sh

#
# functions
#

# arg: <path to script>
install_executor_script()
{
    _baka_script="$1"

    cat > "$_baka_script" <<EOF
#!/bin/sh

# executor script for baka tool - to simplify installation

set -e

if [ -f ${BAKA_CONFIG} ] ; then
    . ${BAKA_CONFIG}
else
    echo 'ERROR: It seems that baka is not installed!' 1>&2
    echo "       No '${BAKA_CONFIG}'" 1>&2
    exit 1
fi

export BAKA_HOME
export BAKA_CONFIG

exec "\${BAKA_HOME}/bin/${EXECUTOR_TARGET}" "\$@"

EOF

    chmod 0755 "$_baka_script"
}

#
# main
#

# some sanity checks

if [ -z "$BUILD_DIR" ] ; then
    echo "ERROR: This script needs a path to the build artifacts" 1>&2
    exit 1
fi

for i in ${BUILD_ARTIFACTS} ; do
    if ! [ -f "${BUILD_DIR}/${i}" ] ; then
        echo "ERROR: Build artifact '${BUILD_DIR}/${i}' does not exist" 1>&2
        exit 1
    fi
done

# install files and directories

# expand values first
_BAKA_HOME=$(eval "echo ${BAKA_HOME}")
_BAKA_CONFIG=$(eval "echo ${BAKA_CONFIG}")
_BAKA_SCRIPT=$(eval "echo ${BAKA_SCRIPT}")

# get parent directories for ordinary files
_BAKA_CONFIG_DIR=$(dirname "$_BAKA_CONFIG")
_BAKA_SCRIPT_DIR=$(dirname "$_BAKA_SCRIPT")

# install artifacts
echo "INFO: Create baka installation directory: ${_BAKA_HOME}"
mkdir -p "$_BAKA_HOME"

echo "INFO: Install build artifacts..."
cp -av "$BUILD_DIR"/bin "$BUILD_DIR"/lib "$_BAKA_HOME"/

# install executor target
echo "INFO: Install main baka script: ${EXECUTOR_TARGET}"
cp -av "tools/${EXECUTOR_TARGET}" "$_BAKA_HOME"/bin/

# install wrapper script
echo "INFO: Create baka executor script directory: ${_BAKA_SCRIPT_DIR}"
mkdir -p "$_BAKA_SCRIPT_DIR"

echo "INFO: Install executor script: ${_BAKA_SCRIPT}"
install_executor_script "$_BAKA_SCRIPT"

# store all information into config file

echo "INFO: Create baka config directory: ${_BAKA_CONFIG_DIR}"
mkdir -p "$_BAKA_CONFIG_DIR"

echo "INFO: Create config file: ${_BAKA_CONFIG}"

cat > "$_BAKA_CONFIG" <<EOF
# config file for baka tool

#
# compiler setup
#

# C compiler
CC="${CC}"

# C compiler flags
CFLAGS="${CFLAGS}"

# C compiler flag for linked libraries
LIBS="${LIBS}"

# Extra header locations
INCLUDES="${INCLUDES}"

#
# baka specifics
#

# installation directory where bin/ and lib/ are
BAKA_HOME="${_BAKA_HOME}"

# this config file
BAKA_CONFIG="${_BAKA_CONFIG}"

# executor script (wrapper to baka itself)
BAKA_SCRIPT="${_BAKA_SCRIPT}"

EOF

# show config file
cat "${_BAKA_CONFIG}"

echo "INFO: DONE"

exit 0

