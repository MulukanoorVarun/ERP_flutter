import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/GenTracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/storage.dart';
import '../splash.dart';

class AddContact extends StatefulWidget {
  final actName, id;
  const AddContact({Key? key, required this.actName, this.id})
      : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController alt_mobile = TextEditingController();
  TextEditingController Tel_num = TextEditingController();
  TextEditingController email = TextEditingController();
  var empId = "";
  var session = "";
  var genId = "";
  var accountId = "";
  var saveAgainst = "";
  var _validate_name = "";
  var _validate_designation = "";
  var _validate_mobile_number = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> AddContactAPIFunction() async {
    empId = await PreferenceService().getString("UserId") ?? "";
    session = await PreferenceService().getString("Session_id") ?? "";
    if (widget.actName == "Generator") {
      saveAgainst = "Generator";
      genId = widget.id;
    } else {
      saveAgainst = "account";
      accountId = widget.id;
    }
    try {
      if (name.text.isEmpty) {
        setState(() {
          _validate_name = "Enter Name";
        });
      } else if (designation.text.isEmpty) {
        setState(() {
          _validate_designation = "Enter Designation";
        });
      } else if (mobile.text.isEmpty) {
        setState(() {
          _validate_mobile_number = "Enter valid Mobile Number";
        });
      } else if (name.text.isNotEmpty && designation.text.isEmpty) {
        setState(() {
          _validate_name = "";
          _validate_name.isEmpty;
          _validate_designation = "Enter Designation";
        });
      } else if (designation.text.isNotEmpty && mobile.text.isEmpty) {
        setState(() {
          _validate_designation = "";
          _validate_designation.isEmpty;
          _validate_mobile_number = "Enter valid Mobile Number";
        });
      } else if (mobile.text.isNotEmpty && name.text.isEmpty) {
        setState(() {
          _validate_mobile_number = "";
          _validate_mobile_number.isEmpty;
          _validate_name = "Enter Name";
        });
      } else if (name.text.isNotEmpty &&
          designation.text.isEmpty &&
          mobile.text.isEmpty) {
        setState(() {
          _validate_name = "";
          _validate_name.isEmpty;
          _validate_designation = "Enter Designation";
          _validate_mobile_number = "Enter valid Mobile Number";
        });
      } else if (designation.text.isNotEmpty &&
          name.text.isEmpty &&
          mobile.text.isEmpty) {
        setState(() {
          _validate_designation = "";
          _validate_designation.isEmpty;
          _validate_name = "Enter Name";
          _validate_mobile_number = "Enter valid Mobile Number";
        });
      } else if (mobile.text.isNotEmpty &&
          name.text.isEmpty &&
          designation.text.isEmpty) {
        setState(() {
          _validate_mobile_number = "";
          _validate_mobile_number.isEmpty;
          _validate_name = "Enter Name";
          _validate_designation = "Enter Designation";
        });
      } else {
        await UserApi.AddContactAPI(
                empId,
                session,
                genId,
                name.text,
                designation.text,
                mobile.text,
                alt_mobile.text,
                Tel_num.text,
                email.text,
                saveAgainst,
                accountId)
            .then((data) => {
                  if (data != null)
                    {
                      setState(() {
                        _validate_mobile_number = "";
                        _validate_designation = "";
                        _validate_name = "";
                        _validate_name.isEmpty;
                        _validate_designation.isEmpty;
                        _validate_mobile_number.isEmpty;
                        if (data.sessionExists == 1) {
                          if (data.error == 0) {
                            toast(context, data.message);
                            Navigator.pop(context, true);
                          } else if (data.error == 1) {
                            toast(context, data.message);
                          }
                        } else {
                          PreferenceService().clearPreferences();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Splash()));
                        }
                      })
                    }
                });
      }
    } on Error catch (e) {
      print(e.toString());
    }
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
                CupertinoIcons.back,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          title: Text(
            "Add Contact",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorConstant.white,
                fontSize: FontConstant.Size20,
                fontWeight: FontWeight.w500),
          ),
          backgroundColor: ColorConstant.erp_appColor),
      body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: screenHeight,
            color: ColorConstant.edit_bg_color,
            child: Flex(
              direction: Axis.vertical,
              children: [
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
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Column(
                      // Set max height constraints
                      children: [
                        Container(
                          height: 550,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 55,
                                margin:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  controller: name,
                                  cursorColor: ColorConstant.black,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "Enter Name*",
                                    hintStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        color: ColorConstant.Textfield,
                                        fontWeight: FontWeight.w400),
                                    filled: true,
                                    fillColor: ColorConstant.edit_bg_color,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                  ),
                                ),
                              ),
                              if (_validate_name != null) ...[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      top: 2.5, bottom: 2.5, left: 25),
                                  child: Text(
                                    _validate_name,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontConstant.Size10,
                                    ),
                                  ),
                                )
                              ] else ...[
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                              Container(
                                alignment: Alignment.center,
                                height: 55,
                                margin:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  controller: designation,
                                  cursorColor: ColorConstant.black,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "Designation*",
                                    hintStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        color: ColorConstant.Textfield,
                                        fontWeight: FontWeight.w400),
                                    filled: true,
                                    fillColor: ColorConstant.edit_bg_color,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                  ),
                                ),
                              ),
                              if (_validate_designation != null) ...[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      top: 2.5, bottom: 2.5, left: 25),
                                  child: Text(
                                    _validate_designation,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontConstant.Size10,
                                    ),
                                  ),
                                )
                              ] else ...[
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                              Container(
                                alignment: Alignment.center,
                                height: 55,
                                margin:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  controller: mobile,
                                  inputFormatters: [
                                    MaskedInputFormatter('##########'),
                                  ],
                                  cursorColor: ColorConstant.black,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Mobile Number*",
                                    hintStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        color: ColorConstant.Textfield,
                                        fontWeight: FontWeight.w400),
                                    filled: true,
                                    fillColor: ColorConstant.edit_bg_color,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                  ),
                                ),
                              ),
                              if (_validate_mobile_number != null) ...[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      top: 2.5, bottom: 2.5, left: 25),
                                  child: Text(
                                    _validate_mobile_number,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontConstant.Size10,
                                    ),
                                  ),
                                )
                              ] else ...[
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                              Container(
                                alignment: Alignment.center,
                                height: 55,
                                margin:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  controller: alt_mobile,
                                  cursorColor: ColorConstant.black,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    MaskedInputFormatter('##########'),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "Alternate Mobile Number",
                                    hintStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        color: ColorConstant.Textfield,
                                        fontWeight: FontWeight.w400),
                                    filled: true,
                                    fillColor: ColorConstant.edit_bg_color,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 55,
                                margin:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  controller: Tel_num,
                                  cursorColor: ColorConstant.black,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Telephone NUmber",
                                    hintStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        color: ColorConstant.Textfield,
                                        fontWeight: FontWeight.w400),
                                    filled: true,
                                    fillColor: ColorConstant.edit_bg_color,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 55,
                                margin:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  controller: email,
                                  cursorColor: ColorConstant.black,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Mail ID",
                                    hintStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        color: ColorConstant.Textfield,
                                        fontWeight: FontWeight.w400),
                                    filled: true,
                                    fillColor: ColorConstant.edit_bg_color,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: ColorConstant.edit_bg_color),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.0,
                              ),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  AddContactAPIFunction();
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  margin:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.erp_appColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Text(
                                    "SAVE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorConstant.white,
                                      fontSize: FontConstant.Size15,
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
