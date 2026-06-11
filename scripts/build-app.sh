#!/bin/sh

set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
ARM_BUILD_DIR="$ROOT/.build-universal/arm64"
INTEL_BUILD_DIR="$ROOT/.build-universal/x86_64"
APP_DIR="$ROOT/dist/FocusC.app"

cd "$ROOT"
swift build \
    -c release \
    --scratch-path "$ARM_BUILD_DIR" \
    --triple arm64-apple-macosx12.0 \
    "$@"
swift build \
    -c release \
    --scratch-path "$INTEL_BUILD_DIR" \
    --triple x86_64-apple-macosx12.0 \
    "$@"

rm -rf "$APP_DIR"
mkdir -p "$APP_DIR/Contents/MacOS" "$APP_DIR/Contents/Resources"
lipo -create \
    "$ARM_BUILD_DIR/arm64-apple-macosx/release/FocusC" \
    "$INTEL_BUILD_DIR/x86_64-apple-macosx/release/FocusC" \
    -output "$APP_DIR/Contents/MacOS/FocusC"
cp "$ROOT/Resources/Info.plist" "$APP_DIR/Contents/Info.plist"
codesign --force --sign - "$APP_DIR"

echo "Built $APP_DIR"
