import 'package:GenERP/Services/other_services.dart';
import 'package:GenERP/Services/user_api.dart';
import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/AddAccount.dart';
import 'package:GenERP/screens/AttendanceHistory.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../Scanner.dart';

class TagGenerator extends StatefulWidget {
  const TagGenerator({Key? key}) : super(key: key);

  @override
  State<TagGenerator> createState() => _TagGeneratorState();
}

class _TagGeneratorState extends State<TagGenerator> {
  var session = "";
  var empId = "";
  TextEditingController Generator_id = TextEditingController();
  TextEditingController Engine_no = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void onDispose(){
    Generator_id.dispose();
    Engine_no.dispose();
    super.dispose();
  }
  Future<void> TagGeneratorAPIFunction() async{
    session= await PreferenceService().getString("Session_id")??"";
    empId= await PreferenceService().getString("UserId")??"";
    try{
      await UserApi.TagGeneratorAPI(empId, session,Generator_id.text,Engine_no.text).then((data)=>{
        if(data!=null){
          setState((){
            if(data.sessionExists==1){
              if(data.error==0){
                toast(context,data.message);

              }else if(data.error==1){
                toast(context, data.message);
              }else if(data.error==2){
                toast(context, data.message);
              }
              else{
                toast(context, "Something Went wrong, Please Try Again!");
              }
            }else{
              toast(context, "Your session has expired, please login again!");
            }

          })
        }else{

        }
      });

    } on Error catch(e){
      print(e.toString());
    }
  }

  Future TagGeneratorDialogue() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 20,
        shadowColor: Colors.black,
        title: Align(
            alignment: Alignment.topLeft,
            child:Text("#"+Generator_id.text,style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: FontConstant.Size22,
                  fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline
              ),
            ),)
        ),
        content:
       Container(
         height: 125,
         child:  Column
           (children:[
           Container(
             alignment: Alignment.center,
             width:450,
             height: 50,
             margin:EdgeInsets.only(left:15.0,right:15.0),
             child: TextFormField(
               controller: Engine_no,
               cursorColor: ColorConstant.black,
               keyboardType: TextInputType.text,
               decoration: InputDecoration(
                 hintText: "Enter Engine Number",
                 hintStyle: GoogleFonts.ubuntu(
                   textStyle: TextStyle(
                       fontSize: FontConstant.Size15,
                       color: ColorConstant.Textfield,
                       fontWeight: FontWeight.w400),
                 ),
                 filled: true,
                 fillColor: ColorConstant.edit_bg_color,
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10.0),
                   borderSide: BorderSide(
                       width: 0, color: ColorConstant.edit_bg_color),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10.0),
                   borderSide: BorderSide(
                       width: 0, color: ColorConstant.edit_bg_color),
                 ),
               ),
             ),
           ),
           SizedBox(height: 15,),
           Row(
             children: [
               Container(
                 width:110,
                 height: 50,
                 margin: EdgeInsets.only(left: 15.0,right: 15.0),
                 decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(10.0), ),
                 child: TextButton(
                   style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(ColorConstant.erp_appColor),
                     overlayColor: MaterialStateProperty.all(ColorConstant.erp_appColor),
                   ),
                   onPressed: () =>Navigator.of(context).pop(false),


                   child: Text(
                     "Cancel",
                     style: GoogleFonts.ubuntu(
                       textStyle: TextStyle(
                         color: ColorConstant.white,
                         fontWeight: FontWeight.w300,
                         fontSize: FontConstant.Size15,
                       ),
                     ),
                   ),
                 ),

               ),

               Container(
                 width:110,
                 height: 50,
                 margin: EdgeInsets.only(left: 15.0,right: 15.0),
                 decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(10.0), ),
                 child:  TextButton(
                   style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(ColorConstant.erp_appColor),
                     overlayColor: MaterialStateProperty.all(ColorConstant.erp_appColor),
                   ),
                   onPressed: () =>{

                     setState(() {
                       TagGeneratorAPIFunction();
                     }),
                   },
                   child: Text(
                     "Submit",
                     style: GoogleFonts.ubuntu(
                       textStyle: TextStyle(
                         color: ColorConstant.white,
                         fontWeight: FontWeight.w300,
                         fontSize: FontConstant.Size15,
                       ),
                     ),
                   ),
                 ),
               ),

             ],
           )
         ]),
       ),


      ),
      barrierDismissible: false,
    ) ??
        false;
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
                    child: Text("Tag Generator",
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
        child: Container(
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
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Scanner(from:"tagGenerator")));
                    },
                    child: Container(
                      child: Text("Scan QR Code or Enter ID", style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          fontSize: FontConstant.Size25,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        color: ColorConstant.erp_appColor,
                      ),),),
                  ),
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
                        SizedBox(
                          height: 25,
                        ),
                        Container(

                          child: SvgPicture.asset(
                            "assets/ic_qrcode.svg",
                            height: 350,
                            width: 350,
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
                            controller: Generator_id,
                            cursorColor: ColorConstant.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Enter Generator ID",
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
                                if(Generator_id.text.isNotEmpty){
                                  TagGeneratorDialogue();
                                }

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
        ),
      )
    );
  }
}
