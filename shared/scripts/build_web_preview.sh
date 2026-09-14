(cd packages/app || exit; fvm flutter build web --release -t lib/main_preview.dart || exit;)
firebase deploy --only hosting:mooov-dev-preview-app