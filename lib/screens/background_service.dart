import 'dart:async';
import 'package:location/location.dart';

class StopLocationService {
  StreamSubscription<LocationData>? _locationSubscription;

  void stopLocationService() {
      _locationSubscription!.cancel();
      print('Location service stopped');
  }

}

