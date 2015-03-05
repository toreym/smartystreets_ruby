#!/bin/bash

DIR="$(cd "$(dirname "${0}")" && pwd)"
cd "${DIR}"

echo "FOO: ${FOO}"
echo "pwd: $(pwd)"
echo "1: ${1}"
echo "${FOO}" > "${DIR}/../${1}"
