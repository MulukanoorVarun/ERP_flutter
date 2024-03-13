import 'dart:io';

import 'package:GenERP/screens/GenTechnicianModule/TechnicianDashboard.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/Constants.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/storage.dart';
import '../../models/loadGeneratorDetailsResponse.dart';
import '../splash.dart';

class UpdateComplaint extends StatefulWidget {
  final complaint_id;
  const UpdateComplaint({Key? key,required this.complaint_id}) : super(key: key);

  @override
  State<UpdateComplaint> createState() => _UpdateComplaintState();
}

class _UpdateComplaintState extends State<UpdateComplaint> {

  TextEditingController Time = TextEditingController();
  TextEditingController Feedback = TextEditingController();
  TextEditingController FSRNumber = TextEditingController();
  TextEditingController RunningHrs = TextEditingController();


  // String? StatusId;
  // String? selectedType;
  String? statusId;


  final List<Map<String,dynamic>> CompletedStatus = [{"id": "1", "name": "Pending"},
    {"id": "2", "name": "Completed"}];


  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;


  final ImagePicker _picker = ImagePicker();
  File? _image;
  var image_picked = 0;
  var empId = "";
  var session ="";

  @override
void initState() {
  // TODO: implement initState
  super.initState();
}

  Future TimePicker() async {
    return await  showDialog(
      context: context,
      builder: (BuildContext context)  =>
      AlertDialog(
      content: TimePickerDialog(
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      ),
      )
    )??
        false;
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  String formattedTime = "";

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,

    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        formattedTime = selectedTime.hour.toString()+":"+selectedTime.minute.toString();
        // formattedTime = _formatTime(selectedTime.hour, selectedTime.minute);
         // Add this line to check the formatted time
        // Update your UI with the formatted time
      });
  }

  String _formatTime(int hour, int minute) {
    String period = (hour >= 12) ? 'pm' : 'am';
    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }

    String formattedHour = (hour < 10) ? '0$hour' : '$hour';
    String formattedMinute = (minute < 10) ? '0$minute' : '$minute';

    print("formattedTime: $formattedHour:$formattedMinute $period");
    return '$formattedHour:$formattedMinute $period';
  }

  Future<void> UpdateComplaintAPIFunction() async{
    empId= await PreferenceService().getString("UserId")??"";
    session= await PreferenceService().getString("Session_id")??"";
    try {
      UserApi.UpdateComplaintAPI(empId, session,widget.complaint_id,selectedTime.hour.toString()+":"+selectedTime.minute.toString(),Feedback.text,FSRNumber.text,RunningHrs.text,statusId,_image).then((data) =>
      {
        if(data != null){
          setState(() {
            if (data.sessionExists == 1) {
              if (data.error == 0) {
                toast(context,"Complaint Status Updated!");
                dispose();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GenTechnicianDashboard()));
              }
              else if(data.error==1){
                toast(context,"Something Went Wrong, please try again later!");
              }
              else if(data.error==2){
                toast(context,"Tag Generator before updating visit !");
              }
              else if(data.error==3){
                toast(context,"Tag Location before updating visit !");
              }
              else {
                toast(context,"Something Went Wrong, please try again later!");
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
              UpdateComplaintAPIFunction();
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
              UpdateComplaintAPIFunction();
            }
          }
        }
      });
    } catch (e) {
      debugPrint("mmmm: ${e.toString()}");
    }
  }

  CheckValidations(){


    SelectAttachmentDialogue();


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
                    child: Text("Update Complaint",
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
      body:SingleChildScrollView(
        child: Container(
          color: ColorConstant.edit_bg_color,
          height: screenHeight,
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
                                _selectTime(context);

                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                decoration: BoxDecoration(color: ColorConstant.edit_bg_color,borderRadius:BorderRadius.circular(15.0), ),
                                child:

                                Row(
                                  children:[
                                    SizedBox(width: 10,),
                                    Icon(Icons.access_time,size: 28,),
                                    SizedBox(width: 10,),
                                Text(
                                  selectedTime.hour.toString()+":"+selectedTime.minute.toString()??"Enter in Time",
                                  textAlign: TextAlign.center,

                                  style:TextStyle(

                                      color: ColorConstant.grey_153,
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                ]),
                              ),
                            )
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          alignment: Alignment.center,
                          height: 55,
                          margin:EdgeInsets.only(left:15.0,right:15.0),
                          child: TextFormField(
                            controller: Feedback,
                            cursorColor: ColorConstant.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon:const Icon(Icons.feedback,size: 28,color: Color(0xFF011842)),

                              hintText: "Enter Feedback",
                              hintStyle: TextStyle(
                                  fontSize: FontConstant.Size15,
                                  color: ColorConstant.Textfield,
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
                            controller: FSRNumber,
                            cursorColor: ColorConstant.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon:const Icon(Icons.speaker_notes,size: 28,color: Color(0xFF011842)),

                              hintText: "Enter FSR Number",
                              hintStyle: TextStyle(
                                  fontSize: FontConstant.Size15,
                                  color: ColorConstant.Textfield,
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
                            controller: RunningHrs,
                            cursorColor: ColorConstant.black,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon:const Icon(Icons.access_time_rounded,size: 28,color: Color(0xFF011842)),

                              hintText: "Enter Running Hours",
                              hintStyle: TextStyle(
                                  fontSize: FontConstant.Size15,
                                  color: ColorConstant.Textfield,
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
                        DropdownButtonHideUnderline(
                          child: Container(
                            width: 310,
                            child: DropdownButton2< String>(
                              isExpanded: true,
                              hint: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Select Complaint Status',
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
                              items:CompletedStatus.map((complaintStatus) =>
                                  DropdownMenuItem<String>(
                                    value: complaintStatus['name'],
                                    child: Text(
                                      complaintStatus['name'] ?? '',
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
                              value: statusId,
                                onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    statusId = value;
                                    print("statusId:${statusId}");
                                    // print("Selected Complaint Type: ${value.name}, ID: ${value.id}");
                                    // selectedType = value?.name;
                                    // selectedTypeId = value?.id;
                                    // print("hfjkshfg"+selectedTypeId.toString());
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

                        SizedBox(height: 50.0,),
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
                                        "SCAN NOW",
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
                        ),],
                    ),

                  ),

                ],
              ),

            ),
          ),
        ]),
        ),
      )
    );
  }

}