(cd packages/app/ios || exit 1; pod install)
(cd packages/app/ios || exit 1; fastlane release)

#(cd packages/app/ios; fastlane prodrelease)