import 'package:GenERP/screens/AddAccount.dart';
import 'package:GenERP/screens/AttendanceHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController password = TextEditingController();
  TextEditingController conf_password = TextEditingController();
  bool _passwordVisible = false;
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
          title: Text(
            "UpdatePassword",
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  color: ColorConstant.white,
                  fontSize: FontConstant.Size20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          leadingWidth: 0.0,
          backgroundColor: ColorConstant.erp_appColor),
      body: Container(
       color: ColorConstant.erp_appColor,
        child: Expanded(
          child: Container(
            width: double.infinity, // Set width to fill parent width
            decoration: BoxDecoration(
              color: ColorConstant.edit_bg_color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Column(// Set max height constraints
              children: [
               Container(
               height: 240,
                 decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child:
                    Column(
                      children: [
                        SizedBox(height: 10.0,),
                        Container(
                          alignment: Alignment.center,
                          height: 55,
                          margin:EdgeInsets.only(left:15.0,right:15.0),
                          child: TextFormField(
                            controller: password,
                            cursorColor: ColorConstant.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "New Password*",
                              hintStyle: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    fontSize: FontConstant.Size15,
                                    color: ColorConstant.Textfield,
                                    fontWeight: FontWeight.w400),
                              ),
                              filled: true,
                              fillColor: ColorConstant.edit_bg_color,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 0, color: ColorConstant.edit_bg_color),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 0, color: ColorConstant.edit_bg_color),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 0, color: ColorConstant.edit_bg_color),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          alignment: Alignment.center,
                          height: 55,
                          margin:EdgeInsets.only(left:15.0,right:15.0),
                          child: TextFormField(
                            controller: conf_password,
                            cursorColor: ColorConstant.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Confirm New Password*",
                              hintStyle: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    fontSize: FontConstant.Size15,
                                    color: ColorConstant.Textfield,
                                    fontWeight: FontWeight.w400),
                              ),
                              filled: true,
                              fillColor: ColorConstant.edit_bg_color,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 0, color: ColorConstant.edit_bg_color),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 0, color: ColorConstant.edit_bg_color),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 0, color: ColorConstant.edit_bg_color),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50.0,),
                        Container(
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (Context)=>AddAccount()));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(30.0), ),
                                child: Text(
                                  "Update",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      color: ColorConstant.white,
                                      fontSize: FontConstant.Size15,
                                    ),),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),

                  ),

              ],
            ),

          ),
        ),
      ),
    );
  }
}
