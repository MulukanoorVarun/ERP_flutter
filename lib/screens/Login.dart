import 'dart:io';

import 'package:GenERP/screens/Dashboard.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController namee = TextEditingController();
  TextEditingController email = TextEditingController();
  String? deviceId = "";
  String? _tokenId;
  String? _deviceDetails;
  bool? _passwordVisible;
  bool? _exit;

  final RegExp _emailPattern = RegExp(
      r'^([\w.\-]+)@([\w\-]+)((\.(\w){2,63}){1,3})$'
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      print(iosDeviceInfo.toString());
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      print(androidDeviceInfo.toString());
      return androidDeviceInfo.id; // unique ID on Android
    }
  }



  Future<bool> _onBackPressed() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the App'),
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      color: ColorConstant.accent_color,
                      fontWeight: FontWeight.w500,
                      fontSize: FontConstant.Size15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.white70),
                ),
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: Text(
                  "YES",
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      color: ColorConstant.accent_color,
                      fontWeight: FontWeight.w500,
                      fontSize: FontConstant.Size15,
                    ),
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        child: Expanded(
            child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 50.0),
            alignment: Alignment.center,
            child: Image(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              image: AssetImage("assets/images/ic_login.png"),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Sign In",
              style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      color: ColorConstant.erp_appColor,
                      fontSize: FontConstant.Size25,
                      decoration: TextDecoration.underline)),
            ),
          ),
              SizedBox(height: 10.0,),
              Container(
                height: 45,
                alignment: Alignment.center,
                margin:EdgeInsets.only(left:15.0,right:15.0),
                child: TextFormField(
                  controller: email,
                  cursorColor: ColorConstant.black,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    hintStyle: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                          fontSize: FontConstant.Size15,
                          color: ColorConstant.Textfield,
                          fontWeight: FontWeight.w400),
                    ),
                    filled: true,
                    fillColor: ColorConstant.edit_bg_color,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          width: 1, color: ColorConstant.edit_bg_color),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          width: 1, color: ColorConstant.edit_bg_color),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          width: 1, color: ColorConstant.edit_bg_color),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Container(
                height: 45,
                alignment: Alignment.center,
                margin:EdgeInsets.only(left:15.0,right:15.0),
                child: TextFormField(
                  controller: namee,
                  cursorColor: ColorConstant.black,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    hintStyle: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                          fontSize: FontConstant.Size15,
                          color: ColorConstant.Textfield,
                          fontWeight: FontWeight.w400),
                    ),
                    filled: true,
                    fillColor: ColorConstant.edit_bg_color,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          width: 0, color: ColorConstant.edit_bg_color),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          width: 0, color: ColorConstant.edit_bg_color),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          width: 0, color: ColorConstant.edit_bg_color),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0,),
              Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()));

                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: screenWidth,
                    margin: EdgeInsets.only(left: 15.0,right: 15.0),
                    decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(30.0), ),
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: ColorConstant.white,
                          fontSize: FontConstant.Size20,
                        ),),
                    ),
                  ),
                )
              ),
              SizedBox(height: 60.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){

                    },
                    child: SvgPicture.asset("assets/images/ic_mobile_mobile.svg",width: 40,height: 40),
                  ),

                ],
              ),
              SizedBox(height: 100),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image(image: AssetImage("assets/images/poweredby.png"),width: 80,height: 40,),
              )


        ])),
      ),
    );
  }
}
