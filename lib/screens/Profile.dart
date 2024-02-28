import 'package:GenERP/Utils/ColorConstant.dart';
import 'package:GenERP/Utils/MyWidgets.dart';
import 'package:GenERP/models/LogoutDialogue.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    // TODO: implement initState
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
                      } else if (data.sessionExists == 0) {
                        PreferenceService().clearPreferences();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Splash()));
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

  Future<void> LogoutApiFunction() async {
    print("lohi");
    try{
      await UserApi.LogoutFunctionApi(empId??"",session??"").then((data) => {
        if (data != null)
          {
            setState(() {
              if (data.error == 0) {
                PreferenceService().clearPreferences();
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Splash()));
              } else {
                print(data.toString());
              }
            })
          }
        else
          {print("Something went wrong, Please try again.")}
      });
    }on Exception catch (e) {
      print("$e");
    }
  }
  Future LogoutDialogue() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 20,
        shadowColor: Colors.black,
        title: Align(
            alignment: Alignment.topLeft,
            child:Text('Confirm Log Out',style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: FontConstant.Size22,
                fontWeight: FontWeight.w200
              ),
            ),)
        ),
        content: Container(
                width:400,
                height: 75,
                alignment: Alignment.center,
                child:Text('$username you are signing out from  $appName app on this device ',
                  maxLines:4,style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: FontConstant.Size18,
                    fontWeight: FontWeight.w100

                  ),
                ),)

        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(Colors.white70),
            ),
            onPressed: () =>
            {
              print("littu"),
              LogoutApiFunction()
            },

            child: Text(
              "LOG OUT",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: ColorConstant.black,
                  fontWeight: FontWeight.w100,
                  fontSize: FontConstant.Size15,
                ),
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
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: ColorConstant.black,
                  fontWeight: FontWeight.w100,
                  fontSize: FontConstant.Size15,
                ),
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    style: GoogleFonts.ubuntu(
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
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.security,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
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
      body: SafeArea(
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
                          image: AssetImage("assets/images/default_pic.jpeg"),
                        ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset("assets/images/top_bar_profile.svg",
                    width: screenWidth, fit: BoxFit.fill),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
              ),
              Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.12, left: 10.0),
                  child: (profileImage.isNotEmpty)
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(profileImage))
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/default_pic.jpeg"),
                        )),
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.15, left: screenWidth * 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "$username",
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                              color: ColorConstant.white,
                              fontSize: FontConstant.Size20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "$email",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                              color: ColorConstant.white,
                              fontSize: FontConstant.Size15,
                              fontWeight: FontWeight.w500),
                        ),
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
                      SvgPicture.asset("assets/images/bottom_bar_profile.svg",
                          width: screenWidth, fit: BoxFit.fill),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Company",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.grey_153,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "$company",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.black,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Branch",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.grey_153,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "$branch",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.black,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Designation*",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.grey_153,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width: screenWidth * 0.5,
                                    child: Text(
                                      "$designation",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.black,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Employee Id",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.grey_153,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width: 150,
                                    child: Text(
                                      "$empId",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.black,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Mobile Number",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.grey_153,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "$mobile_num",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            color: ColorConstant.black,
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w500),
                                      ),
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
                            onTap: ()  {
                              LogoutDialogue();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              decoration: BoxDecoration(
                                color: ColorConstant.erp_appColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(
                                "Logout",
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
                      Positioned(
                          bottom: 50,
                          left: 50,
                          right: 50,
                          child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Text(
                              "Version $releaseNotes",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  color: ColorConstant.grey_153,
                                  fontSize: FontConstant.Size15,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
