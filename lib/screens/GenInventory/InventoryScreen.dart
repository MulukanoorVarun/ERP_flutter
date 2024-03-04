import 'package:GenERP/Services/other_services.dart';
import 'package:GenERP/Services/user_api.dart';
import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/AddAccount.dart';
import 'package:GenERP/screens/AttendanceHistory.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/GenInventory/PartDetails.dart';
import 'package:GenERP/screens/GenTracker/GeneratoraDetails.dart';
import 'package:GenERP/screens/GenTracker/RegisterComplaint.dart';
import 'package:GenERP/screens/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../Scanner.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  TextEditingController part_id = TextEditingController();
  var session = "";
  var empId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void onDispose(){
    part_id.dispose();
    super.dispose();
  }


  Future<void> LoadPartDetailsApifunction() async{
    session= await PreferenceService().getString("Session_id")??"";
    empId= await PreferenceService().getString("UserId")??"";
    try{
      await UserApi.LoadPartDetailsAPI(empId, session,part_id.text).then((data)=>{
        if(data!=null){
          setState((){
            if(data.error==0){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PartDetailsScreen(part_id: part_id.text)));
            }
          })
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
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child:Container(
            height: screenHeight,
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
                    SizedBox(height: 15.0,),
                    Container(
                      child: Text("Scan QR Code or Enter ID", style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          fontSize: FontConstant.Size25,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        color: ColorConstant.erp_appColor,
                      ),),),
                    SizedBox(height: 5.0,),
                    Container(
                      height: screenHeight*0.75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child:
                      Column(
                        children: [
                          SizedBox(height: 25.0,),
                          InkWell(
                            onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>Scanner(from:"registerComplaint")));
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
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Spacer(),
                                  Container(
                                    width:130,
                                    child:Divider(thickness: 1,color: Colors.grey) ,
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Text("OR", style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size20,
                                        fontWeight: FontWeight.w300,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: Colors.grey,
                                    ),),),
                                  Spacer(),
                                  Container(
                                    width:130,
                                    child:Divider(thickness: 1,color: Colors.grey) ,
                                  ),
                                  Spacer(),
                                ],
                              )
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            alignment: Alignment.center,
                            height: 55,
                            margin:EdgeInsets.only(left:15.0,right:15.0),
                            child: TextFormField(
                              controller: part_id,
                              cursorColor: ColorConstant.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Enter Part ID",
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
                          SizedBox(height: 20.0,),
                          Container(
                              child: InkWell(
                                onTap: (){
                                  LoadPartDetailsApifunction();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                  decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(10.0), ),
                                  child: Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        color: ColorConstant.white,
                                        fontSize: FontConstant.Size15,
                                      ),),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),

                    ),

                  ],
                ),

              ),
            ),
          )),
    );
  }
}
