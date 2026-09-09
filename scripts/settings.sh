#!/usr/bin/env bash

set -eu

PLUGIN_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)"

export DRUDWYN_PLUGIN_DIR="$PLUGIN_DIR"
exec "$PLUGIN_DIR/scripts/v2.sh" settings
