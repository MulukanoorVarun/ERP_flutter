import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../models/loadGeneratorDetailsResponse.dart';

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

  ComplaintTypeList? selectedComplaintType;
  String? selectedTypeId;
  String? selectedType;
  List<ComplaintTypeList> Complaint_type_dropdown = [];

@override
void initState() {
  // TODO: implement initState
  super.initState();
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
                          alignment: Alignment.center,
                          height: 55,
                          margin:EdgeInsets.only(left:15.0,right:15.0),
                          child: TextFormField(
                            controller: Time,
                            cursorColor: ColorConstant.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon:const Icon(Icons.access_time_rounded,size: 28,color: Color(0xFF011842)),
                              hintText: "Enter In Time",
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
                            keyboardType: TextInputType.text,
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
                            width: 360,
                            child: DropdownButton2<ComplaintTypeList>(
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
                              items:Complaint_type_dropdown.map((complaintType) =>
                                  DropdownMenuItem<ComplaintTypeList>(
                                    value: complaintType,
                                    child: Text(
                                      complaintType.name ?? '',
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
                              value: selectedComplaintType,
                              onChanged: (ComplaintTypeList? value) {
                                if (value != null) {
                                  setState(() {
                                    selectedComplaintType = value;
                                    print("Selected Complaint Type: ${value.name}, ID: ${value.id}");
                                    selectedType = value?.name;
                                    selectedTypeId = value?.id;
                                    print("hfjkshfg"+selectedTypeId.toString());
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

                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                decoration: BoxDecoration(color: ColorConstant.edit_bg_color,borderRadius:BorderRadius.circular(15.0), ),
                                child: Text(
                                  "SCAN NOW",
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                      color: ColorConstant.black,
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w500
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