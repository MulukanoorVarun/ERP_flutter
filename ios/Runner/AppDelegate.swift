import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyBGzvgMMKwPBAANTwaoRsAnrCpiWCj8wVs")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
