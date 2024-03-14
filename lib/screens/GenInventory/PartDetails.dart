import 'package:GenERP/Services/other_services.dart';
import 'package:GenERP/Services/user_api.dart';
import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTechnicianModule/AddAccount.dart';
import 'package:GenERP/screens/AttendanceHistory.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/GenTracker/GeneratoraDetails.dart';
import 'package:GenERP/screens/GenTracker/RegisterComplaint.dart';
import 'package:GenERP/screens/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../../models/Inventory_Part_details_response.dart';
import '../Scanner.dart';

class PartDetailsScreen extends StatefulWidget {
  final part_id;
  const PartDetailsScreen({
    Key? key,
    required this.part_id,
  }) : super(key: key);
  @override
  State<PartDetailsScreen> createState() => _PartDetailsScreenState();
}

class _PartDetailsScreenState extends State<PartDetailsScreen> {
  TextEditingController issue_quantity = TextEditingController();
  TextEditingController issue_description = TextEditingController();
  TextEditingController receive_quantity = TextEditingController();
  TextEditingController receive_description = TextEditingController();
  var session = "";
  var empId = "";
  PartData? partdata;
  bool isLoading = true;
  @override
  void initState() {
    LoadPartDetailsApifunction();
    super.initState();
  }

  Future<void> _refresh() async {
    // Simulate a delay to mimic fetching new data from an API
    await Future.delayed(const Duration(seconds: 2));
    // Generate new data or update existing data
    setState(() {
      isLoading = true;
      LoadPartDetailsApifunction();
    });
  }

  @override
  void onDispose() {
    issue_quantity.dispose();
    issue_description.dispose();
    receive_quantity.dispose();
    receive_description.dispose();
    super.dispose();
  }

