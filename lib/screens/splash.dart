import 'dart:async';

import 'package:GenERP/Services/user_api.dart';
import 'package:GenERP/screens/UpdatePassword.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
 
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';


import '../Services/other_services.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/Constants.dart';
import '../Utils/FontConstant.dart';
import '../Utils/storage.dart';
import '../main.dart';
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
    VersionApiFunction();
    // validate_and_run();
    // navigateAfterDelay();
    requestPermissions();
  }


  Future<void> VersionApiFunction() async {
    var loginStatus= await PreferenceService().getInt("loginstatus");
    try {
      await UserApi.versionApi().then((data) => {
        if (data != null)
          {
            setState(() {
              if(VERSION_CODE < data.latestVersionCode!){
                AppUpdateDialouge(data.url!,data.releaseNotes!);
              }else{
                if(loginStatus==0){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  Login()));
                }else{
                 // AppUpdateDialouge(data.url!,data.releaseNotes!);
                  getSessiondetailsApiFunction();
                }
              }
            })
          }
        else
          {print("Something went wrong, Please try again.")}
      });
    } on Exception catch (e) {
      print("$e");
    }
  }

  Future AppUpdateDialouge(String apkurl,String note) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('App Update Available!',
              style:
            TextStyle(
              color: ColorConstant.erp_appColor,
              fontWeight: FontWeight.w500,
              fontSize: FontConstant.Size18,
            ),

            ),
            content:  Text(note
            ),
            actions: [
              const SizedBox(height: 16),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.white70),
                ),
                onPressed: () async{
                  if (await canLaunchUrl(Uri.parse(apkurl)))
                  {
                  await launchUrl(Uri.parse(apkurl),
                  mode: LaunchMode.externalApplication);
                  }
                    },
                child: Text(
                  "UPDATE",
                  style:
                  TextStyle(
                    color: ColorConstant.erp_appColor,
                    fontWeight: FontWeight.w500,
                    fontSize: FontConstant.Size15,
                  ),

                ),
              ),
            ],
            elevation: 30.0,
          ),
      barrierDismissible: false,
    ) ??
        false;
  }

  void requestPermissions() async {
    await getCameraPermissions();
    await getStoragePermission();
    await getLocationPermissions();
  }

  Future<void> getStoragePermission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      setState(() {});
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      setState(() {});
    }
  }

  Future<void> getCameraPermissions() async {
    if (await Permission.camera.request().isGranted) {
      setState(() {});
    } else if (await Permission.camera.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.camera.request().isDenied) {
      setState(() {});
    }
  }

  Future<void> getLocationPermissions() async {
    if (await Permission.location.request().isGranted) {
      setState(() {});
    } else if (await Permission.location.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.location.request().isDenied) {
      setState(() {});
    }

    if (await Permission.locationAlways.request().isGranted) {
      setState(() {});
    } else if (await Permission.locationAlways.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.locationAlways.request().isDenied) {
      setState(() {});
    }

    if (await Permission.locationWhenInUse.request().isGranted) {
      setState(() {});
    } else if (await Permission.locationWhenInUse.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.locationWhenInUse.request().isDenied) {
      setState(() {});
    }
  }


  Future<void> getNotificationsPermissions() async {
    if (await Permission.notification.request().isGranted) {
      setState(() {});
    } else if (await Permission.notification.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.notification.request().isDenied) {
      setState(() {});
    }
  }

  // void navigateAfterDelay() {
  //   Delay navigation by 5 seconds
  //   Timer(Duration(seconds: 5), () {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => Login()), // Replace Dashboard with your desired destination
  //     );
  //   });
  // }
  // validate_and_run() async {
  //   var SessionAvailable= await PreferenceService().getString("Session_id");
  //   if (SessionAvailable != null) {
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) =>  Dashboard()));
  //   }
  // }

  Future<void> getSessiondetailsApiFunction() async{
    var session= await PreferenceService().getString("Session_id");
    var empId= await PreferenceService().getString("UserId");
    try{
      await UserApi.SessionExistsApi(empId, session).then((data)=>{
        if(data!=null){
          setState((){
            if(data.sessionExists==1){
              if(data.updatePasswordRequired==0){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Dashboard()));
              }
              else if(data.updatePasswordRequired==1){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  UpdatePassword()));
              }
            }else{
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  Login()));
              toast(context,"Your Session has been expired, Please Login Again");
            }
          })
        }else{
          //toast(context,"Something went wrong, Please try again later!")
        }
      });

    } on Error catch(e){
      print(e.toString());
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