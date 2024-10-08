import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import '../Services/WebSocketManager.dart';
import '../Utils/storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// BackgroundLocation plugin to get background
/// lcoation updates in iOS and Android
class BackgroundLocation {
  // The channel to be used for communication.
  // This channel is also refrenced inside both iOS and Abdroid classes
  static const MethodChannel _channel =
      MethodChannel('com.almoullim.background_location/methods');
  static Timer? _locationTimer;

  static get context => null;
  static const String customChannelId = 'GEN ERP flutter';
  static const String customChannelName = 'GEN ERP flutter';
  static const String customChannelDescription = 'GEN ERP flutter';

  String input = "";
  static const int notificationId = 0;

  WebSocketManager webSocketManager = WebSocketManager(
    onConnectSuccess: () {
      // Handle WebSocket connection success
    },
    onMessage: (message) {
      // Handle incoming WebSocket message
    },
    onClose: () {
      // Handle WebSocket connection closure
    },
    onConnectFailed: () {
      // Handle WebSocket connection failure
    },
  );

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void init() async {
    try {
      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: AndroidInitializationSettings('@mipmap/ic_launcher'),
              iOS: DarwinInitializationSettings(
                  requestAlertPermission: false,
                  requestBadgePermission: false,
                  requestSoundPermission: false,
                  onDidReceiveLocalNotification: ((id, title, body, payload) =>
                      {})));
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Disable sound for the default notification channel
      const AndroidNotificationChannel androidChannel =
          AndroidNotificationChannel(
        customChannelId,
        customChannelName,
        description: customChannelDescription,
        importance: Importance.max,
        playSound: false, // Set this to false to disable playing sound
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);

      print("Flutter Local Notifications initialized successfully.");
    } catch (e) {
      print("Error initializing Flutter Local Notifications: $e");
      // Handle initialization error as needed
    }
  }

  static Future<void> checkAndRequestLocationPermissions() async {
    bool isLocationEnabled = false;
    bool hasLocationPermission = false;
    // Check if location services are enabled
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();

// Check if the app has been granted location permission
    LocationPermission permission = await Geolocator.checkPermission();
    hasLocationPermission = permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;

    final loc.Location location = loc.Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = (await location.hasPermission());
    if (permissionGranted == PermissionStatus) {
      permissionGranted = (await location.requestPermission());
      if (permissionGranted != PermissionStatus) {
        return;
      }
    }
  }

  static void showNotification(String title, String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      customChannelId,
      customChannelName,
      importance: Importance.defaultImportance,
      ticker: 'ticker',
      ongoing: true,
      playSound: false,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentSound: false,
      sound: "",
      // Set this to false to disable playing sound
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails);
    // Check if the notification with the same ID is already being shown
    final List<PendingNotificationRequest> pendingNotifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    final notificationAlreadyExists = pendingNotifications
        .any((notification) => notification.id == notificationId);
    // If notification already exists, update it; otherwise, show a new one
    if (notificationAlreadyExists) {
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        title,
        message,
        platformChannelSpecifics,
      );
    } else {
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        title,
        message,
        platformChannelSpecifics,
      );
    }
  }

  static void hideNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  void initWebSocket() {
    Future.delayed(Duration.zero, () {
      webSocketManager.connect();
    });
  }

  /// Stop receiving location updates
  static stopLocationService() async {
    print("Background location Service stopped");
    hideNotification(0);
    if (_locationTimer != null) {
      _locationTimer!.cancel();
    }
    return await _channel.invokeMethod('stop_location_service');
  }

  /// Check if the location update service is running
  static Future<bool> isServiceRunning() async {
    var result = await _channel.invokeMethod('is_service_running');
    return result == true;
  }

  static Future<bool> checkGpsStatus() async {
    print("Hello");
    bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    return isGpsEnabled;
  }

  static Future<bool> checkNetworkStatus() async {
    print("Hello");
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  /// Start receiving location updates at 5-second interval
  static startLocationService() async {
    init();
    bool isGpsEnabled = await checkGpsStatus();
    bool isNetworkAvailable = await checkNetworkStatus();
    if (isGpsEnabled && isNetworkAvailable) {
      // Both GPS and network are available, start background location service
      // Your code to start background location service goes here
      print("GEN ERP You're Online !");
      showNotification("GEN ERP", "You're Online !");
    } else {
      // Notify the user to enable GPS or connect to a network
      if (!isGpsEnabled) {
        // Notify user to enable GPS
        checkAndRequestLocationPermissions();
        showNotification(
            "GEN ERP", "You're Offline !, Check your GPS connection.");
        print(
            'GPS is not enabled. Please enable GPS to start the location service.');
      }
      if (!isNetworkAvailable) {
        // Notify user to connect to a network
        showNotification(
            "GEN ERP", "You're Offline !, Check your network connection.");
        print(
            'Network is not available. Please connect to a network to start the location service.');
      }
    }

    print("Background location Service started");
    // Stop previous timer if running
    BackgroundLocation backgroundLocation = BackgroundLocation();
    // Initialize WebSocket
    backgroundLocation.initWebSocket();
    stopLocationService();
    // Start a new timer for location updates
    _locationTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      await _channel.invokeMethod('start_location_service');
      var location = await BackgroundLocation().getCurrentLocation();
    });
  }

  // static setAndroidNotification(
  //     {String? title, String? message, String? icon}) async {
  //   if (Platform.isAndroid) {
  //     return await _channel.invokeMethod('set_android_notification',
  //         <String, dynamic>{'title': title, 'message': message, 'icon': icon});
  //   } else {
  //     //return Promise.resolve();
  //   }
  // }

  // static setAndroidConfiguration(int interval) async {
  //   if (Platform.isAndroid) {
  //     return await _channel.invokeMethod('set_configuration', <String, dynamic>{
  //       'interval': interval.toString(),
  //     });
  //   } else {
  //     //return Promise.resolve();
  //   }
  // }

  String? empId;
  String? sessionId;

  /// Get the current location once.
  Future<Location> getCurrentLocation() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    print('Received Location Update: of GEN ERP');
    saveLastLocationTime();
    var completer = Completer<Location>();

    var _location = Location();
    await getLocationUpdates((location) {
      _location.latitude = location.latitude;
      _location.longitude = location.longitude;
      _location.accuracy = location.accuracy;
      _location.altitude = location.altitude;
      _location.bearing = location.bearing;
      _location.speed = location.speed;
      _location.time = location.time;
      completer.complete(_location);
    });

    return completer.future;
  }

  /// Register a function to recive location updates as long as the location
  /// service has started
  getLocationUpdates(Function(Location) location) {
    // add a handler on the channel to recive updates from the native classes
    _channel.setMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'location') {
        var locationData = Map.from(methodCall.arguments);
        print('Received Location Update: $locationData');
        //  toast(context,'Received Location Update: $locationData');
        // Call the user passed function
        location(
          Location(
              latitude: locationData['latitude'],
              longitude: locationData['longitude'],
              altitude: locationData['altitude'],
              accuracy: locationData['accuracy'],
              bearing: locationData['bearing'],
              speed: locationData['speed'],
              time: locationData['time'],
              isMock: locationData['is_mock']),
        );

        //Send location updates using WebSocketManager
        if (await webSocketManager.isNetworkAvailable()) {
          webSocketManager.sendMessage(jsonEncode({
            "command": "server_request",
            "route": "attendenece_live_location_update",
            "session_id": sessionId,
            "ref_data": {
              "session_id": sessionId,
              "location":
                  "${locationData['latitude']},${locationData['longitude']}",
              "speed": locationData['speed'],
              "altitude": locationData['altitude'],
              "direction": locationData['bearing'],
              "direction_accuracy": locationData['bearingAccuracyDegrees'],
              "altitude_accuracy": locationData['verticalAccuracyMeters'],
              "speed_accuracy": locationData['speedAccuracyMetersPerSecond'],
              "location_accuracy": locationData['accuracy'],
              "location_provider": "",
            }
          }));
          print("Hello GENERP! You're Online!");
          showNotification("GEN ERP", "You're Online!");
        } else {
          print("Hello GENERP! You're Offline!");
          showNotification("GEN ERP", "You're Offline!");
        }
        saveLastLocationTime();
      }
    });
  }

  // Future<Location> getCurrentLocation() async {
  //   empId = await PreferenceService().getString("UserId");
  //   sessionId = await PreferenceService().getString("Session_id");
  //   print('Requesting Current Location...');
  //
  //   // Create a completer to handle the asynchronous nature of obtaining location
  //   var completer = Completer<Location>();
  //
  //   // Define a boolean flag to track if the completer is completed
  //   var isCompleterCompleted = false;
  //
  //   // Define a function to handle the location once obtained
  //   void handleLocation(Location location) {
  //     // Complete the completer only if it hasn't been completed before
  //     if (!isCompleterCompleted) {
  //       completer.complete(location);
  //       isCompleterCompleted = true; // Set the flag to true to indicate completion
  //     }
  //   }
  //
  //   // Start listening for location updates
  //   getLocationUpdates((location) {
  //     handleLocation(location);
  //   });
  //
  //   // Return the future from the completer
  //   return completer.future;
  // }
  //
  //
  // void getLocationUpdates(Function(Location) location) {
  //   // Define a function to handle location updates
  //   void handleLocation(Position position) async {
  //     // Create a Location object from the Position data
  //     Location locationData = Location(
  //       latitude: position.latitude,
  //       longitude: position.longitude,
  //       altitude: position.altitude,
  //       accuracy: position.accuracy,
  //       bearing: position.heading,
  //       speed: position.speed,
  //       time: position.timestamp.millisecondsSinceEpoch,
  //       isMock: false, // Assuming the position is not mocked
  //     );
  //     print('Received Location Update:${locationData}');
  //     // Call the user passed function with the location data
  //     location(locationData);
  //
  //     // Send location updates using WebSocketManager
  //     // Assuming webSocketManager and sessionId are defined elsewhere
  //     if (await webSocketManager.isNetworkAvailable()) {
  //       webSocketManager.sendMessage(jsonEncode({
  //         "command": "server_request",
  //         "route": "attendenece_live_location_update",
  //         "session_id": sessionId,
  //         "ref_data": {
  //           "session_id": sessionId,
  //           "location": "${position.latitude},${position.longitude}",
  //           "speed": position.speed,
  //           "altitude": position.altitude,
  //           "direction": position.heading,
  //           "direction_accuracy": position.headingAccuracy,
  //           "altitude_accuracy":position.altitudeAccuracy,
  //           "speed_accuracy":position.speedAccuracy,
  //           "location_accuracy": position.accuracy,
  //           "location_provider": "",
  //           // Include additional location attributes as needed
  //         }
  //       }));
  //       print("Hello GENERP! You're Online!");
  //       showNotification("GEN ERP", "You're Online!");
  //     } else {
  //       print("Hello GENERP! You're Offline!");
  //       showNotification("GEN ERP", "You're Offline!");
  //     }
  //     saveLastLocationTime();
  //   }
  //
  //   // Start listening for location updates
  //   Geolocator.getPositionStream().listen((Position position) {
  //     // Handle the received location
  //     handleLocation(position);
  //   }, onError: (error) => print("Error receiving location: $error"));
  // }
}

saveLastLocationTime() {
  var currentTime = DateTime.now();
  var formatter = DateFormat('HH:mm:ss').format(currentTime);
  PreferenceService().saveString("lastLocationTime", formatter);
  print("formatter:${formatter}");
}

/// about the user current location
class Location {
  double? latitude;
  double? longitude;
  double? altitude;
  double? bearing;
  double? accuracy;
  double? speed;
  double? time;
  bool? isMock;

  Location(
      {@required this.longitude,
      @required this.latitude,
      @required this.altitude,
      @required this.accuracy,
      @required this.bearing,
      @required this.speed,
      @required this.time,
      @required this.isMock});

  toMap() {
    var obj = {
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'bearing': bearing,
      'accuracy': accuracy,
      'speed': speed,
      'time': time,
      'is_mock': isMock
    };
    return obj;
  }
}
