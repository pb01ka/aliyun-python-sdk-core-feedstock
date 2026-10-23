#!/bin/bash
set -euxo pipefail

$PYTHON -m pip install . -vv

# aliyunsdkcore vendors an old copy of requests whose bundled certifi
# returns a hardcoded path to its own frozen CA bundle (currently dated
# 2018-01-18), ignoring the environment entirely.
# Point it at the bundle the ca-certificates package keeps up to date instead.
VENDORED_CACERT="$SP_DIR/aliyunsdkcore/vendored/requests/packages/certifi/cacert.pem"
rm -f "$VENDORED_CACERT"
ln -s "$PREFIX/ssl/cacert.pem" "$VENDORED_CACERT"
