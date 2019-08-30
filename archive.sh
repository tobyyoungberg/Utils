#!/bin/bash

# Delete the existing archives or you can't create new ones
rm -rf build

# Archive a framework for each architecture.  Be sure that BUILD_LIBRARIES_FOR_DISTRIBUTION is yes or binary compatibility won't work.
xcodebuild archive -scheme Utils -destination="iOS" -archivePath build/ios.xcarchive -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
xcodebuild archive -scheme Utils -destination="iOS Simulator" -archivePath build/iossimulator.xcarchive -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

# Bundle together a new xcframework with the archives for each architecture
xcodebuild -create-xcframework -framework build/ios.xcarchive/Products/Library/Frameworks/Utils.framework -framework build/iossimulator.xcarchive/Products/Library/Frameworks/Utils.framework -output build/Carthage/Build/iOS/Utils.xcframework

# Get rid of the intermediary xcarchive files
rm -rf build/*.xcarchive

cd build

zip -r ../Utils.xcframework.zip Carthage/*

cd ..

rm -rf build

# Open the directory of the finished archive
open .