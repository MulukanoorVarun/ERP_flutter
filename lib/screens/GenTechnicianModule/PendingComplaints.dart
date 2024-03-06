import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:GenERP/screens/GenTracker/TagGenerator.dart';
import 'package:GenERP/screens/GenTracker/TagLocation.dart';
import 'package:GenERP/screens/GenTracker/UpdateComplaint.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../../models/TechniciansPendingComplaintsResponse.dart';
import 'PaymentDetails.dart';

class PendingComplaints extends StatefulWidget {
  const PendingComplaints({Key? key}) : super(key: key);

  @override
  State<PendingComplaints> createState() => _PendingComplaintsState();
}

class _PendingComplaintsState extends State<PendingComplaints> {

  bool isLoading = true;
  var empId = "";
  var session =  "";
  List<TP_List>? tpech_comp_list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TechnicianPendingComplaints();
  }

  Future<void> TechnicianPendingComplaints() async{
    empId= await PreferenceService().getString("UserId")??"";
    session= await PreferenceService().getString("Session_id")??"";
    try {
      UserApi.LoadTechnicianComplaintsAPI(
          empId, session).then((data) =>
      {
        if(data != null){
          setState(() {
            if (data.sessionExists == 1) {
              if (data.error == 0) {
                tpech_comp_list = data.list!;
                isLoading = false;
              } else {
                isLoading = false;
              }
            } else {
              PreferenceService().clearPreferences();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Splash()));
            }
          })
        }
      });
    } on Error catch (e) {
      print(e.toString());
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
                      child: Text("Pending Complaints",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorConstant.white,
                            fontSize: FontConstant.Size18,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                  Spacer(),
                  Container(
                  child: InkWell(
                  onTap: () async{
                    await Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScanner(title:"pendingComplaints",)));
                    },
                  child:SvgPicture.asset(
                    "assets/images/qr_scanner.svg",
                    height: 35,
                    width: 35,
                  ),
                  ),
                  ),
                  SizedBox(width: 15,)
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
                        itemCount: tpech_comp_list!.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (MediaQuery.of(context).size.width < 600)
                                ? 1  // 2 items in a row for mobile
                                : 4, // 4 items in a row for tablet
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 2,
                            childAspectRatio:
                            (255 / 165)),
                        padding: const EdgeInsets.all(5),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if(tpech_comp_list!.length>0){
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
                                              height: 30,
                                              width: 30,
                                            ),
                                            SizedBox(width: 10,),
                                            Container(
                                              width: 130,
                                              child: Text(
                                                tpech_comp_list![index].companyName??"",
                                                maxLines: 2,
                                                style:  TextStyle(
                                                  fontSize: FontConstant.Size15,
                                                  fontWeight: FontWeight.w400,
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
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 130,
                                                    child: Text(

                                                      tpech_comp_list![index].productName??"",
                                                      maxLines: 3,

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
                                            Divider(),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  SvgPicture.asset(
                                                    "assets/ic_tools.svg",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  SizedBox(width: 10),
                                                 Container(
                                                   width: 130,
                                                   child:  Text(
                                                     tpech_comp_list![index].complaintCategory??"",
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
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  SvgPicture.asset(
                                                    "assets/ic_location.svg",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 130,

                                                    child: Text(
                                                      tpech_comp_list![index].address??"",
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
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
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  SvgPicture.asset(
                                                    "assets/ic_complaint.svg",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 130,
                                                    child: Text(
                                                      tpech_comp_list![index].complaintId??"",
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
                                        SizedBox(height: 15,),
                                        Row(
                                          children: [
                                            Spacer(),
                                            InkWell(
                                              onTap: (){
                                                if(tpech_comp_list![index].mobileNo!=null){
                                                  var mobile = tpech_comp_list![index].mobileNo??"";
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
                                              onTap: () async {
                                                if(tpech_comp_list![index].loc!=null){
                                                  var loc = tpech_comp_list![index].loc?.split(",").toString();
                                                  // var uri = String.format(Locale.ENGLISH, "http://maps.google.com/maps?q=loc:%f,%f", res[0].toDouble(), res[1].toDouble())
                                                  var uri = Uri.parse("google.navigation:q=${loc![0]},${loc![1]}&mode=d");
                                                  if (await canLaunch(uri.toString())) {
                                                      await launch(uri.toString());
                                                      } else {
                                                      throw 'Could not launch ${uri.toString()}';
                                                      }
                                                  // val intent = Intent(Intent.ACTION_VIEW, Uri.parse(uri))
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                "assets/ic_location1.svg",
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: (){
                                                //complaintStatus_navigation
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateComplaint(complaint_id:  tpech_comp_list![index].complaintId!)));
                                                
                                              },
                                              child: SvgPicture.asset(
                                                "assets/ic_document.svg",
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),

                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: (){
                                                //paymentDetails_navigation
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                  PaymentDetails(
                                                  account_name: "generator",
                                                  name: "",
                                                  genId:"",
                                                  refId: tpech_comp_list![index].complaintId!,
                                                ),
                                                ));
                                                PreferenceService().saveString("genId", tpech_comp_list![index].genId!);
                                              },
                                              child: SvgPicture.asset(
                                                "assets/ic_pending.svg",
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