import 'dart:async';
import 'dart:io';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/WhizzdomScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'Services/other_services.dart';
import 'Utils/storage.dart';
import 'screens/splash.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:audioplayers/audioplayers.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'generp_channel', // id
    'generp_channel_name',
    importance: Importance.max,
    playSound: false);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  String type = message.data['type'] ?? '';

  if (type == 'offline_reminder') {
    FlutterRingtonePlayer().play(
      fromAsset: "assets/offline_reminder.mp3",
      ios: IosSounds.glass, // Specify the iOS sound
    );
  } else if (type == 'normal') {
    FlutterRingtonePlayer().play(
      fromAsset: "assets/notification_sound.mp3",
      ios: IosSounds.glass, // Specify the iOS sound
    );
  } else if (type == 'web_erp_notification') {
    FlutterRingtonePlayer().play(
      fromAsset: "assets/notification_sound.mp3",
      ios: IosSounds.glass, // Specify the iOS sound
    );
  } else {
    FlutterRingtonePlayer().play(
        fromAsset: "assets/notification_sound.mp3",
        // will be the sound on Android
        ios: IosSounds.glass // will be the sound on iOS
        );
  }
  print('A Background message just showed up: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isNotEmpty) {
    print("Firebase is initialized");
  } else {
    print("Firebase is not initialized");
  }

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBmkmKdYfBt2n5QRlmZJ9MV_Amh9xR3UOY",
        appId: "1:329382566569:android:26dc8519537b04deff67b8",
        messagingSenderId: "329382566569",
        projectId: "generp-fe09d",
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: false,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    print("msg");
    String type = message.data['type'] ?? '';
    if (type == 'offline_reminder') {
      FlutterRingtonePlayer().play(
        fromAsset: "assets/offline_reminder.mp3",
        ios: IosSounds.glass, // Specify the iOS sound
      );
    } else if (type == 'normal') {
      FlutterRingtonePlayer().play(
        fromAsset: "assets/notification_sound.mp3",
        ios: IosSounds.glass, // Specify the iOS sound
      );
    } else if (type == 'web_erp_notification') {
      FlutterRingtonePlayer().play(
        fromAsset: "assets/notification_sound.mp3",
        ios: IosSounds.glass, // Specify the iOS sound
      );
    } else {
      FlutterRingtonePlayer().play(
          fromAsset:
              "assets/notification_sound.mp3", // will be the sound on Android
          ios: IosSounds.glass // will be the sound on iOS
          );
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  if (Platform.isAndroid) {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("fbstoken:{$token}");
      PreferenceService().saveString("fbstoken", token!);
    });
  } else if (Platform.isIOS) {
    FirebaseMessaging.instance
        .requestPermission(alert: true, sound: true, badge: true);
    FirebaseMessaging.instance.getAPNSToken().then((value) {
      String? fcmtoken = value;
      print("fcmtoken:{$fcmtoken}");
      PreferenceService().saveString("fbstoken", fcmtoken!);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String type = message.data['type'] ?? '';
      String redirectUrl = message.data['redirect_url'] ?? '';
      //
      // if (type == 'offline_reminder' || type == 'normal') {
      //   navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => Dashboard()));
      // } else if (type == 'web_erp_notification') {
      //   navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => WhizzdomScreen(url: redirectUrl)));
      // } else {
      //   navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => Dashboard()));
      // }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
      print('A new onMessageOpenedApp event was published!');
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Gen ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nexa',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        cardColor: Colors.white,
        shadowColor: Colors.white54,
        searchBarTheme: const SearchBarThemeData(),
        tabBarTheme: const TabBarTheme(),
        dialogTheme: const DialogTheme(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(5.0)), // Set the border radius of the dialog
          ),
        ),
        buttonTheme: const ButtonThemeData(),
        appBarTheme: const AppBarTheme(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          color: Colors.white,
        ),
        cardTheme: const CardTheme(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          color: Colors.white,
          //),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              // overlayColor: MaterialStateProperty.all(Colors.white),
              ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
            surfaceTintColor: Colors.white, backgroundColor: Colors.white),
        colorScheme: const ColorScheme.light(background: Colors.white)
            .copyWith(background: Colors.white),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
      },
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
