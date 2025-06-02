#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BUILDSCRIPTS=$SCRIPT_DIR/buildscripts

## Android

# Do not install Android SDK
perl -i -ne 'print unless /# Prepare toolchain/ .. /\[4\]/' $BUILDSCRIPTS/android/1_download_library.sh

# Use system provided Android SDK
perl -pi -e 's/export SDK_ROOT/#export SDK_ROOT/' $BUILDSCRIPTS/android/2_build_toolchain.sh
perl -pi -e 's/export ANDROID_NDK=.*/export ANDROID_NDK=\$NDK_ROOT/' $BUILDSCRIPTS/android/2_build_toolchain.sh

# Do not build the Player APK
perl -pi -e 's/.\/4/#.\/4/' $BUILDSCRIPTS/android/0_build_everything.sh

## Vita

# Do not download the VitaSDK
perl -i -ne 'print unless /\[1\]/ .. /\[2\]/' $BUILDSCRIPTS/vita/1_download_library.sh

# Copy the system provided VitaSDK
echo 'rm -rf vitasdk' >> $BUILDSCRIPTS/vita/1_download_library.sh
echo 'cp -rup /opt/vitasdk $PWD' >> $BUILDSCRIPTS/vita/1_download_library.sh

## Dependencies

# Update meson to latest version (but not on macOS)
if [ "$(uname)" != "Darwin" ]; then
	pip3 config set global.break-system-packages true
	pip3 install --upgrade meson
else
	# iOS: Do not build (useless) SDL2
	perl -pi -e 's/(install_lib.* \$SDL2)/#\1/' $BUILDSCRIPTS/ios/2_build_toolchain.sh
fi

## macOS / iOS: Downgrade ICU to 76
echo 'ICU_URL="https://github.com/unicode-org/icu/releases/download/release-76-1/icu4c-76_1-src.tgz"' > $BUILDSCRIPTS/macos/packages.sh
echo 'ICU_URL="https://github.com/unicode-org/icu/releases/download/release-76-1/icu4c-76_1-src.tgz"' > $BUILDSCRIPTS/ios/packages.sh
