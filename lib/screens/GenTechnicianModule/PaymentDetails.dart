import 'dart:io';

import 'package:GenERP/screens/GenTechnicianModule/AddAccount.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/Constants.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/storage.dart';
import '../../models/TechnicianLoadNumbersResponse.dart';
import '../../models/loadGeneratorDetailsResponse.dart';
import '../Login.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PaymentDetails extends StatefulWidget {
final account_name,refId,name,genId;
  const PaymentDetails({Key? key, required this.account_name,required this.name,required this.genId,required this.refId}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {

  TextEditingController Phonenumber = TextEditingController();
  TextEditingController Paymnt = TextEditingController();
  TextEditingController Amount = TextEditingController();
  TextEditingController Reference = TextEditingController();

  PaymentModeList? selectPaymentModeList;
  Contacts? selectContact;
  String? paymentModeID;
  String? PaymentMode;
  String? contactID;
  String? contact;
  List<PaymentModeList> payment_mode_drop_down = [];
  List<Contacts> contacts_drop_down = [];
  // List<String> type = [];
  var type = "";
  var refType = "";
  var refId = "";
  var gen_id = "";
  var account_id = "";
  var CollectionId = 0;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  var image_picked = 0;
  var empId = "";
  var session =  "";
  String enteredOtp = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadNumbersAPI();
  }

  Future<void> LoadNumbersAPI() async{
    empId= await PreferenceService().getString("UserId")??"";
    session= await PreferenceService().getString("Session_id")??"";
    gen_id = await PreferenceService().getString("genId")??"";

    if(widget.account_name=="generator"){
      type = "generator";
      refType ="Complaint";
      refId = widget.refId;

      print("${type}");
      print("${refType}");
      print("${refId}");
    }else{
      type = "account";
      refType ="Account";
      refId = widget.refId;
    }
    try {
     // print("${type}");
      UserApi.LoadContactsTechnicianAPI(
          empId, session,type,gen_id,refId).then((data) =>
      {
        if(data != null){
          setState(() {
            if (data.sessionExists == 1) {
              if (data.error == 0) {
                contacts_drop_down = data.contacts!;
                payment_mode_drop_down = data.paymentModeList!;

              } else {

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

  Future<void> PaymentUpdateAPI() async{
    print(empId);
    print(session);
    print(refType);
    print(refId);
    print(paymentModeID);
    print(Reference.text);
    print(Amount.text);
    print(contact);
    print(contactID);
    print(_image);

    try {
      await UserApi.TechnicianUpdatepaymentAPI(
          empId, session,refType,refId,paymentModeID,Reference.text,Amount.text,contact,contactID,_image).then((data) =>
      {
        if(data != null){
          setState(() {
            if (data.sessionExists == 1) {
              if (data.error == 0) {
                CollectionId = data.paymentCollectionId??0;
               OTPDialogue();

              } else {

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


  Future<void> OTPVerifyAPI() async{
    try {
      UserApi.TechnicianPaymentOTPValidateAPI(
          empId, session,CollectionId,enteredOtp).then((data) =>
      {
        if(data != null){
          setState(() {
            if (data.sessionExists == 1) {
              if (data.error == 0) {
                toast(context,data.message);
                Navigator.pop(context,true);


              } else {
                toast(context,data.message);
              }
            } else {
              PreferenceService().clearPreferences();
              toast(context,data.message);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Splash()));
            }
          })
        }else{

        }
      });
    } on Error catch (e) {
      print(e.toString());
    }
  }


  Future OTPDialogue() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 20,
        shadowColor: Colors.black,
        title: Align(
            alignment: Alignment.center,
            child:Text("Enter OTP",style:  TextStyle(
                color: Colors.black,
                fontSize: FontConstant.Size22,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline

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
              margin:EdgeInsets.only(left:5.0,right:5.0),
              child:
              PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: ColorConstant.Fillcolor,
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                blinkWhenObscuring: true,

                animationType: AnimationType.fade,
                // validator: (v) {
                //   if (v!.length < 3) {
                //     return "I'm from validator";
                //   } else {
                //     return null;
                //   }
                // },
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    fieldOuterPadding:
                    EdgeInsets.only(left: 5, right: 5),
                    activeFillColor: ColorConstant.edit_bg_color,
                    activeColor: ColorConstant.erp_appColor,
                    selectedColor: ColorConstant.Fillcolor,
                    selectedFillColor: ColorConstant.Fillcolor,
                    inactiveFillColor: ColorConstant.Fillcolor,
                    inactiveColor: ColorConstant.Fillcolor,
                    inactiveBorderWidth: 0,
                    activeBorderWidth: 0.5),
                cursorColor: ColorConstant.erp_appColor,
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (String enteredCode) {
                  setState(() {
                    enteredOtp = enteredCode;
                    // clearText = true;
                    OTPVerifyAPI();
                    Navigator.pop(context,true);
                  });
                  debugPrint("Completed");
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (String enteredCode) {
                  debugPrint(enteredCode);
                  setState(() {
                    enteredOtp = enteredCode;
                  });
                },
                onSubmitted: (String enteredCode) {
                  setState(() {
                    enteredOtp = enteredCode;
                    // clearText = true;
                    // Verify_otp();
                  });
                },
                enablePinAutofill: true,
                useExternalAutoFillGroup: true,
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),

              SizedBox(height: 15,),

            Container(
              width:110,
              height: 45,
              margin: EdgeInsets.only(left: 10.0,right: 10.0),
              decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(15.0), ),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ColorConstant.erp_appColor),
                  overlayColor: MaterialStateProperty.all(ColorConstant.erp_appColor),
                ),
                onPressed: () =>

                    {Navigator.of(context).pop(false),
                      OTPVerifyAPI()},


                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: ColorConstant.white,
                    fontWeight: FontWeight.w300,
                    fontSize: FontConstant.Size15,

                  ),
                ),
              ),

            ),
          ]),
        ),


      ),
      barrierDismissible: false,
    ) ??
        false;
  }

  Future SelectAttachmentDialogue() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 20,
        shadowColor: Colors.black,
        title: Align(
            alignment: Alignment.center,
            child:Text("Select Source",style:  TextStyle(
                color: Colors.black,
                fontSize: FontConstant.Size22,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline

            ),)
        ),
        content:
        Container(
          height: 85,
          child:  Column
            (children:[
             InkWell(
               onTap: (){
                 Navigator.of(context).pop(false);
                 _imgFromGallery();
               },
               child:  Container(
                 height: 35,
                 child: Text("Select photo from gallery"),
               ),
             ),
             SizedBox(height: 10,),
             InkWell(
               onTap: (){
                 Navigator.of(context).pop(false);
                 _imgFromCamera();
               },
               child:  Container(
                 height: 35,
                 child: Text("Capture photo from camera"),
               ),
             )
          ]),
        ),


      ),
      barrierDismissible: true,
    ) ??
        false;
  }

  _imgFromCamera() async {
    // Capture a photo
    try {
      final XFile? galleryImage = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: imageQuality
      );
      print("added");
      setState(() {
        _image = File(galleryImage!.path);
        image_picked = 1;
        if (_image != null) {
          var file = FlutterImageCompress.compressWithFile(galleryImage!.path);{
            if (file != null) {
              CheckValidations();
            }
          }
        }

      });
    } catch (e) {
      debugPrint("mmmm: ${e.toString()}");
    }
  }

  _imgFromGallery() async {
    // Pick an image
    try {
      final XFile? galleryImage = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      final bytes = (await galleryImage?.readAsBytes())?.lengthInBytes;
      final kb = bytes! / 1024;
      final mb = kb / 1024;

      debugPrint("Jenny: bytes:$bytes, kb:$kb, mb: $mb");
      setState(() {
        _image = File(galleryImage!.path);
        image_picked = 1;
        if (_image != null) {
          var file = FlutterImageCompress.compressWithFile(galleryImage!.path);{
            if (file != null) {
              CheckValidations();
            }
          }
        }
      });
    } catch (e) {
      debugPrint("mmmm: ${e.toString()}");
    }
  }

  CheckValidations(){
    if(contactID==null||contactID==""){
      toast(context,"Select Phone Number");
    }
    else if(paymentModeID==null||paymentModeID==""){
      toast(context,"Select Payment Mode");
    }
    else if(Amount.text.isEmpty){
      toast(context,"Enter Amount");
    }
    else if(_image == "" || _image==null||image_picked==0){
      toast(context,"Select Attachment");
    }
else{
      PaymentUpdateAPI();
    }

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
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
                      child: Text("Payment Details",
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
        body:Container(
          height: screenHeight,
          color: ColorConstant.edit_bg_color,
          child: SingleChildScrollView(

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
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child:
                      Column(
                        children: [
                          SizedBox(height: 10.0,),
                          Container(
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 55,
                                  margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                  decoration: BoxDecoration(color: ColorConstant.edit_bg_color,borderRadius:BorderRadius.circular(15.0), ),
                                  child: Text(
                                    "${widget.account_name}",
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                        color: ColorConstant.erp_appColor,
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Spacer(),
                              DropdownButtonHideUnderline(
                                child: Container(
                                  width: 250,
                                  child: DropdownButton2<Contacts>(
                                    isExpanded: true,
                                    hint: const Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Select Phone Number',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color:Color(0xFF011842),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items:contacts_drop_down.map((contacts) =>
                                        DropdownMenuItem<Contacts>(
                                          value: contacts,
                                          child: Text(
                                            contacts.name??"",
                                            style: const
                                            TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF011842),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                        ))
                                        .toList(),
                                    value: selectContact,
                                    onChanged: (Contacts? value) {
                                      if (value != null) {
                                        setState(() {
                                          selectContact = value;
                                          print("Selected Complaint Type: ${value.name}, ID: ${value.mob1}");
                                          contact = value?.name;
                                          contactID = value?.mob1;
                                          print("hfjkshfg"+contactID.toString());
                                        });
                                      }
                                    },

                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 160,
                                      padding: const EdgeInsets.only(left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Color(0xFFE4EFF9),
                                      ),

                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                      ),
                                      iconSize: 30,
                                      iconEnabledColor: Color(0xFF011842),
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Color(0xFFE4EFF9),
                                      ),

                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(15),
                                        thickness: MaterialStateProperty.all<double>(6),
                                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),

                              ),
                              Spacer(),
                              Container(
                                height: 45,
                                width: 45,

                                decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius: BorderRadius.circular(7.0)),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddContact(actName: widget.account_name=="generator",id: widget.refId,)));
                                  },
                                  child: SvgPicture.asset(
                                    "assets/ic_add.svg",
                                    fit: BoxFit.scaleDown,
                                  ),

                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          DropdownButtonHideUnderline(
                            child: Container(
                              width: 360,
                              child: DropdownButton2<PaymentModeList>(
                                isExpanded: true,
                                hint: const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Select Complaint Type',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color:Color(0xFF011842),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items:payment_mode_drop_down.map((paymentMode) =>
                                    DropdownMenuItem<PaymentModeList>(
                                      value: paymentMode,
                                      child: Text(
                                        paymentMode.name ?? '',
                                        style: const
                                        TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF011842),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                    ))
                                    .toList(),
                                value: selectPaymentModeList,
                                onChanged: (PaymentModeList? value) {
                                  if (value != null) {
                                    setState(() {
                                      selectPaymentModeList = value;
                                      print("Selected Complaint Type: ${value.name}, ID: ${value.id}");
                                      PaymentMode = value?.name;
                                      paymentModeID = value?.id;
                                      print("hfjkshfg"+paymentModeID.toString());
                                    });
                                  }
                                },

                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 160,
                                  padding: const EdgeInsets.only(left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color(0xFFE4EFF9),
                                  ),

                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down_outlined,
                                  ),
                                  iconSize: 30,
                                  iconEnabledColor: Color(0xFF011842),
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color(0xFFE4EFF9),
                                  ),

                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(15),
                                    thickness: MaterialStateProperty.all<double>(6),
                                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),

                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            alignment: Alignment.center,
                            height: 55,
                            margin:EdgeInsets.only(left:15.0,right:15.0),
                            child: TextFormField(
                              controller: Amount,
                              cursorColor: ColorConstant.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Enter Amount*",
                                hintStyle: TextStyle(
                                    fontSize: FontConstant.Size15,
                                    color: ColorConstant.erp_appColor,
                                    fontWeight: FontWeight.w400),
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
                          SizedBox(height: 10.0,),
                          Container(
                            alignment: Alignment.center,
                            height: 55,
                            margin:EdgeInsets.only(left:15.0,right:15.0),
                            child: TextFormField(
                              controller: Reference,
                              cursorColor: ColorConstant.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Enter Reference Number*",
                                hintStyle: TextStyle(
                                    fontSize: FontConstant.Size15,
                                    color: ColorConstant.erp_appColor,
                                    fontWeight: FontWeight.w400),
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
                          SizedBox(height: 10.0,),
                          Container(
                              child: InkWell(
                                onTap: (){
                                  SelectAttachmentDialogue();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                  decoration: BoxDecoration(color: ColorConstant.edit_bg_color,borderRadius:BorderRadius.circular(15.0), ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 25,),
                                      SvgPicture.asset(
                                        "assets/ic_assignment.svg",
                                        fit: BoxFit.scaleDown,
                                      ),
                                      Spacer(),
                                      Text(
                                        "Attachment File",
                                        textAlign: TextAlign.center,
                                        style:TextStyle(
                                            color: ColorConstant.erp_appColor,
                                            fontSize: FontConstant.Size15,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Spacer(),

                                    ],
                                  )
                                ),
                              )
                          ),

                          SizedBox(height: 50.0,),
                          Container(
                              child: InkWell(
                                onTap: (){
                                  CheckValidations();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                  decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(30.0), ),
                                  child: Text(
                                    "Send OTP",
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      color: ColorConstant.white,
                                      fontSize: FontConstant.Size15,
                                    ),
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