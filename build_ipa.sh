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
# Latest version can be found at http://www.nixcraft.com/
# Tested on OSX (10.9)
# 
# Copyright (c) 2013 Hays Clark
# 

EXPORT_APP_PATH="Export/ios/build/Release-iphoneos/"
if [ ! -d "$EXPORT_APP_PATH" ]; then
	echo "Can not find iOS project. Try 'openfl build ios'"
	exit 1;
fi

VERSION=1.0
OPEN_DIR=0
HAD_ARGS=0
APP_NAME=""
ICONS_DIR=""
EXPECTED_FLAGS="[-v] [-h] [-f] [-i icondir] [-o outputfile]"
while getopts "vhfi:o:" VALUE "$@" ; do
	if [ "$VALUE" = "v" ] ; then
		echo Version $VERSION
		exit 0
	fi
	if [ "$VALUE" = "h" ] ; then
		echo usage: build_ipa.sh $EXPECTED_FLAGS
		echo
		echo "Options"
		echo " -v               		show version"
		echo " -i               		dir of files that will be copied into IPA such as icons"
		echo " -o                 		force the output name of IPA"
		echo "(-h)                 		show this help"
		exit 0
	fi
	if [ "$VALUE" = "f" ] ; then
		OPEN_DIR=1
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

if [ "$APP_NAME" = "" ]; then
	#is there a better way?
	APP_FILE=$(find $EXPORT_APP_PATH -type f | grep -o '.*app' | head -1)
	APP_BASENAME=$(basename $APP_FILE)
	APP_NAME=${APP_BASENAME%.*}
fi

IPA_PATH=$APP_NAME.ipa
echo "Building "$IPA_PATH

SEARCH=$EXPORT_APP_PATH*.app

if [ -d "Payload" ]; then
	echo " - removing existing export path: Payload"
	rm -rf Payload
fi

mkdir Payload
APP_DIR=Payload/$APP_BASENAME/

cp -rp $SEARCH Payload/

if [ !"$ICONS_DIR" = "" ]; then
	cp -a ios/. $APP_DIR

	if [ -f $APP_DIR"iTunesArtwork.png" ]; then
		echo " - removing .png suffix from iTunesArtwork"
		mv $APP_DIR/iTunesArtwork.png $APP_DIR/iTunesArtwork
	fi
fi

zip -r --quiet $IPA_PATH Payload
rm -rf Payload

if [ $OPEN_DIR = 1 ]; then
	open .
fi