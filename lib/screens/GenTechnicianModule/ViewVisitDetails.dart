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
import '../splash.dart';

class ViewVisitDetails extends StatefulWidget {

  final complaint_id;
  const ViewVisitDetails({Key? key, required this.complaint_id,}) : super(key: key);
  @override
  State<ViewVisitDetails> createState() => _ViewVisitDetailsState();
}

class _ViewVisitDetailsState extends State<ViewVisitDetails> {
  var session = "";
  var empId = "";
  var comp_name = "";
  var Cust_name = "";
  var mob_num = "";
  var alt_mob_num = "";
  var mail_id = "";
  var address = "";
  var p_name = "";
  var eng_model = "";
  var dg_set_num = "";
  var batt_num = "";
  var status = "";
  var date_of_eng_sale = "";
  var disp_date = "";
  var date_of_sup = "";

  var gen_id = "";
  var eng_no = "";
  var actname = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadgeneratorDetailsApifunction();
  }

  @override
  void onDispose(){
    super.dispose();
  }

  Future<void> LoadgeneratorDetailsApifunction() async{
    session= await PreferenceService().getString("Session_id")??"";
    empId= await PreferenceService().getString("UserId")??"";
    try{
      await UserApi.LoadGeneratorDetailsAPI(empId, session,"").then((data)=>{
        if(data!=null){
          setState((){
            if(data.sessionExists==1){
              if(data.error==0){
                comp_name = data.aname!;
                eng_model = data.emodel!;
                p_name = data.spname!;
                mob_num = data.mob1!;
                alt_mob_num = data.mob2!;
                mail_id = data.mail!;
                Cust_name = data.cname!;
                date_of_eng_sale=data.dateOfEngineSale!;
                batt_num = data.btryNo!;
                dg_set_num = data.dgSetNo!;
                address = data.address!;
                date_of_sup = data.dispDate!;
                disp_date = data.dispDate!;
                status = data.status!;
                gen_id = data.genId!;
                eng_no = data.engineNo!;
                PreferenceService().saveString("EngineNumber",data.engineNo!);
                print("EngineNumber"+data.engineNo!);
                // data.nextService!;
                // data.cmsngDate!;
                // data.state!;
                // data.district!;
                // data.altNo!;
                //

                print("littu");
              }else{
                toast(context,"Something Went Wrong, Please try again!");
                print("error");
              }
            }else{
              PreferenceService().clearPreferences();
              toast(context,"Your Session expired, Please Login Again!");
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Splash()));
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
                if(actname=="NearByGenerators")...[
                  Container(
                    child: IconButton(
                      onPressed: () {

                      },
                      icon: const Icon(
                        Icons.assistant_direction_sharp,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]


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
      body:SingleChildScrollView( child:Container(
        color: ColorConstant.erp_appColor,
        child: Expanded(
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
                                    "$comp_name",
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
                                    "$Cust_name",
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
                                    "$mob_num",
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
                                    "$alt_mob_num",
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
                  height: screenHeight*0.32,
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
                                      "$p_name",
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
                                      "$date_of_eng_sale",
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
                                      "$eng_model",
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
                                      "$disp_date",
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
                                      "$dg_set_num",
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
                                      "$disp_date",
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
                                    "$comp_name",
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
                                    "$Cust_name",
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
                                    "$mob_num",
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
                                    "$alt_mob_num",
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
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowUpList()));
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
      ),
    ));

  }
}
