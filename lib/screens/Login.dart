import 'dart:io';

import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:android_id/android_id.dart';
import 'package:click_to_copy/click_to_copy.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../Services/other_services.dart';
import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';
import 'Profile.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  String deviceId = "";
  String _tokenId = "";
  String _deviceDetails = "";
  bool? _passwordVisible = false;
  bool? _exit;
  var _validateEmail;
  var _validatepassword;
  var _androidId = 'Unknown';
  static const _androidIdPlugin = AndroidId();

  final RegExp _emailPattern =
      RegExp(r'^([\w.\-]+)@([\w\-]+)((\.(\w){2,63}){1,3})$');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      _initAndroidId();
    } else {
      _getId();
    }
  }



  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin(); // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor!;
  }

  Future<void> _initAndroidId() async {
    String androidId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      androidId = await _androidIdPlugin.getId() ?? 'Unknown ID';
      deviceId = androidId;
      print("littu" + deviceId);
    } on PlatformException {
      androidId = 'Failed to get Android ID.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() => _androidId = androidId);
  }

  Future<void> LoginApiFunction() async {
    try {
      print(email.text);
      print(password.text);
      print(_tokenId);
      print(deviceId);
      print(_deviceDetails);

      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email.text)) {
        setState(() {
          _validateEmail = "*Please Enter a Valid Email Address";
          print(_validateEmail);
        });
      } else {
        _validateEmail = "";
      }
      if (password.text.isEmpty) {
        setState(() {
          _validatepassword = "*Please Enter Your Password";
          print(_validatepassword);
        });
      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email.text) &&
          password.text.isNotEmpty) {
        setState(() {
          // _validateName.isEmpty;
          // _validateName = "";
          // _validateEmail = "*Please Enter a Valid Email Address";
          // print(_validateEmail);
        });
      } else if ((email.text.isNotEmpty) && password.text.isEmpty) {
        setState(() {
          // _validateEmail.isEmpty;
          // _validateEmail = "";
          // _validateName = "*Please Enter Your Name";
          // print(_validateName + "kjfjk");
        });
      } else {
        _validatepassword = "";
        _validateEmail = " ";

        String? fcmToken = " ";
        if (Platform.isAndroid) {
          // toast(context,"Android");
          // platformname = "Android";
          // fcmToken = await FirebaseMessaging.instance.getToken();
        } else if (Platform.isIOS) {
          // toast(context,"ios");
          // platformname = "iOS";
          // fcmToken = await FirebaseMessaging.instance.getAPNSToken();
        }
        await UserApi.LoginFunctionApi(
                email.text,
                password.text,
                _tokenId.toString() ?? "",
                deviceId.toString() ?? "",
                _deviceDetails.toString() ?? "")
            .then((data) => {
                  if (data != null)
                    {
                      setState(() {
                        if (data.error == 0) {
                          PreferenceService().saveInt("loginStatus", 1);
                          PreferenceService().saveString("UserId", data.userId!);
                          PreferenceService().saveString("UserName", data.name!);
                          PreferenceService().saveString("UserEmail", data.emailId!);
                          PreferenceService().saveString("Session_id", data.sessionId!);
                          print(data.userId);
                          print(data.name);
                          print(data.emailId);
                          print(data.sessionId);
                          var roles = data.permissions!.toString();
                          PreferenceService().saveString("roles", roles);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Splash()));
                        } else {
                          print(data.error.toString());
                        }
                      })
                    }
                  else
                    {print("Something went wrong, Please try again.")}
                });
      }
    } on Exception catch (e) {
      print("$e");
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

  Future DeviceDialogue() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            title: Align(
              alignment: Alignment.center,
              child:Text('Device ID',style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: FontConstant.Size25,
                  fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline
                ),
              ),)
            ),

            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width:180,
                  height: 45,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right:5.0),
                  decoration: BoxDecoration(color: ColorConstant.edit_bg_color,borderRadius: BorderRadius.circular(10.0)),
                  child:Text('$deviceId',style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: FontConstant.Size18,

                    ),
                  ),)
                ),
                Spacer(),
                Container(
                  child: InkWell(
                    onTap: () async {
                      await ClickToCopy.copy(deviceId.trim());
                      Navigator.pop(context);
                      toast(context,"Device ID has been copied!");
                    },
                    child: Icon(Icons.file_copy,color: Colors.grey,size: 22,),
                  ),
                ),
                Spacer(),
                Container(
                    child: InkWell(
                      onTap: (){
                        Share.share(
                            "$deviceId");
                      },
                      child: Icon(Icons.share,size: 22),
                    )
                ),
              ],
            ),
          ),
          barrierDismissible: true,
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 45,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
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
                          borderSide:
                              BorderSide(width: 1, color: ColorConstant.red),
                        ),
                      ),
                      minLines: 1,
                    ),
                  ),
                  if (_validateEmail != null) ...[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 2.5, bottom: 2.5,left:25),
                      child: Text(
                        _validateEmail,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            color: Colors.red,
                            fontSize: FontConstant.Size10,
                          ),
                        ),
                      ),
                    )
                  ] else ...[
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                  Container(
                    height: 45,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      controller: password,
                      obscureText: !(_passwordVisible!),
                      cursorColor: ColorConstant.black,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            (_passwordVisible!)
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !(_passwordVisible!);
                            });
                          },
                        ),
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
                      minLines: 1,
                    ),
                  ),
                  if (_validatepassword != null) ...[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 2.5, bottom: 2.5,left:25),
                      child: Text(
                        _validatepassword,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            color: Colors.red,
                            fontSize: FontConstant.Size10,
                          ),
                        ),
                      ),
                    )
                  ] else ...[
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                  Container(
                      child: InkWell(
                    onTap: () {
                      LoginApiFunction();
                      //  Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: screenWidth,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        color: ColorConstant.erp_appColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            color: ColorConstant.white,
                            fontSize: FontConstant.Size20,
                          ),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 60.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          DeviceDialogue();
                        },
                        child: SvgPicture.asset(
                            "assets/images/ic_mobile_mobile.svg",
                            width: 40,
                            height: 40),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      image: AssetImage("assets/images/poweredby.png"),
                      width: 80,
                      height: 40,
                    ),
                  )
                ])),
              ),
            )));
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
