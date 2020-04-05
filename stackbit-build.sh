#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e892708e6d47f0019bfc1bb/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e892708e6d47f0019bfc1bb 
fi
curl -s -X POST https://api.stackbit.com/project/5e892708e6d47f0019bfc1bb/webhook/build/ssgbuild > /dev/null
make prepare && hugo --source demo --baseURL "/"

curl -s -X POST https://api.stackbit.com/project/5e892708e6d47f0019bfc1bb/webhook/build/publish > /dev/null
