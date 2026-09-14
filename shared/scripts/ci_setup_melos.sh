export PATH=$PATH:/.fvm/flutter_sdk/bin

# shellcheck disable=SC2044
for folder in $(find ~+ -type f -name "melos.yaml" -exec dirname {} \;)
do
  (cd "$folder" || exit; dart pub global activate melos; dart pub add melos --dev)
done




