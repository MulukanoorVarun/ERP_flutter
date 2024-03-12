import 'package:GenERP/screens/AttendanceHistory.dart';
import 'package:GenERP/screens/CheckInScreen.dart';
import 'package:GenERP/screens/CheckOutScreen.dart';
import 'package:GenERP/screens/Login.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
 

import '../Services/other_services.dart';
import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';
import '../Utils/MyWidgets.dart';
import '../Utils/storage.dart';
import '../models/AttendanceListResponse.dart';
import 'background_service.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<AttHistory> attHistory=[];
  int attStatus=0;
  bool isLoading = true;
  @override
  void initState() {
    getAttendanceList();
    super.initState();
  }

  String? empId;
  String? sessionId;
  Future<void> getAttendanceList() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    try {
      print(empId);
      print(sessionId);
      await UserApi.AttendanceListApi(empId,sessionId).then((data) => {
        if (data != null)
          {
            setState(() {
              if(data.sessionExists==1){
                attHistory=data.attHistory!;
                attStatus=data.attStatus!;
                isLoading = false;
              }else{
                isLoading = true;
                PreferenceService().clearPreferences();
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
              }

            })
          }
        else
          {
            print("Something went wrong, Please try again.")}
      });

    } on Exception catch (e) {
      print("$e");
    }
  }


  Future<void> _refresh() async {
    // Simulate a delay to mimic fetching new data from an API
    await Future.delayed(const Duration(seconds: 2));
    // Generate new data or update existing data
    setState(() {
      isLoading = true;
      getAttendanceList();
    });
  }




  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      //backgroundColor: ColorConstant.edit_bg_color,
      // Set your desired height here
        body:(isLoading)?Loaders():SafeArea(
            child:RefreshIndicator(
              onRefresh: _refresh,
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
                        InkWell(
                          onTap: (){
                            Navigator.pop(context,true);
                          },
                          child: SvgPicture.asset(
                            "assets/back_icon.svg",
                            height: 24.0,
                            width: 24.0,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Center(
                          child:Text(
                            "Check In/Out",
                            style: TextStyle(
                                  fontSize: FontConstant.Size20,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
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
                          if(attStatus==0)...[
                          InkWell(
                            onTap: () async {
                              var res = await Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckInScreen()));
                              if(res==true){
                                setState(() {
                                  isLoading = true;
                                });
                                getAttendanceList();
                              }
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
                                    style: TextStyle(
                                        fontSize: FontConstant.Size20,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,

                                      color: ColorConstant.white,
                                    ),
                                  ),
                            ),
                          ),
                          ]
                       // else...[
                         else if(attStatus==1)...[
                            InkWell(
                              onTap: () async{
                                var res = await Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckOutScreen()));
                                if(res==true){
                                  setState(() {
                                    isLoading = true;
                                  });
                                  getAttendanceList();
                                }
                             //   BackgroundLocation.stopLocationService();
                              //  BackgroundLocation.startLocationService();
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
                                  "Check Out",
                                  style: TextStyle(
                                      fontSize: FontConstant.Size20,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,

                                    color: ColorConstant.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: 15,),

                          Row(
                            children: [
                              SizedBox(
                                width: 15
                              ),
                              Text(
                                "Attendance History",
                                style: TextStyle(
                                    fontSize: FontConstant.Size16,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  color: ColorConstant.black,),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>AttendanceHistory()));
                                },
                              child:Text(
                                "View History",
                                style:
                                 TextStyle(
                                    fontSize: FontConstant.Size15,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  color: ColorConstant.black,
                                ),
                              ),
                              ),
                              SizedBox(width: 10,),
    InkWell(
    onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>AttendanceHistory()));
    },
    child:
                              SvgPicture.asset(
                                "assets/forward_slash.svg",
                                height: 25,
                                width: 25,
                              ),),
                              SizedBox(width: 10,),
                            ],
                          ),

                          Expanded(
                            child: GridView.builder(
                                itemCount: attHistory.length,
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
                                                    style:  TextStyle(
                                                        fontSize: FontConstant.Size18,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                      color: ColorConstant.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                    "${attHistory[index].date}",
                                                    style:  TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.bold,
                                                        overflow: TextOverflow.ellipsis,
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
                                                    style: TextStyle(
                                                        fontSize: FontConstant.Size18,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                      color: ColorConstant.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                    "${attHistory[index].checkInTime}",
                                                    style:  TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.bold,
                                                        overflow: TextOverflow.ellipsis,
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
                                                    style: TextStyle(
                                                        fontSize: FontConstant.Size18,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                      color: ColorConstant.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                    "${attHistory[index].checkOutTime}",
                                                    style:  TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.bold,
                                                        overflow: TextOverflow.ellipsis,
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
                ),
            )
        )

    );
  }
}