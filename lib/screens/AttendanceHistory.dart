import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';

class AttendanceHistory extends StatefulWidget{
  const AttendanceHistory({Key?key}): super(key:key);

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context){

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
      body: Container(

      )
    );
  }
}