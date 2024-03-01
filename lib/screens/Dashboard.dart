import 'package:GenERP/screens/GenTracker/GenTrackerDashboard.dart';
import 'package:GenERP/screens/Profile.dart';
import 'package:GenERP/screens/WebERP.dart';
import 'package:GenERP/screens/attendance_screen.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';
import '../Utils/MyWidgets.dart';
import '../Utils/api_names.dart';
import '../Utils/storage.dart';
import 'Login.dart';
import 'Scanner.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final WebSocketChannel channel = IOWebSocketChannel.connect(WEB_SOCKET_URL);
  var username="";
  var email="";
  var loginStatus=0;
  var curdate="";
  var empId="";
  var session="";
  var online_status = 0;
  var webPageUrl = "";
  var roleStatus = "";
  bool isLoading = true;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    DashboardApiFunction();
  }

  Future<void> DashboardApiFunction() async {
    try{
      loginStatus= await PreferenceService().getInt("loginStatus")??0;
      empId= await PreferenceService().getString("UserId")??"";
      username = await PreferenceService().getString("UserName")??"";
      email = await PreferenceService().getString("UserEmail")??"";
      session = await PreferenceService().getString("Session_id")??"";
      roleStatus = await PreferenceService().getString("roles")??"";
      if (await PreferenceService().getString("redirectUrl") == null) {
        webPageUrl =
        "https://erp.gengroup.in/ci/app/home/web_erp?emp_id=$empId&session_id=$session";
      } else {
        webPageUrl =
        "https://erp.gengroup.in/ci/app/home/web_erp?emp_id=$empId&session_id=$session&redirect_url=${await PreferenceService().getString("redirectUrl").toString()}";
      }

      print("s:"+session);
      print("r:"+roleStatus);
      print(roleStatus.length);
    await UserApi.DashboardFunctionApi(empId??"",session??"").then((data) => {
      if (data != null)
        {
          setState(() {
            if (data.sessionExists == 1) {
              isLoading = false;
              online_status = data.attStatus??0;

            } else if (data.sessionExists == 0) {
              PreferenceService().clearPreferences();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
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

  Future<void> _refresh() async {
    // Simulate a delay to mimic fetching new data from an API
    await Future.delayed(const Duration(seconds: 2));
    // Generate new data or update existing data
    setState(() {
      isLoading = true;
      DashboardApiFunction();
    });
  }
  Future<bool> _onBackPressed() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the App'),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              "NO",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: ColorConstant.erp_appColor,
                  fontWeight: FontWeight.w500,
                  fontSize: FontConstant.Size15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(Colors.white70),
            ),
            onPressed: () =>
                SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: Text(
              "YES",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: ColorConstant.erp_appColor,
                  fontWeight: FontWeight.w500,
                  fontSize: FontConstant.Size15,
                ),
              ),
            ),
          ),
        ],
        elevation: 30.0,
      ),
      barrierDismissible: false,
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child:Scaffold(
          body:(isLoading)?Loaders():
           SafeArea(
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
                              SizedBox(height: 25),
                              Text(
                                DateFormat.yMMMMd().format(DateTime.now()),
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
                                "$username",
                                maxLines: 2,
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
                              (online_status==0)?
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
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ):Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Online",
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w400,
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
                                Container(
                                  child: InkWell(
                                    onTap: () async {
                                      var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Scanner()));
                                      if(res==true){
                                        setState(() {
                                          isLoading = true;
                                        });
                                        DashboardApiFunction();
                                      }
                                    },
                                    child:SvgPicture.asset(
                                      "assets/images/qr_scanner.svg",
                                      height: 35,
                                      width: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  child: InkWell(
                                    onTap: () async {
                                      var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                                      if(res==true){
                                        setState(() {
                                          isLoading = true;
                                        });
                                        DashboardApiFunction();
                                      }
                                    },
                                    child:SvgPicture.asset(
                                      "assets/images/profile_icon.svg",
                                      height: 30,
                                      width: 35,
                                    ) ,
                                  ),
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
                            if(roleStatus.contains("430"))...[
                              Container(child: InkWell(
                                onTap: () async {
                                  var res = await Navigator.push(context,MaterialPageRoute(builder: (context)=>Attendance()));

                                  if(res == true){
                                    setState(() {
                                      isLoading = true;
                                    });
                                    DashboardApiFunction();
                                  }
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
                              ),),
                            ],
                            SizedBox(height: 15,),
                            if(roleStatus.contains("431"))...[
                              Container(child: InkWell(
                                onTap: () async {
                                  var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => WebERP(url: webPageUrl)),
                                  );
                                  if(res == true){
                                    setState(() {
                                      isLoading = true;
                                    });
                                    DashboardApiFunction();
                                  }
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
                                        "assets/ic_web_erp.svg",
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

                              ),),
                            ],
                            SizedBox(height: 15,),
                            if(roleStatus.contains("432"))...[
                            Container(child: InkWell(
                              onTap: () async {
                                // var res = await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => WebERP(url: webPageUrl)),
                                // );
                                // if(res == true){
                                //   setState(() {
                                //     isLoading = true;
                                //   });
                                //   DashboardApiFunction();
                                // }
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
                                      "assets/ic_inventory.svg",
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(width: 15,),
                                    Text(
                                      "Inventory",
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

                            ),),],
                            SizedBox(height: 15,),
                            if(roleStatus.contains("433"))...[
                            Container(child: InkWell(
                              onTap: () async {
                                // var res = await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => WebERP(url: webPageUrl)),
                                // );
                                // if(res == true){
                                //   setState(() {
                                //     isLoading = true;
                                //   });
                                //   DashboardApiFunction();
                                // }
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
                                      "assets/ic_technician.svg",
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(width: 15,),
                                    Text(
                                      "Technician",
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

                            ),)],
                            SizedBox(height: 15,),
                            if(roleStatus.contains("434"))...[
                            Container(child: InkWell(
                              onTap: () async {
                                var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GenTrackerDashboard()),
                                );
                                if(res == true){
                                  setState(() {
                                    isLoading = true;
                                  });
                                  DashboardApiFunction();
                                }
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
                                      "assets/ic_gen_tracker.svg",
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(width: 15,),
                                    Text(
                                      "Gen Tracker",
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

                            ),)],
                            SizedBox(height: 15,),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
              )
          ))

      );
  }
}
