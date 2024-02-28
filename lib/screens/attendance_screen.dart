import 'package:GenERP/screens/CheckInScreen.dart';
import 'package:GenERP/screens/CheckOutScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        SvgPicture.asset(
                          "assets/back_icon.svg",
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(width: 16,),
                        Center(
                        child:Text(
                          "Check In/Out",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: FontConstant.Size22,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            color: Colors.white
                          ),
                        ),
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
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Column(// Set max height constraints
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckOutScreen()));
                            },
                            child:Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: screenWidth,
                              margin: EdgeInsets.only(left: 15.0,right: 15.0),
                              decoration: BoxDecoration(
                                color: ColorConstant.erp_appColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                                  child:Text(
                                    "Check In",
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size20,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: ColorConstant.white,
                                    ),
                                  ),


                            ),
                          ),
                          SizedBox(height: 15,),

                          Row(
                            children: [
                              Text(
                                "Attendance History",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: FontConstant.Size18,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  color: ColorConstant.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "View History",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: FontConstant.Size15,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  color: ColorConstant.black,
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                "assets/forward_slash.svg",
                                height: 35,
                                width: 35,
                              ),
                            ],
                          ),

                          Expanded(
                            child: GridView.builder(
                                itemCount: 3,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: (MediaQuery.of(context).size.width < 600)
                                        ? 1  // 2 items in a row for mobile
                                        : 4, // 4 items in a row for tablet
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 2,
                                    childAspectRatio:
                                    (255 / 110)),
                                padding: const EdgeInsets.all(5),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                    return Container(
                                      child: Card(
                                        elevation: 0,
                                        shadowColor: Colors.white,
                                        margin: const EdgeInsets.fromLTRB(
                                            3.0, 0.0, 0.0, 5.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                        ),
                                        child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                        Padding(padding:const EdgeInsets.all(8.0),),

                                              Row(
                                                children: [
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    "Date :",
                                                    style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                        fontSize: FontConstant.Size18,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      color: ColorConstant.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    " 27 Feb 24",
                                                    style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.bold,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      color: ColorConstant.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    "Check In Time :",
                                                    style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                        fontSize: FontConstant.Size18,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      color: ColorConstant.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    " ",
                                                    style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.bold,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      color: ColorConstant.black,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    "Check Out Time :",
                                                    style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                        fontSize: FontConstant.Size18,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      color: ColorConstant.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    "",
                                                    style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.bold,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      color: ColorConstant.black,
                                                    ),
                                                  ),
                                                ],
                                              )

                                      ]),


                                      // CategoryProductCard(context,UpdateFavoriteFunction,AddToCartFunction,mak,productlist[index])
                                    ));
                                  return null;
                                }),
                          ),

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