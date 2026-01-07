// import Flutter
// import UIKit

// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
var leakedObserver: NSObjectProtocol?


override func application(
_ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
let channel = FlutterMethodChannel(name: "memory_leak/native_ios",
binaryMessenger: controller.binaryMessenger)
channel.setMethodCallHandler { [weak self] (call, result) in
switch call.method {
case "startLeak":
// add notification observer and keep strong ref -> leak
self?.leakedObserver = NotificationCenter.default.addObserver(forName: UIDevice.batteryLevelDidChangeNotification, object: nil, queue: .main) { _ in }
result(nil)
case "stopLeak":
if let obs = self?.leakedObserver {
NotificationCenter.default.removeObserver(obs)
self?.leakedObserver = nil
}
result(nil)
default:
result(FlutterMethodNotImplemented)
}
}


GeneratedPluginRegistrant.register(with: self)
return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
}
