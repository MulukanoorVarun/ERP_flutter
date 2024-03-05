import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTechnicianModule/PendingComplaints.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:GenERP/screens/GenTracker/TagGenerator.dart';
import 'package:GenERP/screens/GenTracker/TagLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';

class GenTechnicianDashboard extends StatefulWidget {
  const GenTechnicianDashboard({Key? key}) : super(key: key);

  @override
  State<GenTechnicianDashboard> createState() => _GenTechnicianDashboardState();
}

class _GenTechnicianDashboardState extends State<GenTechnicianDashboard> {

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Text("Service Engineer",
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
        body: (isLoading) ? Loaders() :
        SafeArea(
          child: Container(
            color: ColorConstant.erp_appColor,
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
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Row( // Use Row to split into two columns
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column( // First column
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanner(title: "Generator Details")));
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      SvgPicture.asset(
                                        "assets/ic_rating.svg",
                                        height: 50,
                                        width: 50,
                                      ),
                                     Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                                        mainAxisAlignment: MainAxisAlignment.center, // Center column vertically
                                        children: [
                                          Center(
                                          child:Text(
                                            "6.0",
                                            style: TextStyle(
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorConstant.erp_appColor,
                                            ),
                                          ),
                                          ),
                                          Center(
                                            child:Text(
                                            "rating",
                                            style: TextStyle(
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorConstant.erp_appColor,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 20,)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanner(title: "Generator Details")));
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      SvgPicture.asset(
                                        "assets/ic_today_visits.svg",
                                        height: 50,
                                        width: 50,
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                                        mainAxisAlignment: MainAxisAlignment.center, // Center column vertically
                                        children: [
                                          Center(
                                            child:Text(
                                              "0",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child:Text(
                                              "Today Visits",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10,)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanner(title: "Generator Details")));
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      SvgPicture.asset(
                                        "assets/ic_rating.svg",
                                        height: 50,
                                        width: 50,
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                                        mainAxisAlignment: MainAxisAlignment.center, // Center column vertically
                                        children: [
                                          Center(
                                            child:Text(
                                              "00.0",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child:Text(
                                              "Month",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child:Text(
                                              "Collection",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10,)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between columns
                        Expanded(
                          child: Column( // Second column
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => PendingComplaints()));
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      SvgPicture.asset(
                                        "assets/ic_pending.svg",
                                        height: 50,
                                        width: 50,
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                                        mainAxisAlignment: MainAxisAlignment.center, // Center column vertically
                                        children: [
                                        Text(
                                              "0",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),

                                            Text(
                                              "Pending",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          Text(
                                            "Complaints",
                                            style: TextStyle(
                                              fontSize: FontConstant.Size13,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorConstant.erp_appColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10,)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanner(title: "Generator Details")));
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      SvgPicture.asset(
                                        "assets/ic_month_visits.svg",
                                        height: 50,
                                        width: 50,
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                                        mainAxisAlignment: MainAxisAlignment.center, // Center column vertically
                                        children: [
                                          Center(
                                            child:Text(
                                              "0",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child:Text(
                                              "Month Visits",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10,)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanner(title: "Generator Details")));
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      SvgPicture.asset(
                                        "assets/ic_rating.svg",
                                        height: 50,
                                        width: 50,
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                                        mainAxisAlignment: MainAxisAlignment.center, // Center column vertically
                                        children: [
                                          Center(
                                            child:Text(
                                              "31000.56",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child:Text(
                                              "P.C Wallet",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size13,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant.erp_appColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10,)
                                    ],
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

              ],
            ),
          ),
        )
    );
  }
}