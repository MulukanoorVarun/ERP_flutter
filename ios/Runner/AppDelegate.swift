import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
import FirebaseCore
import webview_flutter_wkwebview
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
        // FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyCA06NWEP5D-z8WpebENgd4mSOqV-uXIUE")
      
      if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
                guard error == nil else {
                    debugPrint("Error: \(error!.localizedDescription)")
                    return
                }
                
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            // Fallback for iOS 9 and below
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
      
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
override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
            // Handle the received notification
            debugPrint("Received notification: \(userInfo)")
}
    
override func application(_ application: UIApplication,
                 didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
    // Forward the token to your provider, using a custom method.s
    enableRemoteNotificationFeatures()
    forwardTokenToServer(token: deviceToken)
}

 
override func application(_ application: UIApplication,
                 didFailToRegisterForRemoteNotificationsWithError error: Error) {
    // The token is not currently available.
    debugPrint("Remote notification support is unavailable due to error: \(error.localizedDescription)")
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

