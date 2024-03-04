import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 

import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';

class GenTracker extends StatefulWidget{
  const GenTracker({Key?key}): super(key:key);

  @override
  State<GenTracker> createState() => _GenTrackerState();
}

class _GenTrackerState extends State<GenTracker>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
          title: Text(
            "Gen Tracker",
            textAlign: TextAlign.center,
            style:  TextStyle(
                  color: ColorConstant.white,
                  fontSize: FontConstant.Size20,
                  fontWeight: FontWeight.w500),

          ),
          backgroundColor: ColorConstant.erp_appColor),
      body: Container(
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
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child:
                  Row(
                    children: [
                      Icon(Icons.search),
                      Text("Generator Details",textAlign: TextAlign.center,
                        style:
                         TextStyle(
                                color: ColorConstant.black,
                                fontSize: FontConstant.Size20,
                                fontWeight: FontWeight.w500)),
                      ],
                  ),

                ),
                SizedBox(height: 10.0,),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child:
                  Row(
                    children: [
                      Icon(Icons.search),
                      Text("Generator Details")
                    ],
                  ),

                ),
                SizedBox(height: 10.0,),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child:
                  Row(
                    children: [
                      Icon(Icons.search),
                      Text("Generator Details")
                    ],
                  ),

                ),
                SizedBox(height: 10.0,),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child:
                  Row(
                    children: [
                      Icon(Icons.search),
                      Text("Generator Details")
                    ],
                  ),

                ),

              ],
            ),

          ),
        ),
      ),
    );
  }
}