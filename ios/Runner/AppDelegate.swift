import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
import FirebaseCore
import webview_flutter_wkwebview

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
        // FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyBGzvgMMKwPBAANTwaoRsAnrCpiWCj8wVs")
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

// Handle remote notification registration.
override func application(_ application: UIApplication,
                 didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
    // Forward the token to your provider, using a custom method.
    enableRemoteNotificationFeatures()
    forwardTokenToServer(token: deviceToken)
}
 
override func application(_ application: UIApplication,
                 didFailToRegisterForRemoteNotificationsWithError error: Error) {
    // The token is not currently available.
    print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
    disableRemoteNotificationFeatures()
}
}


extension AppDelegate {
  func enableRemoteNotificationFeatures(){

  }
  func disableRemoteNotificationFeatures(){

  }
  func forwardTokenToServer(token: Data){

  }
}

