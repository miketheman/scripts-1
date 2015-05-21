#!/bin/bash
# Install a custom Go version, https://golang.org/
#
# Add at least the following environment variables to your project configuration
# (otherwise the defaults below will be used).
# * GO_VERSION
#
# Include in your builds via
# \curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/languages/go.sh | bash -s
GO_VERSION=${GO_VERSION:="1.4.2"}


# check required parameters
GOROOT=${GOROOT:?'You need to configure the GOROOT environment variable! Please set it to "/tmp/go"'}
if [ ! $(echo $PATH | grep "$GOROOT/bin") ]; then
	>&2 echo "Please add '$GOOROT/bin' to the beginning of the PATH."
fi

set -e
CACHED_DOWNLOAD="${HOME}/cache/go${GO_VERSION}.linux-amd64.tar.gz"

mkdir -p "${GOROOT}"
wget --continue --output-document "${CACHED_DOWNLOAD}" "https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz"
tar -xaf "${CACHED_DOWNLOAD}" --strip-components=1 --directory "${GOROOT}"
