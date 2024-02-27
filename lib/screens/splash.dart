import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


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
  }

  validate_and_run() async {
    var tokenAvailable= await PreferenceService().getString("token");
    if (tokenAvailable != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  Dashboard()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  Login()));
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