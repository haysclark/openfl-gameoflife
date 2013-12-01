#!/bin/bash
#
# OpenFL Build to IPA Script iOS 1.0, 2013
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of 
# this software and associated documentation files (the "Software"), to deal in 
# the Software without restriction, including without limitation the rights to 
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
# of the Software, and to permit persons to whom the Software is furnished to do 
# so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all 
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
# SOFTWARE.
# 
# Written by Hays Clark <hays@infinitedescent.com>
# 
# Latest version can be found at https://gist.github.com/haysclark/
# Tested on OSX (10.9)
# 
# Copyright (c) 2013 Hays Clark
# 

NAME="build_ipa"
VERSION=1.0
OPEN_DIR=0
APP_NAME=""
ICONS_DIR=""
BUILD_DIR=""
EXPECTED_FLAGS="[-v] [-h] [-a] [-b builddir] [-i icondir] [-o outputfile]"

while getopts "vhab:i:o:" VALUE "$@" ; do
	if [ "$VALUE" = "v" ] ; then
		echo $NAME version $VERSION
	fi
	if [ "$VALUE" = "h" ] ; then
		echo usage: $NAME $EXPECTED_FLAGS
		echo
		echo "Options"
		echo " -v            	   show version"
		echo " -i            	   set dir of included files to be copied into IPA. ie icons"
		echo " -a            	   auto-open the output folder on complete"
		echo " -o            	   set the output name of IPA"
		echo " -b            	   set location of ios build"
		echo "(-h)           	   show this help"
		exit 0
	fi
	if [ "$VALUE" = "a" ] ; then
		OPEN_DIR=1
	fi
	if [ "$VALUE" = "b" ] ; then
		BUILD_DIR="$OPTARG"
	fi
	if [ "$VALUE" = "o" ] ; then
		APP_NAME="$OPTARG"
	fi
	if [ "$VALUE" = "i" ] ; then
		ICONS_DIR="$OPTARG"
	fi
	if [ "$VALUE" = ":" ] ; then
        echo "Flag -$OPTARG requires an argument."
        echo "Usage: $0 $EXPECTED_FLAGS"
        exit 1
    fi
	if [ "$VALUE" = "?" ] ; then
		echo "Unknown flag -$OPTARG detected."
		echo "Usage: $0 $EXPECTED_FLAGS"
		exit 1
	fi
done

if [ "$BUILD_DIR" = "" ]; then
	BUILD_DIR="Export/ios/build/Release-iphoneos/"
fi

if [ ! -d "$BUILD_DIR" ]; then
	echo $BUILD_DIR" does not exist! Please build project or supply ios build directory."
	echo " -try \"openfl build ios\" first"
	exit 1;
fi

if [ "$APP_NAME" = "" ]; then
	#is there a better way?
	APP_FILE=$(find $BUILD_DIR -type f | grep -o '.*app' | head -1)
	APP_BASENAME=$(basename $APP_FILE)
	APP_NAME=${APP_BASENAME%.*}
fi

IPA_PATH=$APP_NAME.ipa
echo "Building "$IPA_PATH

SEARCH=$BUILD_DIR*.app

if [ -d "Payload" ]; then
	echo " - removing existing export path: Payload"
	rm -rf Payload
fi

mkdir Payload
APP_DIR=Payload/$APP_BASENAME/

cp -rp $SEARCH Payload/

if [ "$ICONS_DIR" != "" ]; then
	cp -a $ICONS_DIR/. $APP_DIR

	if [ -f $APP_DIR"iTunesArtwork.png" ]; then
		echo " - removing .png suffix from iTunesArtwork"
		mv $APP_DIR/iTunesArtwork.png $APP_DIR/iTunesArtwork
	fi
fi

zip -r --quiet $IPA_PATH Payload
rm -rf Payload

if [ "$OPEN_DIR" = 1 ]; then
	open .
fi