#!/bin/bash

apk add --no-cache --upgrade apt 
apk add --no-cache --upgrade unzip
apk add --no-cache --upgrade jq
apk add --no-cache --upgrade curl

GITHUB_PACKAGE=LunaMultiplayer/LunaMultiplayer
export HOME=/server
cd $HOME

## get release info and download links
LATEST_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/${GITHUB_PACKAGE}/releases/latest | jq .tag_name)
LATEST_VERSION_TAG=$(echo $LATEST_VERSION | sed 's/^.//' | sed 's/.$//')
echo -e "Latest release is $LATEST_VERSION_TAG"

DOWNLOAD_LINK="https://github.com/${GITHUB_PACKAGE}/releases/download/$LATEST_VERSION_TAG/LunaMultiplayer-Server-Release.zip"

echo -e "
Downloading from $DOWNLOAD_LINK"
curl -L $DOWNLOAD_LINK -o LunaMultiplayer-Server-Release.zip

unzip LunaMultiplayer-Server-Release.zip
rm LunaMultiplayer-Server-Release.zip
cd LMPServer
dotnet Server.dll

echo -e "Installed sucessfully"",
