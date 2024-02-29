import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';
import '../Utils/storage.dart';
import '../models/AttendanceHistoryresponse.dart';
import 'CalenderWidget.dart';

class AttendanceHistory extends StatefulWidget{
  const AttendanceHistory({Key?key}): super(key:key);

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory>{
  late DateTime month;
  late int monthNo;
  DateTime selectedMonth = DateTime.utc(2024, 2);

  int presentDays=0;
  int absentDays=0;
  int holidays=0;
  int latePenalties=0;
  List<DateArray> dateArray=[];
  List<LatePenaltyArray> latePenaltyArray=[];

  @override
  void initState() {
    month = DateTime.now();
    getMonth(DateFormat('MMMM').format(month));
    super.initState();
  }

  void setPreviousMonth() {
    setState(() {
    month = DateTime(month.year, month.month - 1);
    });
  }

// Function to set the next month
  void setNextMonth() {
    setState(() {
    month = DateTime(month.year, month.month + 1);
    });
  }

  List<String> generateDates(int month, int year) {
    List<String> dates = [];
    int daysInMonth = DateTime(year, month + 1, 0).day;
    for (int day = 1; day <= daysInMonth; day++) {
      dates.add(day.toString());
    }
    return dates;
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

  Future<void> loadAttendanceDetails() async {
    try {
      await UserApi.LoadAttendanceDetails(empId,sessionId,monthNo,year).then((data) => {
        if (data != null)
          {
            setState(() {
              if (data.error == 0) {
                presentDays=data.presentDays!;
                absentDays=data.absentDays!;
                holidays=data.holidays!;
                latePenalties=data.latePenalties!;
                dateArray=data.dateArray!;
                latePenaltyArray=data.latePenaltyArray!;
              }
            })
          }
        else
          {
            print("Something went wrong, Please try again.")}
      });

    } on Exception catch (e) {
      print("$e");
    }
  }
  @override
  Widget build(BuildContext context){
 //   List<String> dates = generateDates(month.month, month.year); // Example: February 2024
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
                        style: GoogleFonts.ubuntu(
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
                    onPressed: () {},
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
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Present",
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Days",
                                maxLines: 2,
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Absent",
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Days",
                                maxLines: 2,
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Holidays",
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    color: Colors.black
                                ),
                              ),
                            ),
                            Center(
                              child:Text(
                                "Penalities",
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      fontSize: FontConstant.Size15,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                        style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: FontConstant.Size18,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                fontSize: FontConstant.Size18,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              ),
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
                   child:GridView.builder(
                     itemCount: dateArray.length,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 7,
                       crossAxisSpacing: 2,
                       mainAxisSpacing: 25,
                       childAspectRatio: (255 / 140),
                     ),
                     padding: const EdgeInsets.fromLTRB(10, 10, 10, 0), // Adjusted padding for Sunday
                     shrinkWrap: true,
                     itemBuilder: (context, index) {
                       final date = dateArray[index];
                       if (dateArray.length!=0) {
                         return InkWell(
                           onTap: () {
                            // dateListener(DateTime.utc(2024, 2, int.parse(date)));
                           },
                           child: Card(
                             elevation: 0,
                             shadowColor: Colors.black,
                             child: Center(
                               child: Text(
                                 "${dateArray[index]}",
                                 style: TextStyle(
                                   fontSize: 15,
                                   fontWeight: FontWeight.w400,
                                   color: Colors.black,
                                 ),
                               ),
                             ),
                           ),
                         );
                       } else {
                         return Card(
                           elevation: 0,
                           shadowColor: Colors.transparent,
                         );
                       }
                     },
                   )
                  // CalendarAdapter(
                  //   selectedMonth:month, // Pass selected month to CalendarAdapter
                  //   dateListener: (selectedDate) {
                  //     // Handle selected date
                  //     print('Selected date: $selectedDate');
                  //     print('Selected month: $month');
                  //   },
                  // ),
                ),
              ),

              Text(
                "Attendance Details",
                style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      fontSize: FontConstant.Size18,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                                  style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w300,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: ColorConstant.grey_153
                                  ),
                                ),

                                Text(
                                  "-",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: ColorConstant.erp_appColor
                                  ),
                                ),
                                SizedBox(height: 10,),

                                Text(
                                  "Check In Location",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w300,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: ColorConstant.grey_153
                                  ),
                                ),

                                Text(
                                  "Head office (Biometric)",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: ColorConstant.erp_appColor
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "Late Penalities",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w300,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: ColorConstant.grey_153
                                  ),
                                ),

                                Text(
                                  "0",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        color: ColorConstant.grey_153
                                    ),
                                  ),

                                  Text(
                                    "-",
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        color: ColorConstant.erp_appColor
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "Check Out Location",
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        color: ColorConstant.grey_153
                                    ),
                                  ),

                                  Text(
                                    "Head office (Biometric)",
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        color: ColorConstant.erp_appColor
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "Date",
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        color: ColorConstant.grey_153
                                    ),
                                  ),

                                  Text(
                                    "29 Feb 24",
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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