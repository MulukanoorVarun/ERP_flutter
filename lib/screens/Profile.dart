import 'package:GenERP/Utils/ColorConstant.dart';
import 'package:GenERP/Utils/MyWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/FontConstant.dart';
import 'UpdatePassword.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              Container(
                alignment: Alignment.topCenter,

                child: Image(
                  image: AssetImage("assets/images/default_pic.jpeg"),
                  fit: BoxFit.fitWidth,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset("assets/images/top_bar_profile.svg",
                    width: screenWidth, fit: BoxFit.fill),
              ),
              Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.12, left: 10.0),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage("assets/images/default_pic.jpeg"))),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Company",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    color: ColorConstant.grey_153,
                                    fontSize: FontConstant.Size20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Text(
                              "Branch",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    color: ColorConstant.grey_153,
                                    fontSize: FontConstant.Size20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Text(
                              "Designation",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    color: ColorConstant.grey_153,
                                    fontSize: FontConstant.Size20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Text(
                              "Employee Id",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    color: ColorConstant.grey_153,
                                    fontSize: FontConstant.Size20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Text(
                              "Mobile Number",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    color: ColorConstant.grey_153,
                                    fontSize: FontConstant.Size20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 25,
                          // Adjust the position of the text as needed
                          left: 0,
                          // You can also adjust left, right, or center as needed
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword()));
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
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