  Future<void> LoadPartDetailsApifunction() async {
    session = await PreferenceService().getString("Session_id") ?? "";
    empId = await PreferenceService().getString("UserId") ?? "";
    try {
      await UserApi.LoadPartDetailsAPI(empId, session, widget.part_id)
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.error == 0) {
                        partdata = data.partData!;
                        isLoading = false;
                      } else {
                        isLoading = false;
                      }
                    })
                  }
              });
    } on Error catch (e) {
      print(e.toString());
    }
  }

  Future<void> UpdateIssueAPI() async {
    session = await PreferenceService().getString("Session_id") ?? "";
    empId = await PreferenceService().getString("UserId") ?? "";
    try {
      print("empId:${empId}");
      print("session:${session}");
      print("issue_quantity:${issue_quantity.text}");
      print("issue_description:${issue_description.text}");
      print("part_id:${widget.part_id}");

      await UserApi.InventoryUpdateStockAPI(empId, session, issue_quantity.text,
              issue_description.text, widget.part_id, "Issued")
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.error == 0) {
                        toast(context, "Updated Successfully!");
                        Navigator.pop(context);
                        isLoading = true;
                        LoadPartDetailsApifunction();
                        issue_quantity.clear();
                        issue_description.clear();
                      } else {
                        toast(context, "Updated Failed!");
                      }
                    })
                  }
              });
    } on Error catch (e) {
      print(e.toString());
    }
  }

  Future<void> UpdateReceiveAPI() async {
    session = await PreferenceService().getString("Session_id") ?? "";
    empId = await PreferenceService().getString("UserId") ?? "";
    try {
      await UserApi.InventoryUpdateStockAPI(
              empId,
              session,
              receive_quantity.text,
              receive_description,
              widget.part_id,
              "Received")
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.error == 0) {
                        toast(context, "Updated Successfully!");
                        Navigator.pop(context);
                        isLoading = true;
                        LoadPartDetailsApifunction();
                        receive_quantity.clear();
                        receive_description.clear();
                      } else {
                        toast(context, "Updated Failed!");
                      }
                    })
                  }
              });
    } on Error catch (e) {
      print(e.toString());
    }
  }

  Future IssueDialogue() async {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.part_id,
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            fontSize: FontConstant.Size18,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          color: ColorConstant.erp_appColor,
                        ),
                      ),
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth * 0.6,
                          child: Divider(thickness: 0.5, color: Colors.grey),
                        ),
                      ],
                    )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Update issue",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: FontConstant.Size18,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                            color: ColorConstant.erp_appColor,
                          ),
                        ),
                      ],
                    )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: TextFormField(
                        controller: issue_quantity,
                        cursorColor: ColorConstant.black,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Quantity",
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: TextFormField(
                        maxLines: 8,
                        controller: issue_description,
                        cursorColor: ColorConstant.black,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Description",
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            issue_quantity.clear();
                            issue_description.clear();
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            // padding:,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorConstant.erp_appColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 20), // Add some space between the buttons
                        InkWell(
                          onTap: () {
                            UpdateIssueAPI();
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            // padding:,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorConstant.erp_appColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
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

  Future ReceiveDialogue() async {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.part_id,
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            fontSize: FontConstant.Size18,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          color: ColorConstant.erp_appColor,
                        ),
                      ),
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth * 0.6,
                          child: Divider(thickness: 0.5, color: Colors.grey),
                        ),
                      ],
                    )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Update Receive",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: FontConstant.Size18,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                            color: ColorConstant.erp_appColor,
                          ),
                        ),
                      ],
                    )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: TextFormField(
                        controller: receive_quantity,
                        cursorColor: ColorConstant.black,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Quantity",
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: TextFormField(
                        maxLines: 8,
                        controller: receive_description,
                        cursorColor: ColorConstant.black,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Description",
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              receive_quantity.clear();
                              receive_description.clear();
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            // padding:,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorConstant.erp_appColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 20), // Add some space between the buttons
                        InkWell(
                          onTap: () {
                            UpdateReceiveAPI();
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            // padding:,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorConstant.erp_appColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
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
                child: Text("Gen Inventory",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.ubuntu(
                      color: ColorConstant.white,
                      fontSize: FontConstant.Size18,
                      fontWeight: FontWeight.w500,
                    )),
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
              CupertinoIcons.back,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ),
      body: (isLoading)
          ? Loaders()
          : RefreshIndicator(
              onRefresh: _refresh,
              color: ColorConstant.erp_appColor,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    color: ColorConstant.erp_appColor,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context)
                          .size
                          .height, // Set width to fill parent width
                      decoration: BoxDecoration(
                        color: ColorConstant.edit_bg_color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .stretch, // Set max height constraints
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          //customer details
                          Container(
                            height: screenHeight * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.fromLTRB(7.5, 7.5, 0, 0),
                                  child: Text(
                                    partdata?.prodName ?? "",
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size18,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: ColorConstant.erp_appColor,
                                    ),
                                  ),
                                ),
                                Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Container(
                                      width: screenWidth * 0.9,
                                      child: Divider(
                                          thickness: 2, color: Colors.grey),
                                    ),
                                    Spacer(),
                                  ],
                                )),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      partdata?.remainingQuantity.toString() ??
                                          "",
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                          fontSize: FontConstant.Size22,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        color: ColorConstant.erp_appColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "REMAINING QUANTITY",
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        color: ColorConstant.erp_appColor,
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  IssueDialogue();
                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  // padding:,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: SvgPicture.asset(
                                          "assets/issue_icon.svg",
                                          height: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "ISSUE",
                                        style: GoogleFonts.ubuntu(
                                          textStyle: TextStyle(
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          color: ColorConstant.erp_appColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      35), // Add some space between the buttons
                              InkWell(
                                onTap: () {
                                  ReceiveDialogue();
                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  // padding:,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: SvgPicture.asset(
                                          "assets/receive_icon.svg",
                                          height: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "RECEIVE",
                                        style: GoogleFonts.ubuntu(
                                          textStyle: TextStyle(
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          color: ColorConstant.erp_appColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),

                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            height: screenHeight * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 0),
                                  child: Text(
                                    "Product Details",
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size18,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: ColorConstant.erp_appColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.86,
                                        child: Divider(
                                          thickness: 0.5,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Product Name",
                                                style: TextStyle(
                                                  color: ColorConstant.grey_153,
                                                  fontSize: FontConstant.Size15,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              Text(
                                                partdata?.prodName ?? "",
                                                style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: FontConstant.Size15,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              Text(
                                                "Vendor 1",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color: ColorConstant
                                                          .grey_153,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                partdata?.vendor1 ?? "",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorConstant.black,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                "Vendor Code",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color: ColorConstant
                                                          .grey_153,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                partdata?.vendorCode ?? "",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorConstant.black,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                "project",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color: ColorConstant
                                                          .grey_153,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                partdata?.project ?? "",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorConstant.black,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                "Description",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color: ColorConstant
                                                          .grey_153,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                partdata?.prodDesc ?? "",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorConstant.black,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                "MSL",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color: ColorConstant
                                                          .grey_153,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                partdata?.msl ?? "",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorConstant.black,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              // Add more Text widgets here...
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Product ID",
                                                style: TextStyle(
                                                  color: ColorConstant.grey_153,
                                                  fontSize: FontConstant.Size15,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              Text(
                                                partdata?.productCode ?? "",
                                                style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: FontConstant.Size15,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              Text(
                                                "Vendor 2",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color: ColorConstant
                                                          .grey_153,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                partdata?.vendor2 ?? "",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorConstant.black,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                "Units",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color: ColorConstant
                                                          .grey_153,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                partdata?.units ?? "",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorConstant.black,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                "Sub Group",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color: ColorConstant
                                                          .grey_153,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                partdata?.subGroup ?? "",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorConstant.black,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                "Branch",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color: ColorConstant
                                                          .grey_153,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                partdata?.branchName ?? "",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorConstant.black,
                                                      fontSize:
                                                          FontConstant.Size15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              // Add more Text widgets here...
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
