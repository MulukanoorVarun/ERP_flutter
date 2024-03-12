import 'dart:async';

import 'package:GenERP/screens/GenInventory/InventoryScreen.dart';
import 'package:GenERP/screens/GenTechnicianModule/AccountSuggestion.dart';
import 'package:GenERP/screens/GenTechnicianModule/TechnicianDashboard.dart';
import 'package:GenERP/screens/GenTracker/GenTrackerDashboard.dart';
import 'package:GenERP/screens/LocationService.dart';
import 'package:GenERP/screens/Profile.dart';
import 'package:GenERP/screens/WebERP.dart';
import 'package:GenERP/screens/attendance_screen.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:android_autostart/android_autostart.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
 
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Services/WebSocketManager.dart';
import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';
import '../Utils/MyWidgets.dart';
import '../Utils/api_names.dart';
import '../Utils/storage.dart';
import 'Login.dart';
import 'Scanner.dart';
import 'WhizzdomScreen.dart';
import 'background_service.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  // final WebSocketChannel channel = IOWebSocketChannel.connect(WEB_SOCKET_URL);
  var username="";
  var email="";
  var loginStatus=0;
  var curdate="";
  var empId="";
  var session="";
  var online_status = 0;
  var webPageUrl = "";
  var whizzdomPageUrl = "";
  var roleStatus = "";
  bool isLoading = true;
  var Sessionid;
  var setstatus;


  WebSocketManager webSocketManager = WebSocketManager(
    onConnectSuccess: () {
      // Handle on connect success callback
    },
    onMessage: (message) {
      // Handle on message callback
    },
    onClose: () {
      // Handle on close callback
    },
    onConnectFailed: () {
      // Handle on connect failed callback
    },
  );

  @override
  void initState()  {
    initUniLinks();
    print(WEB_SOCKET_URL);
    webSocketManager.init();
    super.initState();
   // addAutoStartup();
    DashboardApiFunction();
  }

  void initUniLinks() async {
    try {
      String? initialLink = await getInitialLink();
      print(initialLink);

      if (initialLink != null) {
        // Handle the initial deep link
        handleDeepLink(context, initialLink);
      }
    } on PlatformException {
      // Handle errors
    }
  }

  void handleDeepLink(BuildContext context, String link) {
    final uri = Uri.parse(link);
    if (uri.pathSegments.length < 2) {
      print("The pathSegments list does not have enough elements");
      return;
    }
    var route = uri.pathSegments[0];
    print("path1: $route");
    var routeId = uri.pathSegments[1];
    print("path2: $routeId");
    if (route == "discussion") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WhizzdomScreen(url: link)));
    }
    // Add your logic to handle the deep link
    print("Received deep link: $link");
  }


