import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ContextExtensions on BuildContext {
  void showToast(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  bool get isNetworkAvailable {
    var connectivityResult = Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  void closeKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}

extension LocationExtensions on LocationData {
  String toText() {
    return "(${latitude.toString()}, ${longitude.toString()})";
  }
}

extension SharedPreferenceUtilExtensions on SharedPreferences {
  static const String KEY_FOREGROUND_ENABLED = "tracking_foreground_location";

  bool getLocationTrackingPref() {
    return getBool(KEY_FOREGROUND_ENABLED) ?? false;
  }

  void saveLocationTrackingPref(bool requestingLocationUpdates) {
    setBool(KEY_FOREGROUND_ENABLED, requestingLocationUpdates);
  }
}


int exifOrientationToDegrees(int exifOrientation) {
  switch (exifOrientation) {
    case 6:
      return 90;
    case 3:
      return 180;
    case 8:
      return 270;
    default:
      return 0;
  }
}


extension FileExtensions on File {
  Future<ui.Image> toImage() async {
    final bytes = await readAsBytes();
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(Uint8List.fromList(bytes), (img) => completer.complete(img));
    return completer.future;
  }
}

extension ImageRotateExtensions on ui.Image {
  Future<ui.Image> rotateImage(double angle) async {
    final width = this.width;
    final height = this.height;

    final pictureRecorder = ui.PictureRecorder();
    final canvas = ui.Canvas(pictureRecorder);

    canvas.translate(width / 2, height / 2);
    canvas.rotate(angle);
    canvas.translate(-width / 2, -height / 2);
    canvas.drawImage(this, Offset.zero, Paint());

    final img = await pictureRecorder.endRecording().toImage(width, height);
    return img;
  }
}
