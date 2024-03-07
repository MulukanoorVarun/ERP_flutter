import 'package:GenERP/screens/GenTracker/UpdateComplaint.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:flutter/material.dart';
import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../../Utils/storage.dart';
import '../../models/generatorComplaintResponse.dart';

class ComplaintDetails extends StatefulWidget {
  final gen_id, act_name;

  const ComplaintDetails({
    Key? key,
    required this.gen_id,
    required this.act_name,
  }) : super(key: key);

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  var session = "";
  var empId = "";
  var tech_name = "";
  var comp_type = "";
  var Comp_status = "";
  var id = "";
  var date = "";
  var open_status = "Open";
  List<C_List> comp_List = [];

  bool isloading = true;

  @override
  void initState() {
    super.initState();
    LoadgeneratorDetailsApifunction();
    print("grn_id" + widget.gen_id.toString());
  }

  Future<void> LoadgeneratorDetailsApifunction() async {
    if (widget.act_name == "pendingComplaints") {
      setState(() {
        open_status = "Open";
      });
    } else {
      open_status = "All";
    }
    session = await PreferenceService().getString("Session_id") ?? "";
    empId = await PreferenceService().getString("UserId") ?? "";
    try {
      await UserApi.LoadGeneratorComplaintListAPI(
              empId, session, widget.gen_id, open_status)
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.sessionExists == 1) {
                        if (data.error == 0) {
                          comp_List = data.list!;
                          isloading = false;
                          print("littu");
                        } else {
                          isloading = true;
                          print("error");
                        }
                      } else {
                        isloading = true;
                        PreferenceService().clearPreferences();
                        toast(context,
                            "Your Session expired, Please Login Again!");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Splash()));
                      }
                    })
                  }
                else
                  {
                    isloading = true,
                    toast(context, "Something Went Wrong, Please try again!"),
                    print("error2")
                  }
              });
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
        backgroundColor: ColorConstant.erp_appColor,
        elevation: 0,
        title: Container(
            child: Row(
          children: [
            // Spacer(),
            Container(
              child: InkWell(
                onTap: () => Navigator.pop(context, true),
                child: Text("Complaint Details",
                    textAlign: TextAlign.left,
                    style: TextStyle(
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
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ),
      body: (isloading)
          ? Loaders()
          : Container(
              color: ColorConstant.erp_appColor,
              child: Column(children: [
                if (comp_List.length > 0) ...[
                  Expanded(
      child: SingleChildScrollView(
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
                          SizedBox(
                            height: 5.0,
                          ),
                               GridView.builder(
                                itemCount: comp_List.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            1, // 4 items in a row for tablet
                                        crossAxisSpacing: 4,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: (175 / 140)),
                                padding: const EdgeInsets.all(5),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (widget.act_name ==
                                              "pendingComplaints" &&
                                          open_status == "Open") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateComplaint(
                                                      complaint_id:
                                                          comp_List![index]
                                                              .compId,
                                                    )));
                                      }
                                    },
                                    child: Container(
                                      height: screenHeight * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.fromLTRB(
                                                7.5, 7.5, 0, 0),
                                            child: Text(
                                              "Complaint Details",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size18,
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.ellipsis,
                                                color:
                                                    ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Spacer(),
                                              Container(
                                                width: screenWidth * 0.9,
                                                child: Divider(
                                                    thickness: 0.5,
                                                    color: Colors.grey),
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Technician Name",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .grey_153,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "ID",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .grey_153,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      comp_List[index]!
                                                              .techName ??
                                                          "-",
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .black,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      comp_List[index]!
                                                              .compId ??
                                                          "-",
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .black,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Complaint Type",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .grey_153,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Date",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .grey_153,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      comp_List[index]!
                                                              .compType ??
                                                          "-",
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .black,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      comp_List[index]!
                                                              .compRegdate ??
                                                          "-",
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .black,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Complaint Status",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .grey_153,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .grey_153,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      comp_List[index]!
                                                              .compStatus ??
                                                          "-",
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .black,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 150,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: ColorConstant
                                                              .black,
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
      ),
                  ),
                ] else ...[
                  Expanded(
                      child: Container(
                          width:
                              double.infinity, // Set width to fill parent width
                          decoration: BoxDecoration(
                            color: ColorConstant.edit_bg_color,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Container(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "No Data Available",
                                  style: TextStyle(
                                    fontSize: FontConstant.Size18,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    color: ColorConstant.erp_appColor,
                                  ),
                                )),
                          )))
                ]
              ]),
            ),
    );
  }
}
