#!/bin/sh

#  ci-script.bash
#  CityFinder
#
#  Created by Manali Mogre on 11/08/2020.
#  Copyright © 2020 Manali Mogre. All rights reserved.

# Development
openssl aes-256-cbc -k "$SECURITY_PASSWORD" -in scripts/certs/development-cert.cer.enc -d -a -out scripts/certs/development-cert.cer
openssl aes-256-cbc -k "$SECURITY_PASSWORD" -in scripts/certs/development-key.p12.enc -d -a -out scripts/certs/development-key.p12
openssl aes-256-cbc -k "$SECURITY_PASSWORD" -in scripts/provisioning-profile/development-provisioning-profile.mobileprovision.enc -d -a -out scripts/provisioning-profile/development-provisioning-profile.mobileprovision
# Distribution
openssl aes-256-cbc -k "$SECURITY_PASSWORD" -in scripts/certs/distribution-cert.cer.enc -d -a -out scripts/certs/distribution-cert.cer
openssl aes-256-cbc -k "$SECURITY_PASSWORD" -in scripts/certs/distribution-key.p12.enc -d -a -out scripts/certs/distribution-key.p12
openssl aes-256-cbc -k "$SECURITY_PASSWORD" -in scripts/provisioning-profile/distribution-provisioning-profile.mobileprovision.enc -d -a -out scripts/provisioning-profile/distribution-provisioning-profile.mobileprovision

# Create custom keychain
security create-keychain -p $CUSTOM_KEYCHAIN_PASSWORD ios-build.keychain
# Make the ios-build.keychain default, so xcodebuild will use it
security default-keychain -s ios-build.keychain
# Unlock the keychain
security unlock-keychain -p $CUSTOM_KEYCHAIN_PASSWORD ios-build.keychain
# Set keychain timeout to 1 hour for long builds
# see here
security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain


security import ./scripts/certs/AppleWWDRCA.cer -k ios-build.keychain -A
security import ./scripts/certs/development-cert.cer -k ios-build.keychain -A
security import ./scripts/certs/development-key.p12 -k ios-build.keychain -P $SECURITY_PASSWORD -A
security import ./scripts/certs/distribution-cert.cer -k ios-build.keychain -A
security import ./scripts/certs/distribution-key.p12 -k ios-build.keychain -P $SECURITY_PASSWORD -A
# Fix for OS X Sierra that hungs in the codesign step
security set-key-partition-list -S apple-tool:,apple: -s -k $SECURITY_PASSWORD ios-build.keychain > /dev/null

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp "./scripts/provisioning-profile/development-provisioning-profile.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
cp "./scripts/provisioning-profile/distribution-provisioning-profile.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/

xcodebuild archive -project ManaliSingh27/CityFinder.xcodeproj -scheme CityFinder Release -derivedDataPath ./build -archivePath ./build/Products/CityFinder.xcarchive