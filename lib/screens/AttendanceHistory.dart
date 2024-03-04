import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 
import 'package:intl/intl.dart';

import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';
import '../Utils/storage.dart';
import '../models/AttendanceHistoryresponse.dart';
import '../models/DayWiseAttendance.dart';
import 'CalenderWidget.dart';

class AttendanceHistory extends StatefulWidget{
  const AttendanceHistory({Key?key}): super(key:key);

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory>{
  late DateTime month;
  late int monthNo;

  int presentDays=0;
  int absentDays=0;
  int holidays=0;
  int latePenalties=0;
  String?dateColor;
  List<Map<String, dynamic>> dateArrayList = [];
  List<Map<String, dynamic>> penalityArrayList = [];

  String date="";
  String intime="";
  String outtime="";
  String inlocation="";
  String outlocation="";
  String penalties="";
  String SelectedDate="";

  @override
  void initState() {
    month = DateTime.now();
    getMonth(DateFormat('MMMM').format(month));
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dateWiseAttendance(formattedDate);
    super.initState();
  }

  void setPreviousMonth() {
    setState(() {
    month = DateTime(month.year, month.month - 1);
    dateArrayList = [];
    getMonth(DateFormat('MMMM').format(month));
    });
  }

// Function to set the next month
  void setNextMonth() {
    setState(() {
    month = DateTime(month.year, month.month + 1);
    dateArrayList = [];
    getMonth(DateFormat('MMMM').format(month));
    });
  }


  String? empId;
  String? sessionId;
  String year="";
  void getMonth(String monthName) async{
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    print("Month:${monthName}");
    switch (monthName) {
      case "January":
        monthNo = 1;
        break;
      case "February":
        monthNo = 2;
        break;
      case "March":
        monthNo = 3;
        break;
      case "April":
        monthNo = 4;
        break;
      case "May":
        monthNo = 5;
        break;
      case "June":
        monthNo = 6;
        break;
      case "July":
        monthNo = 7;
        break;
      case "August":
        monthNo = 8;
        break;
      case "September":
        monthNo = 9;
        break;
      case "October":
        monthNo = 10;
        break;
      case "November":
        monthNo = 11;
        break;
      case "December":
        monthNo = 12;
        break;
      default:
        monthNo = 1; // Default to January if monthName is not recognized
        break;
    }

    year = DateFormat('yyyy').format(month);

    loadAttendanceDetails();
  }
  String? firstKey;
  dynamic? firstValue;
  String? formattedDayOfWeek;
  int startingIndex=0;


  Future<void> dateWiseAttendance(Selecteddate) async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    try {

      await UserApi.DateWiseAttendanceApi(empId,sessionId,Selecteddate).then((data) => {
        if (data != null)
          {
            setState(() {
            date=data.date!;
            intime=data.intime!;
            outtime=data.outtime!;
            inlocation=data.inlocation!;
            outlocation=data.outlocation!;
            penalties=data.latePenalties!;
            })
          } else
          {
            print("Something went wrong, Please try again.")}
      });

    } on Exception catch (e) {
      print("$e");
    }
  }

  Future<void> loadAttendanceDetails() async {
    print("monthNo:${monthNo}");
    try {
      final data = await UserApi.LoadAttendanceDetails(empId, sessionId, monthNo, year);
      if (data != null) {
        final decodedResponse = jsonDecode(data);
        setState(() {
        presentDays = decodedResponse['present_days'] ?? 0;
        absentDays = decodedResponse['absent_days'] ?? 0;
        holidays = decodedResponse['holidays'] ?? 0;
        latePenalties = decodedResponse['late_penalties'] ?? 0;
        Map<String, dynamic>? dateArray = decodedResponse['date_array'];
        Map<String, dynamic>? latePenaltyArray = decodedResponse['late_penalty_array'];

        // Assuming dateArray is a Map<String, dynamic>

          if (dateArray != null && dateArray.isNotEmpty) {
            firstKey = dateArray.keys.elementAt(0);
            firstValue = dateArray[firstKey];
          }

        print('First Key: $firstKey, First Value: $firstValue');


        if (dateArray != null) {
          dateArray.forEach((key, value) {
            // Split the key string to extract the date part
            List<String> parts = key.split("-");
            String date = parts[2];
            // Remove leading zeros
            date = int.parse(date).toString();
            dateArrayList.add({date: value});
          //  print('Date: $date, Value: $value');
          });
        }

        if (latePenaltyArray != null) {
          latePenaltyArray.forEach((key, value) {
            penalityArrayList.add({key: value});
           // print('Date: $key, Value: $value');
          });
        }
        });
      } else {
        print("Null Response");
      }

    } catch (e) {
      print("Exception: $e");
    }
  }

