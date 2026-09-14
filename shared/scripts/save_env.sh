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

echo "${GREEN}"
echo branch "$ENV_ARG" -src $SRC

# copy env file to app folder
cp "$APP/assets/env/app_variables.env" "$SRC/"

export $(cat "$SRC/app_config.env" | xargs)

#####  IOS

echo "${GREY}"
echo "------------------------------------------------"
echo "Saving iOS app"

cp "$SRC/firebase/GoogleService-Info.plist" "$APP/ios/Runner/"

#####  ANDROID

echo "${GREEN}"
echo "------------------------------------------------"
echo "Saving Android app"

cp "$APP/android/app/google-services.json" "$SRC/firebase/"

#####  WEB

echo "${BLUE}"
echo "------------------------------------------------"
echo "Saving Web app"

cp "$APP/lib/bootstrap/firebase/firebase_web_config.dart" "$SRC/firebase/"
cp "./.firebaserc" "$SRC/firebase/"
cp "./firebase.json" "$SRC/firebase/"




