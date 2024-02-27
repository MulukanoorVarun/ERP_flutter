import 'package:GenERP/screens/attendance_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ColorConstant.edit_bg_color,
      // Set your desired height here
      body:SafeArea(
        child: Container(
          color:ColorConstant.erp_appColor,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                color: ColorConstant.erp_appColor,
                height: MediaQuery.of(context).size.height * 0.20,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "27th February 24",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: FontConstant.Size13,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Varun.m - GENIT",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: FontConstant.Size20,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Offline",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  fontSize: FontConstant.Size18,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20), // Added SizedBox for spacing
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 30)),
                        Row(children: [
                          SvgPicture.asset(
                            "assets/images/qr_scanner.svg",
                            height: 35,
                            width: 35,
                          ),
                          SizedBox(width: 20),
                          SvgPicture.asset(
                            "assets/images/profile_icon.svg",
                            height: 30,
                            width: 35,
                          ),
                          SizedBox(width: 10),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity, // Set width to fill parent width
                  decoration: BoxDecoration(
                    color: ColorConstant.edit_bg_color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(// Set max height constraints
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Attendance()));
                        },
                  child:Container(
                    height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        SvgPicture.asset(
                          "assets/checkin_out_icon.svg",
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(width: 15,),
                        Text(
                          "Check In/Out",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: FontConstant.Size20,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            color: ColorConstant.erp_appColor,
                          ),
                        ),
                      ],
                    ),

                    ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            SvgPicture.asset(
                              "assets/checkin_out_icon.svg",
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(width: 15,),
                            Text(
                              "ERP",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  fontSize: FontConstant.Size20,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                color: ColorConstant.erp_appColor,
                              ),
                            ),
                          ],
                        ),

                      ),
                      SizedBox(height: 15,),

                    ],
                  ),

                ),
              ),
            ],
          ),
        )
      )

    );
  }
}
