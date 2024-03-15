import 'dart:async';
import 'dart:convert';

import 'package:GenERP/Utils/ColorConstant.dart';
import 'package:GenERP/Utils/MyWidgets.dart';
import 'package:GenERP/screens/Login.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../Services/TOTP.dart';
import '../Services/user_api.dart';
import '../Utils/Constants.dart';
import '../Utils/FontConstant.dart';
import '../Utils/storage.dart';
import 'UpdatePassword.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var username = "";
  var email = "";
  var loginStatus = 0;
  var curdate = "";
  var empId = "";
  var session = "";
  var profileImage = "";
  var company = "";
  var branch = "";
  var designation = "";
  var mobile_num = "";
  var latestversion = "";
  var releaseNotes = "";
  bool isLoading = true;
  var totpText = "";
  var secretKey = utf8.encode("vsd");
  var base32Secret ="TESTINGAPPSECRETKEY";
  var totp;
  late Timer _timer;
  late Timer _authCodeTimer;
  int currentProgress = 0;

  @override
  void initState() {
    totp = initializeTotp(secretKey);
  //  totp = initializeTotpFromBase32(base32Secret);
    super.initState();
    ProfileApiFunction();
    VersionApiFunction();
  }

  Future<void> ProfileApiFunction() async {
    try {
      loginStatus = await PreferenceService().getInt("loginStatus") ?? 0;
      empId = await PreferenceService().getString("UserId") ?? "";
      username = await PreferenceService().getString("UserName") ?? "";
      email = await PreferenceService().getString("UserEmail") ?? "";
      session = await PreferenceService().getString("Session_id") ?? "";
      await UserApi.ProfileFunctionApi(empId ?? "", session ?? "")
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.sessionExists == 1) {
                        profileImage = data.profilePic ?? "";
                        company = data.company ?? "";
                        branch = data.branchName ?? "";
                        designation = data.designation ?? "";
                        mobile_num = data.mobileNo ?? "";
                        isLoading = false;

                        //totp = initializeTotp(secretKey);
                      } else if (data.sessionExists == 0) {
                        PreferenceService().clearPreferences();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                        print(data.toString());
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

  Totp initializeTotp(List<int> secretKey) {
    print("secretKey:${secretKey}");
    return Totp(
      secret: secretKey,
      algorithm: Algorithm.sha256,
      digits: 6,
      period: 30,
    );
  }

  Totp initializeTotpFromBase32(String base32Secret) {
    return Totp.fromBase32(
      secret: base32Secret,
      algorithm: Algorithm.sha256,
      digits: 6,
      period: 30,
    );
  }


  Future<void> LogoutApiFunction() async {
    print("lohi");
    try {
      await UserApi.LogoutFunctionApi(empId ?? "", session ?? "")
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.error == 0) {
                        isLoading = false;
                        PreferenceService().clearPreferences();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        print(data.toString());
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
  Future LogoutDialogue() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 20,
            shadowColor: Colors.black,
            title: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Confirm Log Out',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: FontConstant.Size22,
                      fontWeight: FontWeight.w200),
                )),
            content: Container(
                width: 400,
                height: 100,
                alignment: Alignment.center,
                child: Text(
                  '$username, you are signing out from  $appName app on this device ',
                  maxLines: 4,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: FontConstant.Size18,
                      fontWeight: FontWeight.w100),
                )),
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.white70),
                ),
                onPressed: () => {
                  print("littu"),
                  setState(() {
                    isLoading = true;
                  }),
                  LogoutApiFunction(),
                  Navigator.of(context).pop(false)
                },
                child: Text(
                  "LOG OUT",
                  style: TextStyle(
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w100,
                    fontSize: FontConstant.Size15,
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w100,
                    fontSize: FontConstant.Size15,
                  ),
                ),
              ),
            ],
          ),
          barrierDismissible: false,
        ) ??
        false;
  }

  Future<void> VersionApiFunction() async {
    try {
      await UserApi.versionApi().then((data) => {
            if (data != null)
              {
                setState(() {
                  latestversion = data.latestVersion ?? "";
                  releaseNotes = data.releaseNotes ?? "";
                })
              }
            else
              {print("Something went wrong, Please try again.")}
          });
    } on Exception catch (e) {
      print("$e");
    }
  }
  Future TOTPDialogue() async {
    bool isLoading = true;
    Timer(Duration(seconds: 30), () {
      if (isLoading) {
        // Set isLoading to false after 30 seconds
        isLoading = false;
        // Update the UI
        if (context != null && mounted) {
          Navigator.of(context).pop(); // Dismiss the dialog
        }
      }
    });
    return await showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Align(
              alignment: Alignment.center,
              child: Text(
                'TOTP',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: FontConstant.Size25,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline),
              ),
            ),
            shadowColor: Colors.black,
            content: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 50), // Set the maximum height here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        totp.now(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: FontConstant.Size18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                       // if (isLoading) // Check if TOTP secret is initialized
                       //  SizedBox(
                       //    width: 16, // Adjust the width as needed
                       //    height: 16, // Adjust the height as needed
                       //    child: CircularProgressIndicator(
                       //      strokeWidth: 16,
                       //      backgroundColor: Colors
                       //          .grey, // Optional: Change the background color
                       //    ),
                       //  )
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          barrierDismissible: true,
        ) ??
        false;
  }

  Future<void> _refresh() async {
    // Simulate a delay to mimic fetching new data from an API
    await Future.delayed(const Duration(seconds: 2));
    // Generate new data or update existing data
    setState(() {
      isLoading = true;
      ProfileApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: _refresh,
      color: ColorConstant.erp_appColor,
      child: Scaffold(

                    // color: ColorConstant.erp_appColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.erp_appColor,
        elevation: 0,
        title: Container(
            child: Row(
              children: [
                // Spacer(),
                Container(
                  child: InkWell(
                    onTap: () => Navigator.pop(context, true),
                    child: Text("Profile",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.white,
                          fontSize: FontConstant.Size18,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                const Spacer(),
                Container(
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                  ),
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      TOTPDialogue();
                      setState(() {
                        // totp =initializeTotp(secretKey);
                      });
                    },
                      child:SvgPicture.asset(
                          "assets/ic_security.svg",
                      height: 30,
                      width: 30,),
                  ),
                ),
                SizedBox(width: 10,)
              ],
            )),
        titleSpacing: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ),
      body:(isLoading)?Loaders(): SafeArea(

        child:SingleChildScrollView(

          physics: AlwaysScrollableScrollPhysics(),

          child: Container(
            // color: ColorConstant.erp_appColor,

                    child: Stack(
                      children: [
                        Positioned(
                          top: -50,
                          right: 10,
                          left: 10,
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: (profileImage.isNotEmpty)
                                ? Image(
                                    image: NetworkImage(profileImage),
                                    fit: BoxFit.fitWidth,
                                  )
                                : Image(
                                    image: AssetImage(
                                        "assets/images/default_pic.jpeg"),
                                  ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0))),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          child: SvgPicture.asset(
                              "assets/images/top_bar_profile.svg",
                              height: screenHeight * 0.75,
                              width: screenWidth,
                              fit: BoxFit.fill),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0))),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: screenHeight * 0.12, left: 10.0),
                            child: (profileImage.isNotEmpty)
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(profileImage))
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                        "assets/images/default_pic.jpeg"),
                                  )),
                        Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.15,
                              left: screenWidth * 0.325),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "$username",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstant.white,
                                      fontSize: FontConstant.Size20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "$email",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstant.white,
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: screenHeight * 0.23),
                            alignment: Alignment.bottomCenter,
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                    "assets/images/bottom_bar_profile.svg",
                                    width: screenWidth,
                                    fit: BoxFit.fill),
                                Positioned(
                                    top: 50,
                                    // Adjust the position of the text as needed
                                    left: 25,
                                    // You can also adjust left, right, or center as needed
                                    right: 0,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 150,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Company",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        ColorConstant.grey_153,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "$company",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: ColorConstant.black,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 150,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Branch",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        ColorConstant.grey_153,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "$branch",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: ColorConstant.black,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 150,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Designation",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        ColorConstant.grey_153,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              width: screenWidth * 0.5,
                                              child: Text(
                                                "$designation",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: ColorConstant.black,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 3,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 150,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Employee Id",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        ColorConstant.grey_153,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              width: 150,
                                              child: Text(
                                                "E-$empId",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: ColorConstant.black,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 150,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Mobile Number",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        ColorConstant.grey_153,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "$mobile_num",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: ColorConstant.black,
                                                    fontSize:
                                                        FontConstant.Size18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Positioned(
                                    bottom: 100,
                                    left: 50,
                                    right: 50,
                                    child: InkWell(
                                      onTap: () {
                                        LogoutDialogue();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 45,
                                        margin: EdgeInsets.only(
                                            left: 15.0, right: 15.0),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.erp_appColor,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Text(
                                          "Log Out",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ColorConstant.white,
                                            fontSize: FontConstant.Size20,
                                          ),
                                        ),
                                      ),
                                    )),
                                Positioned(
                                    bottom: 50,
                                    left: 50,
                                    right: 50,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 45,
                                      margin: EdgeInsets.only(
                                          left: 15.0, right: 15.0),
                                      child: Text(
                                        "Version $releaseNotes",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorConstant.grey_153,
                                          fontSize: FontConstant.Size15,
                                        ),
                                      ),
                                    )),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
