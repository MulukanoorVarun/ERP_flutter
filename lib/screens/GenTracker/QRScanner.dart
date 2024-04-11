import 'package:GenERP/Services/other_services.dart';
import 'package:GenERP/Services/user_api.dart';
import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTechnicianModule/AddAccount.dart';
import 'package:GenERP/screens/AttendanceHistory.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/GenTechnicianModule/PendingComplaints.dart';
import 'package:GenERP/screens/GenTracker/GeneratoraDetails.dart';
import 'package:GenERP/screens/GenTracker/RegisterComplaint.dart';
import 'package:GenERP/screens/Login.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../Scanner.dart';
import 'ComplaintHistory.dart';

class QRScanner extends StatefulWidget {
  final title;
  const QRScanner({Key? key, required this.title}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> with WidgetsBindingObserver {
  TextEditingController Generator_id = TextEditingController();
  var session = "";
  var empId = "";
  var _Error = "";
  var result = "";
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_session();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // This block of code will be executed when the app resumes from the background
      // You can put any logic you want to execute on app resume here
      LoadgeneratorDetailsApifunction(empId, session, result);
    }
  }

  check_session() async {
    session = await PreferenceService().getString("Session_id") ?? "";
    empId = await PreferenceService().getString("UserId") ?? "";
    result = await PreferenceService().getString("result") ?? "";
    print("e:$empId");
    print("s:$session");
    if (empId != null && session != null) {
      isLoading = false;
    }
  }

  Future<void> LoadgeneratorDetailsApifunction(
      empId, session, gen_hash_id) async {
    try {
      if (Generator_id.text.isEmpty) {
        setState(() {
          _Error = "Enter Generator Id";
        });
        // toast(context,"Enter Generator Id");
        print(_Error);
      } else {
        _Error = "";
        _Error.isEmpty;
        await UserApi.LoadGeneratorDetailsAPI(empId, session, gen_hash_id)
            .then((data) => {
                  if (data != null)
                    {
                      setState(() {
                        if (data.sessionExists == 1) {
                          if (data.error == 0) {
                            if (widget.title == "Generator Details") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GeneratorDetails(
                                        actName: "",
                                        location: "",
                                        generatorId: Generator_id.text),
                                  ));
                            }
                            if (widget.title == "Register Complaint") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterComplaint(
                                          generator_id: Generator_id.text)));
                            }
                            if (widget.title == "pendingComplaints") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ComplaintDetails(
                                            gen_id: Generator_id.text,
                                            act_name: widget.title,
                                          )));
                            }
                          } else if (data.error == 1) {
                            toast(context, "Enter Valid Generator Id");
                          } else {
                            toast(context,
                                "Something went wrong, Please try again later!");
                          }
                        } else {
                          PreferenceService().clearPreferences();
                          toast(context,
                              "Your session has expired, please login again");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Splash()));
                        }
                      })
                    }
                  else
                    {
                      toast(context,
                          "No response from server, Please try again later!")
                    }
                });
      }
    } on Error catch (e) {
      print(e.toString());
    }
  }

  validations() {
    _Error = "Enter Generator Id";
  }

  Future<void> _refresh() async {
    // Simulate a delay to mimic fetching new data from an API
    await Future.delayed(const Duration(seconds: 2));
    // Generate new data or update existing data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      color: ColorConstant.erp_appColor,
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.erp_appColor,
          elevation: 0,
          title: Container(
              child: Row(
            children: [
              Container(
                child: InkWell(
                  onTap: () => Navigator.pop(context, true),
                  child: Text(widget.title,
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
                CupertinoIcons.back,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
        ),
        body: (isLoading)
            ? Loaders()
            : SingleChildScrollView(
                child: Container(
                height: screenHeight,
                color: ColorConstant.erp_appColor,
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
                        height: 15.0,
                      ),
                      Container(
                        child: Text(
                          "Scan QR Code or Enter ID",
                          style: TextStyle(
                            fontSize: FontConstant.Size25,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: ColorConstant.erp_appColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        height: screenHeight * 0.75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25.0,
                            ),
                            InkWell(
                              onTap: () {
                                if (widget.title == "Generator Details") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Scanner(
                                              from: "generatorDetails")));
                                }
                                if (widget.title == "Register Complaint") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Scanner(
                                              from: "registerComplaint")));
                                }
                                if (widget.title == "pendingComplaints") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Scanner(
                                              from: "pendingComplaints")));
                                }
                              },
                              child: Container(
                                child: SvgPicture.asset(
                                  "assets/ic_qrcode.svg",
                                  height: 280,
                                  width: 280,
                                ),
                              ),
                            ),
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Container(
                                  width: 130,
                                  child:
                                      Divider(thickness: 1, color: Colors.grey),
                                ),
                                Spacer(),
                                Container(
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                      fontSize: FontConstant.Size20,
                                      fontWeight: FontWeight.w300,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 130,
                                  child:
                                      Divider(thickness: 1, color: Colors.grey),
                                ),
                                Spacer(),
                              ],
                            )),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorConstant.edit_bg_color,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 55,
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 0.0, 0, 0),
                                child: TextFormField(
                                  controller: Generator_id,
                                  cursorColor: ColorConstant.black,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: InputDecoration(
                                    hintText: "Enter Generator ID",
                                    hintStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        color: ColorConstant.Textfield,
                                        fontWeight: FontWeight.w400),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            if (_Error.isNotEmpty) ...[
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(
                                    top: 2.5, bottom: 2.5, left: 25),
                                child: Text(
                                  "$_Error",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: FontConstant.Size10,
                                  ),
                                ),
                              )
                            ] else ...[
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                            Container(
                                child: InkWell(
                              onTap: () {
                                LoadgeneratorDetailsApifunction(
                                    empId, session, Generator_id.text);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                margin:
                                    EdgeInsets.only(left: 15.0, right: 15.0),
                                decoration: BoxDecoration(
                                  color: ColorConstant.erp_appColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  "Submit",
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
              )),
      ),
    );
  }
}
