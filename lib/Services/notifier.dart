// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:pdf/widgets.dart';
//
// class Notifier {
//   Notifier();
//   final _localNotificationService=FlutterLocalNotificationsPlugin();
//
//   Future<void> intialize() async{
//     const AndroidInitializationSettings androidInitializationSettings= AndroidInitializationSettings('@drawable/ic_stat_android');
//
//     // IOSInitializationSettings iOSInitializationSettings=IOSInitializationSettings(
//     // requestAlertPermission: true,
//     // requestBadgePermission: true,
//     // requestSoundPermission: true,
//     // onDidReceiveLocalNotification: onDidReceiveLocalNotification;
//     // );
//
//     final InitializationSettings settings=InitializationSettings(android: androidInitializationSettings);// ,iOS: iOSInitializationSettings )
//     await _localNotificationService.initialize(settings );  //, onSelectNotification:onSelectNotification )
//   }
//
//   Future<NotificationDetails> _notificationDetails() async{
//     const AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
//       'channel_id','channel_name',channelDescription: 'description', importance: Importance.max,priority: Priority.max, playSound: true
//     );
//     // const IOSNotificationDetails iosNotificationDetails=IOSNotificationDetails();
//     return NotificationDetails(android: androidNotificationDetails);
//   }
//
//   Future<void> showNotification(
//   {
//     required int id,
//     required String title,
//     required String body
//   }) async{
//     final details= await _notificationDetails();
//     await _localNotificationService.show(id, title, body, details);
//   }
//
//
//
//   void onDidReceiveLocalNotification(int id, String? title,String? body,String? payload ){
//       print("iddd");
//   }
//   void onSelectNotification(){
//     print("Selected");
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifier {
  int i = 0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future showNotification(String title, String body) async {
    i = i +1;
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        '1', 'location-bg',
        playSound: true, importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics =
    const DarwinNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      i,
      title,
      body,
      platformChannelSpecifics,
      payload: 'sgtghdhthghfhgfhgfhgfhgfhgfh',
    );
  }

  Notifier(this.flutterLocalNotificationsPlugin) {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    //flutterLocalNotificationsPlugin.initialize(initializationSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
