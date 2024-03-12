import 'package:GenERP/Services/other_services.dart';
import 'package:GenERP/Services/user_api.dart';
import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTechnicianModule/AddAccount.dart';
import 'package:GenERP/screens/AttendanceHistory.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/GenTechnicianModule/FolloUpListScreen.dart';
import 'package:GenERP/screens/GenTracker/ComplaintHistory.dart';
import 'package:GenERP/screens/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../../models/ViewVisitDetailsResponse.dart';
import '../splash.dart';

class ViewVisitDetails extends StatefulWidget {
  final complaintId;
  const ViewVisitDetails({Key? key, required this.complaintId}) : super(key: key);
  @override
  State<ViewVisitDetails> createState() => _ViewVisitDetailsState();
}

class _ViewVisitDetailsState extends State<ViewVisitDetails> {
  var session = "";
  var empId = "";
  bool isLoading = true;
  Complaintdetails? complaintdetails;

  @override
  void initState() {
    super.initState();
    LoadVisitDetailsAPI();
  }

  @override
  void onDispose(){
    super.dispose();
  }

  Future<void> _refresh() async {
    // Simulate a delay to mimic fetching new data from an API
    await Future.delayed(const Duration(seconds: 2));
    // Generate new data or update existing data
    setState(() {
      isLoading = true;
      LoadVisitDetailsAPI();
    });
  }

  Future<void> LoadVisitDetailsAPI() async{
    session= await PreferenceService().getString("Session_id")??"";
    empId= await PreferenceService().getString("UserId")??"";
    try{
      print("complaintId:${widget.complaintId}");
      await UserApi.loadVisitDetailsAPI(empId, session,widget.complaintId).then((data)=>{
        if(data!=null){
          setState((){
              if(data.error==0){
                complaintdetails=data.complaintDetails!;
                isLoading = false;
              }else{
                toast(context,"Something Went Wrong, Please try again!");
                print("error");
              }
            })
        }else{
          toast(context,"No response From the server, Please try Again!"),
          print("error2")
        }
      });

    } on Error catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(onRefresh: _refresh,color: ColorConstant.erp_appColor,child: Scaffold(
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
                      child: Text("Visit Details",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorConstant.white,
                            fontSize: FontConstant.Size18,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: const SizedBox(
                      width: 40,
                      height: 40,
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
        body:(isLoading)?Loaders():SingleChildScrollView( child:Container(
          color: ColorConstant.erp_appColor,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
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

                      SizedBox(height: 5.0,),
                      //customer details
                      Container(
                        height: screenHeight*0.28,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child:
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(7.5,7.5,0,0),
                              child: Text("Customer Details", style: TextStyle(
                                fontSize: FontConstant.Size18,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                                color: ColorConstant.erp_appColor,
                              ),),),
                            Container(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Container(
                                      width:screenWidth*0.9,
                                      child:Divider(thickness: 0.5,color: Colors.grey) ,
                                    ),
                                    Spacer(),

                                  ],
                                )
                            ),
                            SizedBox(height: 5.0,),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Company Name",
                                          textAlign: TextAlign.start,
                                          style:  TextStyle(
                                              color: ColorConstant.grey_153,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Mobile Number",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.grey_153,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          complaintdetails?.cname ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style:  TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          complaintdetails?.mob1 ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Contact Person Number",
                                          textAlign: TextAlign.start,
                                          style:  TextStyle(
                                              color: ColorConstant.grey_153,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Mail ID",
                                          textAlign: TextAlign.start,
                                          style:  TextStyle(
                                              color: ColorConstant.grey_153,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          complaintdetails?.mob2 ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          complaintdetails?.mail ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),

                                  SizedBox(height: 5.0,),
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                      SizedBox(height: 10.0,),
                      //generator details


                      Container(
                        height: screenHeight*0.35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child:
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(7.5,7.5,0,0),
                              child: Text("Generator Details", style:  TextStyle(
                                fontSize: FontConstant.Size18,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                                color: ColorConstant.erp_appColor,
                              ),),),
                            Container(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Container(
                                      width:screenWidth*0.9,
                                      child:Divider(thickness: 0.5,color: Colors.grey) ,
                                    ),
                                    Spacer(),

                                  ],
                                )
                            ),
                            SizedBox(height: 5.0,),
                            Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "GEN ID",
                                            textAlign: TextAlign.start,
                                            style:
                                            TextStyle(
                                                color: ColorConstant.grey_153,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Product Name",
                                            textAlign: TextAlign.start,
                                            style:  TextStyle(
                                                color: ColorConstant.grey_153,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            complaintdetails?.genHashId ?? "",
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style:  TextStyle(
                                                color: ColorConstant.black,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            complaintdetails?.spname ?? "",
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style:  TextStyle(
                                                color: ColorConstant.black,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Engine Number",
                                            textAlign: TextAlign.start,
                                            style:  TextStyle(
                                                color: ColorConstant.grey_153,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Engine Model",
                                            textAlign: TextAlign.start,
                                            style:  TextStyle(
                                                color: ColorConstant.grey_153,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            complaintdetails?.engineNo ?? "",
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstant.black,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            complaintdetails?.engineModel ?? "",
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style:
                                            TextStyle(
                                                color: ColorConstant.black,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Address",
                                            textAlign: TextAlign.start,
                                            style:  TextStyle(
                                                color: ColorConstant.grey_153,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Date of Supply",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstant.grey_153,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            complaintdetails?.address ?? "",
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style:TextStyle(
                                                color: ColorConstant.black,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            complaintdetails?.dateOfSupply ?? "",
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstant.black,
                                                fontSize: FontConstant.Size15,
                                                fontWeight: FontWeight.w300),

                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),

                                  ],
                                )
                            )
                          ],
                        ),

                      ),
                      SizedBox(height: 15.0,),

                      Container(
                        height: screenHeight*0.28,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child:
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(7.5,7.5,0,0),
                              child: Text("Complaint Details", style: TextStyle(
                                fontSize: FontConstant.Size18,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,

                                color: ColorConstant.erp_appColor,
                              ),),),
                            Container(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Container(
                                      width:screenWidth*0.9,
                                      child:Divider(thickness: 0.5,color: Colors.grey) ,
                                    ),
                                    Spacer(),

                                  ],
                                )
                            ),
                            SizedBox(height: 5.0,),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Complaint ID",
                                          textAlign: TextAlign.start,
                                          style:  TextStyle(
                                              color: ColorConstant.grey_153,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Opened Date",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.grey_153,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          complaintdetails?.complaintId ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style:  TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          complaintdetails?.openedDate ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Complaint Description",
                                          textAlign: TextAlign.start,
                                          style:  TextStyle(
                                              color: ColorConstant.grey_153,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Complaint Type",
                                          textAlign: TextAlign.start,
                                          style:  TextStyle(
                                              color: ColorConstant.grey_153,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          complaintdetails?.complaintDesc ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          complaintdetails?.complaintType ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w300),

                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),

                                  SizedBox(height: 5.0,),
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                      SizedBox(height: 10.0,),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            child: InkWell(
                              onTap: () async {

                                var res =  await Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowUpList(complaintId:complaintdetails!.complaintId)));
                                if(res==true){
                                  setState(() {
                                    isLoading = true;
                                    LoadVisitDetailsAPI();
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(10.0), ),
                                child: Text(
                                  "View Follow Up",
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                    fontFamily: 'Nexa',
                                    color: ColorConstant.white,
                                    fontSize: FontConstant.Size15,
                                  ),
                                ),
                              ),
                            )
                        ),
                      )

                    ],
                  ),

                ),
              ),
            ],
          )
        ),
        )),);

  }
}
