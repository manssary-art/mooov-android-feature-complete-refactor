import Flutter
import UIKit
import Foundation

public class PlatformTimezonePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "platform_timezone", binaryMessenger: registrar.messenger())
    let instance = PlatformTimezonePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(TimeZone.current.identifier)
  }
}