  Future InfoDialogue() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Information',
            style: TextStyle(
                  color: Colors.black,
                  fontSize: FontConstant.Size25,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 180), // Set the maximum height here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Holiday',
                        style:  TextStyle(
                              color: Colors.black,
                              fontSize: FontConstant.Size18,
                              fontWeight: FontWeight.w500,

                          ),
                        
                      ),
                    ]
                ),
                SizedBox(height: 10,),
                Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Present',
                        style:  TextStyle(
                              color: Colors.black,
                              fontSize: FontConstant.Size18,
                              fontWeight: FontWeight.w500,

                          ),
                        ),
                  
                    ]
                ),
                SizedBox(height: 10,),
                Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.brown,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Half Day',
                        style:  TextStyle(
                              color: Colors.black,
                              fontSize: FontConstant.Size18,
                              fontWeight: FontWeight.w500,


                        ),
                      ),
                    ]
                ),
                SizedBox(height: 10,),
                Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Absent',
                        style:  TextStyle(
                              color: Colors.black,
                              fontSize: FontConstant.Size18,
                              fontWeight: FontWeight.w500,


                        ),
                      ),
                    ]
                ),
                SizedBox(height: 10,),
                Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Not Checked Out',
                        style:  TextStyle(
                              color: Colors.black,
                              fontSize: FontConstant.Size18,
                              fontWeight: FontWeight.w500,


                        ),
                      ),
                    ]
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    ) ??
        false;
  }


  @override
  Widget build(BuildContext context){
    DateTime? parsedDate;

    if (firstKey != null) {
      parsedDate = DateTime.parse(firstKey!);
    }

    if (parsedDate != null) {
       formattedDayOfWeek = DateFormat('EEEE').format(parsedDate);
      print(formattedDayOfWeek); // prints the day of the week (e.g., Tuesday)
    } else {
      print('Error: Unable to parse the date');
    }

    // Weekdays in the same order as DateTime constants
    List<String> weekdays = [ 'Sunday','Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

    // Calculate the starting index based on the day of the week
     startingIndex = weekdays.indexOf(formattedDayOfWeek!);

    return Scaffold(
      backgroundColor: ColorConstant.edit_bg_color,
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
                    child: Text("Attendance History",
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
                Container(
                  child: IconButton(
                    onPressed: () {
                      InfoDialogue();
                    },
                    icon: const Icon(
                      Icons.info_outline,
                      size: 30,
                      color: Colors.white,
                    ),
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
      body: SafeArea(
        child:Expanded(
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child:Container(
                  child: Row(
                    children: [
                      SizedBox(height: 10,
                        width: 10,),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: ColorConstant.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Center(
                              child:Text(
                                "${presentDays}",
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Present",
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Days",
                                maxLines: 2,
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: ColorConstant.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Center(
                              child:Text(
                                "${absentDays}",
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Absent",
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Days",
                                maxLines: 2,
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: ColorConstant.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 12)),
                            Center(
                              child:Text(
                                "${holidays}",
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Holidays",
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.black
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width: 90,
                        height: 80,
                        decoration: BoxDecoration(
                          color: ColorConstant.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 12)),
                            Center(
                              child:Text(
                                "${latePenalties}",
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Penalities",
                                style:  TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30,10,30,0),
                child:Container(
                  child: Row(
                    children: [
                    GestureDetector(
                        onTap: setPreviousMonth,
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                     Spacer(),
                     Text(
                       DateFormat('MMMM yyyy').format(month),
                        style:  TextStyle(
                              fontSize: FontConstant.Size18,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,

                            color: Colors.black
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap:setNextMonth,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                child: Container(
                  child: Row(
                    children: [
                      // Add the day labels
                      for (var day in ['S', 'M', 'T', 'W', 'T', 'F', 'S'])
                        Expanded(
                          child: Text(
                            day,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: FontConstant.Size18,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,

                              color: Colors.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 0.8,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  height: 280,
                  color: Colors.white,
                  child: GridView.builder(
                    itemCount: dateArrayList.length + startingIndex,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 1,
                      childAspectRatio: (255 / 250),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index < startingIndex) {
                        // Add empty spaces before the start of the month
                        return SizedBox.shrink();
                      } else {
                        final adjustedIndex = index - startingIndex;
                        final dateKeys = dateArrayList[adjustedIndex].keys.toList();
                        final dateColors = dateArrayList[adjustedIndex].values.toList();
                        final datePenalities = penalityArrayList[adjustedIndex].values.toList();
                        final Penalitykeys = penalityArrayList[adjustedIndex].keys.toList();

                        String? date;
                        String? dateColor;
                        String? penalitykeys;
                        int? datePenality;

                        if (dateKeys.isNotEmpty) {
                          date = dateKeys[0];
                        }
                        if (dateColors.isNotEmpty) {
                          dateColor = dateColors[0];
                        }
                        if (Penalitykeys.isNotEmpty) {
                          penalitykeys = Penalitykeys[0];
                        }
                        if (datePenalities.isNotEmpty) {
                          datePenality = datePenalities[0];
                        }

                        // Get the current date
                        DateTime currentDate = DateTime.now();

                        return InkWell(
                          onTap: () {
                            if (penalitykeys != null) {
                              dateWiseAttendance(penalitykeys);
                              print("Selected date: $penalitykeys");
                            }
                            setState(() {
                              SelectedDate=dateKeys[0]!;
                              print("SelectedDate: $SelectedDate");
                              print("ParsedDate: ${int.parse(date!)}");
                            });
                          },
                          child: Card(
                            elevation: 0,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: dateColor == 'g' ? Colors.green :
                                        dateColor == 'r' ? Colors.red :
                                        dateColor == 'b' ? Colors.blue :
                                        dateColor == 'br' ? Colors.brown :
                                        dateColor == 'y' ? Colors.yellow :
                                        Colors.transparent,
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      (datePenality != 0) ? "(${datePenality.toString()})" : "",
                                      style:  TextStyle(
                                          fontSize: FontConstant.Size10,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,

                                      ),
                                    ),
                                  ],
                                ),
                      // Conditional rendering to highlight selected and current dates
                      Center(
                      child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Container(
                      decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SelectedDate != null && SelectedDate == int.parse(date!) ? Colors.blue :
                      currentDate.day == int.parse(date!) ? Colors.black : Colors.transparent,
                      ),
                      child: Center(
                      child: Text(
                      date ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: SelectedDate != null && SelectedDate == int.parse(date!) ? Colors.white :
                      currentDate.day == int.parse(date!) ? Colors.white : Colors.black,
                      ),
                      ),
                      ))))

                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),


                  // child:GridView.builder(
                    //   itemCount: dateArrayList.length + startingIndex,
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 7,
                    //     crossAxisSpacing: 2,
                    //     mainAxisSpacing: 1,
                    //     childAspectRatio: (255 / 250),
                    //   ),
                    //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    //   shrinkWrap: true,
                    //   itemBuilder: (context, index) {
                    //     if (index < startingIndex) {
                    //       // Add empty spaces before the start of the month
                    //       return SizedBox.shrink();
                    //     } else {
                    //       final adjustedIndex = index - startingIndex;
                    //       final dateKeys = dateArrayList[adjustedIndex].keys.toList();
                    //       final dateColors = dateArrayList[adjustedIndex].values.toList();
                    //
                    //       final datePenalities = penalityArrayList[adjustedIndex].values.toList();
                    //       final Penalitykeys = penalityArrayList[adjustedIndex].keys.toList();
                    //
                    //       String? date;
                    //       String? dateColor;
                    //       String? penalitykeys;
                    //       int? datePenality;
                    //
                    //       if (dateKeys.isNotEmpty) {
                    //         date = dateKeys[0];
                    //       }
                    //       if (dateColors.isNotEmpty) {
                    //         dateColor = dateColors[0];
                    //       }
                    //       if (Penalitykeys.isNotEmpty) {
                    //         penalitykeys = Penalitykeys[0];
                    //       }
                    //
                    //       if (datePenalities.isNotEmpty) {
                    //         datePenality = datePenalities[0];
                    //       }
                    //       DateTime currentDate = DateTime.now();
                    //       return InkWell(
                    //         onTap: () {
                    //           if (penalitykeys != null) {
                    //             dateWiseAttendance(penalitykeys);
                    //             print("Selected date: $penalitykeys");
                    //           }
                    //         },
                    //         child: Card(
                    //           elevation: 0,
                    //           shadowColor: Colors.black,
                    //           child: Column(
                    //             children: [
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children:[
                    //                   Text(
                    //                     (datePenality != 0) ? "(${datePenality.toString()})" : "",
                    //                     style: GoogleFonts.ubuntu(
                    //                       textStyle: TextStyle(
                    //                         fontSize: FontConstant.Size10,
                    //                         fontWeight: FontWeight.w400,
                    //                         overflow: TextOverflow.ellipsis,
                    //                       ),
                    //                       color: Colors.black,
                    //                     ),
                    //                   ),
                    //               SizedBox(width: 3,),
                    //               Container(
                    //                 width:8,
                    //                 height:8,
                    //                 decoration: BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   color: dateColor == 'g' ? Colors.green :
                    //                   dateColor == 'r' ? Colors.red :
                    //                   dateColor == 'b' ? Colors.blue :
                    //                   dateColor == 'br' ? Colors.brown :
                    //                   dateColor == 'y' ? Colors.yellow :
                    //                   Colors.transparent, // Default color
                    //                 ),
                    //               ),
                    //              ],
                    //               ),
                    //               Center(
                    //                 child: Text(
                    //                   date ?? "",
                    //                   style: TextStyle(
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.w400,
                    //                     color: Colors.black,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),

                ),
              ),

              Text(
                "Attendance Details",
                style:  TextStyle(
                      fontSize: FontConstant.Size18,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,

                    color: ColorConstant.erp_appColor
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child:Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                          child: Container(
                            // Content for the first area
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  "Check In Time",
                                  style:  TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w300,
                                        overflow: TextOverflow.ellipsis,

                                      color: ColorConstant.grey_153
                                  ),
                                ),

                                Text(
                                  "${intime}",
                                  style:  TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,

                                      color: ColorConstant.erp_appColor
                                  ),
                                ),
                                SizedBox(height: 10,),

                                Text(
                                  "Check In Location",
                                  style:  TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w300,
                                        overflow: TextOverflow.ellipsis,

                                      color: ColorConstant.grey_153
                                  ),
                                ),

                                Text(
                                  "${inlocation}",
                                  style:  TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,

                                      color: ColorConstant.erp_appColor
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "Late Penalities",
                                  style:  TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w300,
                                        overflow: TextOverflow.ellipsis,

                                      color: ColorConstant.grey_153
                                  ),
                                ),

                                Text(
                                  "${penalties}",
                                  style:  TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,

                                      color: ColorConstant.erp_appColor
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                      SizedBox(width: 5), // Add some space between the two areas
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                          child: Container(
                            // Content for the second area
                            alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    "Check Out Time",
                                    style:  TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300,
                                          overflow: TextOverflow.ellipsis,

                                        color: ColorConstant.grey_153
                                    ),
                                  ),

                                  Text(
                                    "${outtime}",
                                    style:  TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        color: ColorConstant.erp_appColor
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "Check Out Location",
                                    style:  TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300,
                                          overflow: TextOverflow.ellipsis,

                                        color: ColorConstant.grey_153
                                    ),
                                  ),

                                  Text(
                                    "${outlocation}",
                                    style:  TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,

                                        color: ColorConstant.erp_appColor
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "Date",
                                    style:  TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300,
                                          overflow: TextOverflow.ellipsis,
                                        color: ColorConstant.grey_153
                                    ),
                                  ),

                                  Text(
                                    "${date}",
                                    style:  TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        color: ColorConstant.erp_appColor
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),




            ],
          )

        ) ,
      )
    );
  }
}

//
// GridView.builder(
// itemCount: 30,
// gridDelegate:
// SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 7,
// crossAxisSpacing: 2,
// mainAxisSpacing: 25,
// childAspectRatio:
// (255 / 120)),
// padding: const EdgeInsets.fromLTRB(20,20,10,0),
// //  physics: const BouncingScrollPhysics(),
// shrinkWrap: true,
// itemBuilder: (context, index) {
// return Container(
// child: Card(
// elevation: 0,
// shadowColor: Colors.black,
// child:Text(
// "1",
// style: GoogleFonts.ubuntu(
// textStyle: TextStyle(
// fontSize: FontConstant.Size15,
// fontWeight: FontWeight.w400,
// overflow: TextOverflow.ellipsis,
// ),
// color: ColorConstant.black,
// ),
// ),
// ));
// return null;
// }),