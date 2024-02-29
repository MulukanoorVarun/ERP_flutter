import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';


import '../Utils/FontConstant.dart';
import '../Utils/storage.dart';
import 'Dashboard.dart';
import 'Login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>{
  void initState(){
    super.initState();
    validate_and_run();
    navigateAfterDelay();
    requestPermissions();
  }

  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.location,
      Permission.locationWhenInUse,
      Permission.locationAlways,
      Permission.accessMediaLocation,
      Permission.notification,
      Permission.accessNotificationPolicy
      // Add more permissions as needed
    ].request();

    statuses.forEach((permission, status) {
      if (!status.isGranted) {
        // Handle denied permissions
      }

    }

    );
  }
  void navigateAfterDelay() {
    // Delay navigation by 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()), // Replace Dashboard with your desired destination
      );
    });
  }
  validate_and_run() async {
    var SessionAvailable= await PreferenceService().getString("Session_id");
    if (SessionAvailable != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  Dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text("Gen ERP",style: GoogleFonts.ubuntu(
          //     letterSpacing: 0,
          //     textStyle: TextStyle(
          //         fontSize: FontConstant.Size60,
          //         fontWeight: FontWeight.bold,
          //         overflow: TextOverflow.ellipsis),
          //     color: Colors.black),),
          // Image(image: AssetImage("assets/images/Finallogo.png")),
          Container(
              alignment: Alignment.center,
              child: Image(
                alignment: Alignment.center,
                height: 300,
                width: 300,
                image: AssetImage("assets/images/ic_splash.jpg"),
              )

          ),
        ],
      ),
    );

  }
}