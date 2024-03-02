import 'package:GenERP/models/loadGeneratorDetailsResponse.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/storage.dart';
import '../../models/ComplaintsSelectionResponse.dart';

class RegisterComplaint extends StatefulWidget {
  final generator_id;
  const RegisterComplaint({Key? key,required this.generator_id}) : super(key: key);

  @override
  State<RegisterComplaint> createState() => _RegisterComplaintState();
}

class _RegisterComplaintState extends State<RegisterComplaint> {
  TextEditingController running_hrs = TextEditingController();
  // TextEditingController Complaint_type_dropdown = TextEditingController();
  // TextEditingController Complaint_category_dropdown = TextEditingController();
  // TextEditingController Complaint_description_dropdown = TextEditingController();
  TextEditingController Complaint_Note = TextEditingController();

   List<ServiceComptType> Complaint_type_dropdown = [];
   List<ServiceComptCat> Complaint_category_dropdown = [];
   List<ServiceComptDesc> Complaint_description_dropdown = [];
  String? selectedType;
  String? selectedCategory;
  String? selectedDescription;

  var session = "";
  var empId = "";
  var cust_name = "";
  var gen_id = "";
  var product_name = "";
  var eng_no = "";
  @override
  void initState(){
    super.initState();
    LoadgeneratorDetailsApifunction();
    LoadComplaintsApifunction();
  }


  Future<void> LoadgeneratorDetailsApifunction() async{
    session= await PreferenceService().getString("Session_id")??"";
    empId= await PreferenceService().getString("UserId")??"";
    try{
      await UserApi.LoadGeneratorDetailsAPI(empId, session,widget.generator_id).then((data)=>{
        if(data!=null){
          setState((){
            if(data.error==0){
              cust_name = data.aname!;
              gen_id = data.genId!;
              product_name = data.spname!;
              eng_no = data.engineNo!;
              // Complaint_type_dropdown = data.complaintTypeList!;
              // Complaint_category_dropdown = data.complaintCategoryList!;
              // Complaint_description_dropdown = data.complaintDescriptionList!;

            }
          })
        }
      });

    } on Error catch(e){
      print(e.toString());
    }
  }

  Future<void> LoadComplaintsApifunction() async{
    try{
      await UserApi.ComplaintSelectionAPI(empId, session,widget.generator_id).then((data)=>{
        if(data!=null){
          setState((){
            if(data.sessionExists==1){
              if(data.error==0){

                Complaint_type_dropdown = data.serviceComptType!;
                Complaint_category_dropdown = data.serviceComptCat!;
                Complaint_description_dropdown = data.serviceComptDesc!;

              }
            }else{
              // PreferenceService().clearPreferences();
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Splash()));
            }

          })
        }
      });

    } on Error catch(e){
      print(e.toString());
    }
  }
  Future<void> SubmitComplaintFunction() async{
    session= await PreferenceService().getString("Session_id")??"";
    empId= await PreferenceService().getString("UserId")??"";
    try{
      await UserApi.SubmitGeneratorComplaintAPI(empId, session,selectedType,selectedCategory,selectedDescription,running_hrs,widget.generator_id,Complaint_Note).then((data)=>{
        if(data!=null){
          setState((){
            if(data.sessionExists==1){
              if(data.error==0){
                toast(context,"Complaint Submitted Successfully");

              }else if(data.error==1){
                toast(context, "Something Went wrong, Please Try Again!");
              }else if(data.error==2){
                toast(context, "Something Went wrong, Please Try Again!");
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
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
                    child: Text("Register Complaint",
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
                    SizedBox(height: 5.0,),
                    Container(

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

                            child: Row(
                              children: [
                                Spacer(),
                                Container(
                                  width: 180,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Customer Name",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                          color: ColorConstant.grey_153,
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 180,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "GEN ID",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                          color: ColorConstant.grey_153,
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),

                          Container(
                            child: Row(
                              children: [
                                Spacer(),
                                Container(
                                  width: 180,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "$cust_name",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 180,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "$gen_id",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),

                          Container(
                            child: Row(
                              children: [
                                Spacer(),
                                Container(
                                  width: 180,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Product Name",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                          color: ColorConstant.grey_153,
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 180,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Engine ID",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                          color: ColorConstant.grey_153,
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),

                          Container(
                            child: Row(
                              children: [
                                Spacer(),
                                Container(
                                  width: 180,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "$product_name",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 180,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "$eng_no",
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),

                          SizedBox(height: 10.0,),
                          DropdownButtonHideUnderline(
                            child: Container(
                              width: 360,
                              child: DropdownButton2<String>(

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
                                items: Complaint_type_dropdown.map((dynamic item1) =>
                                    DropdownMenuItem<String>(
                                      value: item1,
                                      child: Text(
                                        item1,
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
                                value: selectedType,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedType = value;
                                  });
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


                          if(selectedType!=null)...[
                            SizedBox(height: 10.0,),
                            DropdownButtonHideUnderline(
                              child: Container(
                                width: 360,
                                child: DropdownButton2<String>(

                                  isExpanded: true,
                                  hint: const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Select Complaint Category',
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
                                  items: Complaint_category_dropdown
                                      .map((dynamic item) =>
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
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
                                  value: selectedCategory,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedCategory = value;
                                    });
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
                          ],



                          if(selectedType!=null && selectedCategory!=null)...[
                            SizedBox(height: 10.0,),
                            DropdownButtonHideUnderline(
                              child: Container(
                                width: 360,
                                child: DropdownButton2<String>(

                                  isExpanded: true,
                                  hint: const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Select Description',
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
                                  items: Complaint_description_dropdown
                                      .map((dynamic item) =>
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
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
                                  value: selectedDescription,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedDescription = value;
                                      print("selected"+value.toString());
                                    });
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
                          ],


                          SizedBox(height: 10.0,),
                          Container(
                            alignment: Alignment.center,
                            height: 55,
                            margin:EdgeInsets.only(left:15.0,right:15.0),
                            child: TextFormField(
                              controller: running_hrs,
                              cursorColor: ColorConstant.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon:const Icon(Icons.access_time_rounded,size: 28,color: Color(0xFF011842)),
                                hintText: "Running Hours",
                                hintStyle: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                      fontSize: FontConstant.Size18,
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

        if(selectedType!=null && selectedCategory!=null&&selectedDescription!=null)...[
                          SizedBox(height: 10.0,),
                          Container(
                            alignment: Alignment.center,
                            margin:EdgeInsets.only(left:15.0,right:15.0),
                            child: TextFormField(
                              maxLines: 5,
                              controller:Complaint_Note,
                              cursorColor: ColorConstant.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Messaage",
                                hintStyle: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                      fontSize: FontConstant.Size18,
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
                          ],

                          SizedBox(height: 20.0,),
                          Container(
                              child: InkWell(
                                onTap: (){
                                  SubmitComplaintFunction();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                  decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(10.0), ),
                                  child: Text(
                                    "Submit Complaint",
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
                          SizedBox(height: 15.0,),
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