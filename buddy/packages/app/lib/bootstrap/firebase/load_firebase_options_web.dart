
import 'package:firebase_core/firebase_core.dart';

part 'firebase_web_config.dart';

final _options = FirebaseOptions(
  apiKey: _config["apiKey"]!,
  appId: _config["appId"]!,
  messagingSenderId: _config["messagingSenderId"]!,
  projectId: _config["projectId"]!,
  authDomain: _config["authDomain"],
  databaseURL: _config["databaseURL"],
  storageBucket: _config["storageBucket"],
  measurementId: _config["measurementId"],
  trackingId: _config["trackingId"],
  deepLinkURLScheme: _config["deepLinkURLScheme"],
  androidClientId: _config["androidClientId"],
  iosClientId: _config["iosClientId"],
  iosBundleId: _config["iosBundleId"],
  appGroupId: _config["appGroupId"],
);

Future<FirebaseOptions?> loadFirebaseOptions() async {
  return _options;
}
