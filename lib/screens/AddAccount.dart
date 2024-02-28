import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/GenTracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';

class AddAccount extends StatefulWidget{
  const AddAccount({Key?key}): super(key:key);

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount>{
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController alt_mobile = TextEditingController();
  TextEditingController Tel_num = TextEditingController();
  TextEditingController email = TextEditingController();
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
          title: Text(
            "Add Account",
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  color: ColorConstant.white,
                  fontSize: FontConstant.Size20,
                  fontWeight: FontWeight.w500),
            ),
          ),
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
                  height: 500,
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
                          controller: name,
                          cursorColor: ColorConstant.black,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter Name*",
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
                          controller: designation,
                          cursorColor: ColorConstant.black,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Designation*",
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
                          controller: mobile,
                          cursorColor: ColorConstant.black,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Mobile Number*",
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
                          controller: alt_mobile,
                          cursorColor: ColorConstant.black,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Alternate Mobile Number",
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
                          controller: Tel_num,
                          cursorColor: ColorConstant.black,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Telephone NUmber",
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
                          controller: email,
                          cursorColor: ColorConstant.black,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Mail ID",
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              margin: EdgeInsets.only(left: 15.0,right: 15.0),
                              decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(30.0),),
                              child: Text(
                                "SAVE",
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