import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.erp_appColor,
        appBar: AppBar(
        backgroundColor: Colors.orange,
        // leading:SizedBox(width: 0,),
        automaticallyImplyLeading: false,
        ),

    );
  }
}