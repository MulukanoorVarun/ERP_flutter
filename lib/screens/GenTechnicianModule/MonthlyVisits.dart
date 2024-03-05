import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:GenERP/screens/GenTracker/TagGenerator.dart';
import 'package:GenERP/screens/GenTracker/TagLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../../models/TodayVisitResponse.dart';

class MonthlyVisitsScreen extends StatefulWidget {
  const MonthlyVisitsScreen({Key? key}) : super(key: key);

  @override
  State<MonthlyVisitsScreen> createState() => _TodayVisitsScreenState();
}

class _TodayVisitsScreenState extends State<MonthlyVisitsScreen> {

  bool isLoading = true;
  List<Visitlist> monthvisitlist=[];

  @override
  void initState() {
    LoadMonthVisitsListAPI();
    super.initState();
  }

  String? empId;
  String? sessionId;
  Future<void> LoadMonthVisitsListAPI() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    try {
      print(empId);
      print(sessionId);
      await UserApi.getMonthVisitsListAPI("752","bb1bd615748920990e679a575b0684cf3f53367620dd775a47e4a771bde22f313f4d7722ce131d65427ce054053aed8eb0ca").then((data) => {
        if (data != null)
          {
            setState(() {
              if(data.error==0){
                monthvisitlist=data.list!;
                isLoading = false;
              }else{

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

  @override
  Widget build(BuildContext context) {
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
                      child: Text("Month Visits",
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
        body: (isLoading) ? Loaders() :
        SafeArea(
          child: Container(
            color: ColorConstant.erp_appColor,
            child: Column(
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
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: GridView.builder(
                        itemCount: monthvisitlist.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (MediaQuery.of(context).size.width < 600)
                                ? 1  // 2 items in a row for mobile
                                : 4, // 4 items in a row for tablet
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 2,
                            childAspectRatio:
                            (255 / 160)),
                        padding: const EdgeInsets.all(5),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if(monthvisitlist!.length>0){
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
                                            SvgPicture.asset(
                                              "assets/ic_building.svg",
                                              height: 20,
                                              width: 20,
                                            ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: 250,
                                              child: Text(
                                                monthvisitlist[index].companyName??"",
                                                maxLines: 2,
                                                style:  TextStyle(
                                                  fontSize: FontConstant.Size13,
                                                  fontWeight: FontWeight.w300,
                                                  overflow: TextOverflow.ellipsis,
                                                  color: ColorConstant.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  SvgPicture.asset(
                                                    "assets/ic_generators.svg",
                                                    height: 20,
                                                    width: 18,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 120,
                                                    child: Text(
                                                      monthvisitlist[index].productName??"",
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        fontSize: FontConstant.Size13,
                                                        fontWeight: FontWeight.w300,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: ColorConstant.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  SvgPicture.asset(
                                                    "assets/ic_tools.svg",
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 120,
                                                    child:  Text(
                                                      monthvisitlist[index].complaintCategory??"",
                                                      style: TextStyle(
                                                        fontSize: FontConstant.Size13,
                                                        fontWeight: FontWeight.w300,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: ColorConstant.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 10,),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  SvgPicture.asset(
                                                    "assets/ic_location.svg",
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 120,
                                                    child: Text(
                                                      monthvisitlist[index].address??"",
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: FontConstant.Size13,
                                                        fontWeight: FontWeight.w300,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: ColorConstant.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  SvgPicture.asset(
                                                    "assets/ic_complaint.svg",
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 120,
                                                    child: Text(
                                                      monthvisitlist[index].complaintId??"",
                                                      style: TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: ColorConstant.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Spacer(),
                                            InkWell(
                                              onTap: (){
                                                if(monthvisitlist![index].mobileNo!=null){
                                                  var mobile = monthvisitlist![index].mobileNo??"";
                                                  launch('tel://${mobile}');
                                                }

                                              },
                                              child: SvgPicture.asset(
                                                "assets/ic_call.svg",
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: (){
                                                //paymentDetails_navigation
                                              },
                                              child: SvgPicture.asset(
                                                "assets/ic_payments.svg",
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: (){
                                                //viewVisitDetails_navigation
                                              },
                                              child: SvgPicture.asset(
                                                "assets/ic_back_button.svg",
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                      ]),


                                  // CategoryProductCard(context,UpdateFavoriteFunction,AddToCartFunction,mak,productlist[index])
                                ));
                          }else{
                            return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "No Data Available",
                                  style: TextStyle(
                                    fontSize: FontConstant.Size18,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    color: ColorConstant.erp_appColor,
                                  ),
                                ));
                          }
                          return null;
                        }),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}