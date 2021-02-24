#!/bin/sh

DIR=`cd "\`dirname "$0"\`" && pwd -P`

source "$DIR/../lib.sh"

echo ">>>> firefox start"

if [ `uname` == "Darwin" ]; then
  FIREFOX_BIN=/Applications/Firefox.app/Contents/MacOS/firefox-bin
  FIREFOX_PROFILE_DIR=~/Library/Application\ Support/Firefox/Profiles
# TODO test this
elif [ `uname` == "Linux" ]; then
  FIREFOX_BIN=/usr/bin/firefox
  FIREFOX_PROFILE_DIR=~/.mozilla/firefox
  echo ">>>> linux is untested, trying anyway"
else
  echo ">>>> unsupported operating system"
  echo ">>>> firefox end"
  exit 1
fi

echo ">>>> firefox binary $FIREFOX_BIN"
echo ">>>> firefox profile directory $FIREFOX_PROFILE_DIR"

echo ">>>> running firefox... window will open"
"$FIREFOX_BIN" &>/dev/null &

DEFAULT_PROFILE_NAME=default-release
FIREFOX_PROFILE=`echo "$FIREFOX_PROFILE_DIR"/*."$DEFAULT_PROFILE_NAME"*`
while [ ! -d "$FIREFOX_PROFILE" ]
do
  echo ">>>> waiting for firefox profile to be created..."
  sleep 1
  FIREFOX_PROFILE=`echo "$FIREFOX_PROFILE_DIR"/*.$DEFAULT_PROFILE_NAME`
done
echo ">>>> firefox profile $FIREFOX_PROFILE"

echo ">>>> downloading uBlock and uMatrix"
TMP_DIR=`mktemp -d`

wget --quiet https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/ublock-origin.xpi -P "$TMP_DIR/"
STATUS=$?
if [ $STATUS -ne 0 ]; then
  echo ">>>> error downloading uBlock"
else
  UBLOCK_XPI="$TMP_DIR/ublock-origin.xpi"
fi

wget --quiet https://addons.mozilla.org/firefox/downloads/latest/umatrix/umatrix.xpi -P "$TMP_DIR/"
STATUS=$?
if [ $STATUS -ne 0 ]; then
  echo ">>>> error downloading uMatrix"
else
  UMATRIX_XPI="$TMP_DIR/umatrix.xpi"
fi

echo ">>>> installing uBlock and uMatrix... confirm install in firefox ui"
"$FIREFOX_BIN" "$UBLOCK_XPI" "$UMATRIX_XPI" &>/dev/null &

echo ">>>> installing user.js"
link_with_backup "$DIR/user.js" "$FIREFOX_PROFILE/user.js"

echo ">>>> installing userChrome.css"
mkdir "$FIREFOX_PROFILE/chrome"
link_with_backup "$DIR/userChrome.css" "$FIREFOX_PROFILE/chrome/userChrome.css"

echo ">>>> changing default search to DuckDuckGo"
while [ ! -f "$FIREFOX_PROFILE/search.json.mozlz4" ]
do
  echo ">>>> waiting for search.json.mozlz4 to be created..."
  sleep 1
done

# https://github.com/mozilla/gecko-dev/blob/a26e2b6eca4d32e448338ef8833982483e570279/toolkit/components/search/SearchService.jsm#L2911
# https://github.com/mozilla/gecko-dev/blob/a26e2b6eca4d32e448338ef8833982483e570279/toolkit/components/search/SearchCache.jsm#L274
# https://github.com/mozilla/gecko-dev/blob/a26e2b6eca4d32e448338ef8833982483e570279/toolkit/components/search/SearchUtils.jsm#L275
PROFILE_BASE=`basename $FIREFOX_PROFILE`
SEARCH_PROVIDER=DuckDuckGo
HASH_DISCLAIMER="By modifying this file, I agree that I am doing so only within \
Firefox itself, using official, user-driven search engine selection processes, \
and in a way which does not circumvent user consent. I acknowledge that any \
attempt to change this file from outside of Firefox is a malicious act, and \
will be responded to accordingly."
HASH=`printf "$PROFILE_BASE$SEARCH_PROVIDER$HASH_DISCLAIMER" | openssl sha256 -binary | base64`
echo ">>>> hash for modifying default search is $HASH"

# decompress search.json
echo ">>>> python tool for editing search search.json.mozlz4 requires module lz4"
pip3 install lz4
"$DIR/mozlz4tool.py" -d "$FIREFOX_PROFILE/search.json.mozlz4" "$TMP_DIR/search.json"
# escape replacement string for sed command
SED_REPLACEMENT_STRING=",\"current\":\"$SEARCH_PROVIDER\",\"hash\":\"$HASH\"}}"
# extra backslash because of subshell
ESCAPED_SED_REPLACEMENT_STRING=`echo "$SED_REPLACEMENT_STRING" | sed -e 's/[\/&]/\\\&/g'`
# match last line, replace last two }} characters with the replacement string
sed -i.bak "$ s/}}\$/$ESCAPED_SED_REPLACEMENT_STRING/" "$TMP_DIR/search.json"
# recompress search.json into the profile
"$DIR/mozlz4tool.py" "$TMP_DIR/search.json" "$FIREFOX_PROFILE/search.json.mozlz4"

echo ">>>> firefox end... kill all firefox processes and restart for effect"
