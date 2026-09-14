PWD=$(pwd)

GREY=$'\033[38;5;254m'
BLUE=$'\033[38;5;27m'
GREEN=$'\e[0;32m'

ENV_ARG=$1

if [[ "$ENV_ARG" == "" ]]
then
    echo "Env '$ENV_ARG' not supported"
    exit 1
fi

APP="$PWD/packages/app"
SRC="$APP/env/$ENV_ARG"

# Set bundleId

echo branch "$ENV_ARG" -src $SRC

# copy env file to app folder
cp "$SRC/app_variables.env" "$APP/assets/env/"

export $(cat "$SRC/app_config.env" | xargs)

#####  IOS

echo "${GREY}"
echo "------------------------------------------------"
echo "Updating iOS app"
echo "PRODUCT_BUNDLE_IDENTIFIER=$IOS_BUNDLE_ID"

sed -i "" "s/\(PRODUCT_BUNDLE_IDENTIFIER = \)\(.*\)\(;\)/\1$IOS_BUNDLE_ID\3/" "$APP/ios/Runner.xcodeproj/project.pbxproj"
sed -i "" "/<key>CFBundleName<\/key>/ {n;s/<string>[^<]*<\/string>/<string>$APP_NAME<\/string>/;}" "$APP/ios/Runner/Info.plist"
cp "$SRC/firebase/GoogleService-Info.plist" "$APP/ios/Runner/"

#####  ANDROID
echo "${GREEN}"
echo "------------------------------------------------"
echo "Updating Android app"
echo "applicationId=$ANDROID_PACKAGE_NAME"

sed -i "" "s/\(applicationId \"\)\(.*\)\(\"\)/\1$ANDROID_PACKAGE_NAME\3/" "$APP/android/app/build.gradle"
sed -i "" "s/\(android:label=\"\)\(.*\)\(\"\)/\1$APP_NAME\3/" "$APP/android/app/src/main/AndroidManifest.xml"
cp "$SRC/firebase/google-services.json" "$APP/android/app/"

#####  WEB

echo "${BLUE}"
echo "------------------------------------------------"
echo "Updating Web app"

cp "$SRC/firebase/firebase_web_config.dart" "$APP/lib/bootstrap/firebase"
cp "$SRC/firebase/.firebaserc" "."
cp "$SRC/firebase/firebase.json" "."