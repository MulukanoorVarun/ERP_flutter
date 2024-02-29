// import 'dart:async';
// import 'package:location/location.dart';
//
//
// class LocationService {
//   final Location _location = Location();
//   StreamSubscription<LocationData>? _locationSubscription;
//
//   static const MethodChannel _channel = MethodChannel('location_service');
//
//   static Future<void> startLocationTracking() async {
//     try {
//       await _channel.invokeMethod('startLocationTracking');
//     } on PlatformException catch (e) {
//       print("Failed to start location tracking: '${e.message}'.");
//     }
//   }
//
//   static Future<void> stopLocationTracking() async {
//     try {
//       await _channel.invokeMethod('stopLocationTracking');
//     } on PlatformException catch (e) {
//       print("Failed to stop location tracking: '${e.message}'.");
//     }
//   }
//
//   Future<void> startLocationService() async {
//     try {
//       // Request location permissions
//       await _location.requestPermission();
//
//       // Enable background mode (if necessary)
//       await _location.enableBackgroundMode(enable: true);
//
//       // Start listening to location updates
//       _locationSubscription = _location.onLocationChanged
//           .listen((LocationData locationData) {
//         print('Location update: ${locationData.latitude}, ${locationData.longitude}');
//         // Handle location data here
//
//         // You can also add any additional logic here, such as sending the location to a server
//       });
//
//       // Set the desired update interval to 2 seconds
//       _location.changeSettings(interval: 2000);
//     } catch (e) {
//       // Handle errors or exceptions
//       print('Error starting location service: $e');
//       throw e; // Optionally, rethrow the exception to handle it in the UI
//     }
//   }
//
//   void stopLocationService() {
//     _locationSubscription?.cancel();
//   }
// }





