import 'dart:io';

import 'package:GenERP/Services/other_services.dart';
import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:android_id/android_id.dart';
import 'package:click_to_copy/click_to_copy.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/svg.dart';

import 'package:share_plus/share_plus.dart';
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
  var _deviceDetails = "";
  bool? _passwordVisible = false;
  bool? _exit;
  var _validateEmail;
  var _validatepassword;
  String platformname = "";
  var _androidId = 'Unknown';
  static const _androidIdPlugin = AndroidId();

  final RegExp _emailPattern =
      RegExp(r'^([\w.\-]+)@([\w\-]+)((\.(\w){2,63}){1,3})$');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // validate_and_run();
    if (Platform.isAndroid) {
      _initAndroidId();
    } else {
      _getId();
    }
  }

  void onDispose() {
    // TODO: implement initState
    super.dispose();
    FocusScope.of(context).unfocus();
  }

  validate_and_run() async {
    var SessionAvailable = await PreferenceService().getString("Session_id");
    if (SessionAvailable != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin(); // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor!;
    _deviceDetails = iosDeviceInfo.toString();
  }

  Future<void> _initAndroidId() async {
    String androidId;
    var deviceInfo = DeviceInfoPlugin(); // import 'dart:io'
    var androidDeviceInfo = await deviceInfo.androidInfo;
    _deviceDetails = await "Version Name: " +
        androidDeviceInfo.version.baseOS.toString().trim() +
        ", " +
        "Version Code: " +
        androidDeviceInfo.version.codename.toString().trim() +
        ", " +
        "OS Version: " +
        androidDeviceInfo.version.codename.toString().trim() +
        ", SDK Version: " +
        androidDeviceInfo.version.sdkInt.toString().trim() +
        ", Device: " +
        androidDeviceInfo.device.toString().trim() +
        ", Model: " +
        androidDeviceInfo.model.toString().trim() +
        ", Product: " +
        androidDeviceInfo.product.toString().trim() +
        ", Manufacturer: " +
        androidDeviceInfo.manufacturer.toString().trim() +
        ", Brand: " +
        androidDeviceInfo.brand.toString().trim() +
        ", User: " +
        androidDeviceInfo.data['user'].toString().trim() +
        ", Display: " +
        androidDeviceInfo.display.toString().trim() +
        ", Hardware: " +
        androidDeviceInfo.hardware.toString().trim() +
        ", Board: " +
        androidDeviceInfo.board.toString().trim() +
        ", Host: " +
        androidDeviceInfo.host.toString().trim() +
        ", Serial: " +
        androidDeviceInfo.serialNumber.toString().trim() +
        ", ID: " +
        androidDeviceInfo.id.toString().trim() +
        ", Bootloader: " +
        androidDeviceInfo.bootloader.toString().trim() +
        ", CPU ABI1: " +
        androidDeviceInfo.supported64BitAbis.toString().trim() +
        ", CPU ABI2: " +
        androidDeviceInfo.supported64BitAbis.toString().trim() +
        ", FingerPrint: " +
        androidDeviceInfo.fingerprint.toString().trim();
    // _deviceDetails = androidDeviceInfo.model.toString();
    try {
      androidId = await _androidIdPlugin.getId() ?? 'Unknown ID';
      deviceId = androidId;
      print("littu" + deviceId);
      print(_deviceDetails.toString());
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
        setState(() {});
      } else {
        _validatepassword = "";
        _validateEmail = " ";

        String? fcmToken = " ";
        if (Platform.isAndroid) {
          // toast(context,"Android");
          platformname = "Android";
          fcmToken = await FirebaseMessaging.instance.getToken();
        } else if (Platform.isIOS) {
          // toast(context,"ios");
          platformname = "iOS";
          // fcmToken = await FirebaseMessaging.instance.getAPNSToken();
        }
        // String? fcm_token = await FirebaseMessaging.instance.getToken();
        print("fcmToken:${fcmToken}");
        await UserApi.LoginFunctionApi(
                email.text,
                password.text,
                fcmToken.toString() ?? "",
                deviceId.toString() ?? "",
                _deviceDetails.toString())
            .then((data) => {
                  if (data != null)
                    {
                      setState(() {
                        print("${data.error} login error here");
                        if (data.error == 0) {
                          PreferenceService().saveInt("loginStatus", 1);
                          PreferenceService()
                              .saveString("UserId", data.userId!);
                          PreferenceService()
                              .saveString("UserName", data.name!);
                          PreferenceService()
                              .saveString("UserEmail", data.emailId!);
                          PreferenceService()
                              .saveString("Session_id", data.sessionId!);
                          print(data.userId);
                          print(data.name);
                          print(data.emailId);
                          print(data.sessionId);
                          var roles = data.permissions!.toString();
                          PreferenceService().saveString("roles", roles);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
                        } else if (data.error == 1) {
                          print(data.error.toString());
                          toast(context,
                              "You are not authorized to login in this device !");
                        } else if (data.error == 2) {
                          toast(context, "Invalid login credentials !");
                          print(data.error.toString());
                        } else {
                          print(data.error.toString());
                          //  toast(context, "Something went wrong, Please try again.");
                        }
                      })
                    }
                  else
                    {
                      // toast(context, "Something went wrong, Please try again."),
                      print("Something went wrong, Please try again.")
                    }
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
                  style: TextStyle(
                    color: ColorConstant.erp_appColor,
                    fontWeight: FontWeight.w500,
                    fontSize: FontConstant.Size15,
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
                  style: TextStyle(
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

  Future DeviceDialogue() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Device ID',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: FontConstant.Size25,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                )),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: 180,
                    height: 45,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 5.0),
                    decoration: BoxDecoration(
                        color: ColorConstant.edit_bg_color,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      '$deviceId',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FontConstant.Size18,
                      ),
                    )),
                Spacer(),
                Container(
                  child: InkWell(
                    onTap: () async {
                      await ClickToCopy.copy(deviceId.trim());
                      Navigator.pop(context);
                      toast(context, "Device ID has been copied!");
                    },
                    child:SvgPicture.asset(
                      "assets/ic_copy.svg",
                      height: 22,
                      width: 22,),
                  ),
                ),
                Spacer(),
                Container(
                    child: InkWell(
                  onTap: () {
                    Share.share("$deviceId");
                  },
                      child:SvgPicture.asset(
                        "assets/ic_share.svg",
                        height: 22,
                        width: 22,),
                )),
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                      Center(
                        // Center widget added here
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: ColorConstant.erp_appColor,
                              fontSize: FontConstant.Size25,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: ColorConstant.edit_bg_color,
                            borderRadius:
                            BorderRadius.circular(30),),
                      //  alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,3.0,0,0),
                        child: TextField(
                          controller: email,
                          cursorColor: ColorConstant.black,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            // Handle onChanged
                          },
                          onTapOutside: (event) {
                            // Handle onTapOutside
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            hintStyle: TextStyle(
                                fontSize: FontConstant.Size16,
                                color: ColorConstant.Textfield,
                                fontWeight: FontWeight.w400),
                            //contentPadding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText:
                            'Enter Email',
                          ),
                          minLines: 1,
                          autofocus: true,// and this
                        ),
                          ),
                      ),
                      if (_validateEmail != null) ...[
                        Container(
                          alignment: Alignment.topLeft,
                          margin:
                              EdgeInsets.only(top: 2.5, bottom: 2.5, left: 25),
                          child: Text(
                            _validateEmail,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: FontConstant.Size10,
                            ),
                          ),
                        )
                      ] else ...[
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: ColorConstant.edit_bg_color,
                          borderRadius:
                          BorderRadius.circular(30),),
                       // alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0,3.0,0,0),
                                              child: TextField(
                                                controller: password,
                                                obscureText: !(_passwordVisible!),
                                                cursorColor: ColorConstant.black,
                                                keyboardType: TextInputType.visiblePassword,
                                                decoration: InputDecoration(
                                                  hintText: "Enter Password",
                                                  suffixIcon: IconButton(
                                                    color: ColorConstant.erp_appColor,
                                                    icon: Icon(
                                                      (_passwordVisible!)
                                                          ? CupertinoIcons.eye_solid
                                                          : CupertinoIcons.eye_slash_fill,
                                                      size: 30,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _passwordVisible = !(_passwordVisible!);
                                                      });
                                                    },
                                                  ),
                                                  hintStyle: TextStyle(
                                                      fontSize: FontConstant.Size16,
                                                      color: ColorConstant.Textfield,
                                                      fontWeight: FontWeight.w400),
                                                  isDense: true,
                                                  enabledBorder: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                ),
                                                minLines: 1,
                                                autofocus: true,
                                              ),
                          ),
                      ),
                      if (_validatepassword != null) ...[
                        Container(
                          alignment: Alignment.topLeft,
                          margin:
                              EdgeInsets.only(top: 2.5, bottom: 2.5, left: 25),
                          child: Text(
                            _validatepassword,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: FontConstant.Size10,
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
                          var f = FocusScope.of(context);

                          if (!f.hasPrimaryFocus) {
                            f.unfocus();
                          }
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
                            style: TextStyle(
                              color: ColorConstant.white,
                              fontSize: FontConstant.Size20,
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
                    ]))));
  }

  @override
  void dispose() {
    var f = FocusScope.of(context);
    FocusScope.of(context).unfocus();
    if (!f.hasPrimaryFocus) {
      f.unfocus();
    }
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