void autostart(){
  var austostart = AndroidAutostart.navigateAutoStartSetting;
  AndroidAutostart.customSetComponent(
    manufacturer: "xiaomi",
    pkg: "com.miui.securitycenter",
    cls:
    "com.miui.permcenter.autostart.AutoStartManagementActivity",
  );
}

  void addAutoStartup() async {
    String androidId;
    var deviceInfo = DeviceInfoPlugin(); // import 'dart:io'
    var androidDeviceInfo = await deviceInfo.androidInfo;
    String manufacturer = androidDeviceInfo.manufacturer.toString(); // Replace this with actual device manufacturer

    switch (manufacturer.toLowerCase()) {
      case "xiaomi":
        AndroidAutostart.customSetComponent(
          manufacturer: "xiaomi",
          pkg: "com.miui.securitycenter",
          cls: "com.miui.permcenter.autostart.AutoStartManagementActivity",
        );
        break;
      case "oppo":
        AndroidAutostart.customSetComponent(
          manufacturer: "oppo",
          pkg: "com.coloros.safecenter",
          cls: "com.coloros.safecenter.permission.startup.StartupAppListActivity",
        );
        break;
      case "vivo":
        AndroidAutostart.customSetComponent(
          manufacturer: "vivo",
          pkg: "com.vivo.permissionmanager",
          cls: "com.vivo.permissionmanager.activity.BgStartUpManagerActivity",
        );
        break;
      case "letv":
        AndroidAutostart.customSetComponent(
          manufacturer: "letv",
          pkg: "com.letv.android.letvsafe",
          cls: "com.letv.android.letvsafe.AutobootManageActivity",
        );
        break;
      case "huawei":
      case "honor":
      AndroidAutostart.customSetComponent(
          manufacturer: "huawei",
          pkg: "com.huawei.systemmanager",
          cls: "com.huawei.systemmanager.optimize.process.ProtectActivity",
        );
        break;
      default:
        return;
    }
    AndroidAutostart.navigateAutoStartSetting;
  }

  Future<void> DashboardApiFunction() async {
    try{
      loginStatus= await PreferenceService().getInt("loginStatus")??0;
      empId= await PreferenceService().getString("UserId")??"";
      username = await PreferenceService().getString("UserName")??"";
      email = await PreferenceService().getString("UserEmail")??"";
      session = await PreferenceService().getString("Session_id")??"";
      roleStatus = await PreferenceService().getString("roles")??"";
      var lastLocationTime = await PreferenceService().getString("lastLocationTime");
      print("lastLocationTime:${lastLocationTime}");
      if (await PreferenceService().getString("redirectUrl") == null) {
        webPageUrl = "https://erp.gengroup.in/ci/app/home/web_erp?emp_id=$empId&session_id=$session";
        whizzdomPageUrl = "https://erp.gengroup.in/ci/app/home/web_erp?emp_id=$empId&session_id=$session&login_type=whizzdom&redirect_url=https://whizzdom.gengroup.in";
      } else {
        webPageUrl = "https://erp.gengroup.in/ci/app/home/web_erp?emp_id=$empId&session_id=$session&redirect_url=${await PreferenceService().getString("redirectUrl").toString()}";
        whizzdomPageUrl = "https://erp.gengroup.in/ci/app/home/web_erp?emp_id=$empId&session_id=$session&login_type=whizzdom&redirect_url=${await PreferenceService().getString("redirectUrl").toString()}";
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
              if(online_status==0){
                print("online_status:$online_status");
                webSocketManager.close();
                BackgroundLocation.stopLocationService();
                setState(() {
                  setstatus ="Offline";
                });
                print("setstatus:$setstatus");
              } else if(online_status==1){
                print("online_status:$online_status");
                DateTime Date1;
                DateTime Date2;
                String getCurrentTime() {
                  DateTime now = DateTime.now(); // Get current time
                  DateFormat formatter = DateFormat('HH:mm:ss'); // Define the format
                  return formatter.format(now); // Format and return the time string
                }

                String currentTime = getCurrentTime();

                // var currentTime =  DateTime.now();
                // var df =  DateFormat('HH:mm:ss').format(currentTime);

                if(lastLocationTime!=null){
                  Date1 = DateFormat('HH:mm:ss').parse(currentTime);
                  Date2 = DateFormat('HH:mm:ss').parse(lastLocationTime);
                  print("Date1:${Date1.timeZoneOffset}");
                  print("Date2:${Date2.timeZoneOffset}");

                  Duration difference = Date1.difference(Date2);
                  print("difference:${difference.inMilliseconds }");
                  // var diff = double.parse((Date1.timeZoneOffset - Date2.timeZoneOffset).toString())/1000;
                  var diff = difference.inSeconds/1000;
                  print(diff);
                  if(diff>=20){
                    setState(() {
                      print("diff");
                      setstatus ="Offline";
                    });
                  }else{
                    setState(() {
                      print("nodiff");
                      setstatus ="Online";
                    });

                  }
                }else{
                  setState(() {
                    print("Status knlknn offine");
                    setstatus ="Offline";
                  });
                }
                BackgroundLocation.startLocationService();
                print("setstatus:$setstatus");
              }else if(online_status==2){
                print("online_status:$online_status");
                webSocketManager.close();
                BackgroundLocation.stopLocationService();
                setState(() {
                  setstatus ="Offline";
                });
                print("setstatus:$setstatus");
              }

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
              style:  TextStyle(
                  color: ColorConstant.erp_appColor,
                  fontWeight: FontWeight.w500,
                  fontSize: FontConstant.Size15,
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
              style:  TextStyle(
                  color: ColorConstant.erp_appColor,
                  fontWeight: FontWeight.w500,
                  fontSize: FontConstant.Size15,
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
    return RefreshIndicator(
      color: ColorConstant.erp_appColor,
        onRefresh: _refresh,
        child: WillPopScope(
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
                                  style: TextStyle(
                                    fontSize: FontConstant.Size13,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,

                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 220,// Wrapping username in a Container
                                  child: Text(
                                    "$username",
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: FontConstant.Size20,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: (setstatus=="Offline")?BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.yellowAccent,
                                    ):BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "$setstatus",
                                    style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                      color: Colors.white,
                                    ),
                                  ),
                                ],),
                                SizedBox(height: 10), // Added SizedBox for spacing
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
                                        var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Scanner(from: "dashboard")));
                                        if(res==true){
                                          setState(() {
                                            isLoading = true;
                                            DashboardApiFunction();
                                          });
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
                                            DashboardApiFunction();
                                          });
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
                      Container(
                          child: Expanded(
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.80,
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
                                            DashboardApiFunction();
                                          });

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
                                              style: TextStyle(
                                                fontSize: FontConstant.Size20,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,

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
                                            DashboardApiFunction();
                                          });
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
                                              style:  TextStyle(
                                                fontSize: FontConstant.Size20,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,

                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ),

                                    ),),
                                    SizedBox(height: 15,),

                                    Container(child: InkWell(
                                      onTap: () async {
                                        var res = await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => WhizzdomScreen(url: whizzdomPageUrl)),
                                        );
                                        if(res == true){
                                          setState(() {
                                            isLoading = true;
                                            DashboardApiFunction();
                                          });
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
                                              "assets/ic_light_bulb.svg",
                                              height: 50,
                                              width: 50,
                                            ),
                                            SizedBox(width: 15,),
                                            Text(
                                              "Whizzdom",
                                              style:  TextStyle(
                                                fontSize: FontConstant.Size20,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,

                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ),

                                    ),),
                                  ],
                                  if(roleStatus.contains("432"))...[
                                    SizedBox(height: 15,),
                                    Container(child: InkWell(
                                      onTap: () async {
                                        var res = await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => InventoryScreen()),
                                        );
                                        if(res == true){
                                          setState(() {
                                            isLoading = true;
                                            DashboardApiFunction();
                                          });
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
                                              "assets/ic_inventory.svg",
                                              height: 50,
                                              width: 50,
                                            ),
                                            SizedBox(width: 15,),
                                            Text(
                                              "Inventory",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size20,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,

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
                                        var res = await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => GenTechnicianDashboard()),
                                        );
                                        if(res == true){
                                          setState(() {
                                            isLoading = true;
                                            DashboardApiFunction();
                                          });
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
                                              "assets/ic_technician.svg",
                                              height: 50,
                                              width: 50,
                                            ),
                                            SizedBox(width: 15,),
                                            Text(
                                              "Service Engineers",
                                              style:  TextStyle(
                                                fontSize: FontConstant.Size20,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,

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
                                            DashboardApiFunction();
                                          });
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
                                              style:  TextStyle(
                                                fontSize: FontConstant.Size20,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,

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

                        ),
                      )
                    ],
                  ),
                )
            )
        )

    ));
  }
}
