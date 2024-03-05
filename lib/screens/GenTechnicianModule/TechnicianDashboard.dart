import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTechnicianModule/MonthlyVisits.dart';
import 'package:GenERP/screens/GenTechnicianModule/NearbyGenerators.dart';
import 'package:GenERP/screens/GenTechnicianModule/PaymentCollectionScreen.dart';
import 'package:GenERP/screens/GenTechnicianModule/PendingComplaints.dart';
import 'package:GenERP/screens/GenTechnicianModule/TodayVisits.dart';
import 'package:GenERP/screens/GenTechnicianModule/WalletScreen.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:GenERP/screens/GenTracker/TagGenerator.dart';
import 'package:GenERP/screens/GenTracker/TagLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';

class GenTechnicianDashboard extends StatefulWidget {
  const GenTechnicianDashboard({Key? key}) : super(key: key);

  @override
  State<GenTechnicianDashboard> createState() => _GenTechnicianDashboardState();
}

class _GenTechnicianDashboardState extends State<GenTechnicianDashboard> {

  bool isLoading = true;

  @override
  void initState() {
    loadTechnicianDashboard();
    super.initState();
  }

  String? empId;
  String? sessionId;
  int? avgRating;
  int? pendingComplaints;
  int? todayVisits;
  int? thisMonthsVisits;
  String? paymentCollectionWalletBalanceAmount;
  String? monthlyPaymentCollectionAmount;

  Future<void> loadTechnicianDashboard() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    try {
      print(empId);
      print(sessionId);
      await UserApi.loadTechnicianDashboardApi(empId,sessionId).then((data) => {
        if (data != null)
          {
            setState(() {
              if(data.error==0){
                avgRating=data.avgRating!;
                pendingComplaints=data.pendingComplaints!;
                pendingComplaints=data.pendingComplaints!;
                todayVisits=data.todayVisits!;
                thisMonthsVisits=data.thisMonthsVisits!;
                paymentCollectionWalletBalanceAmount=data.paymentCollectionWalletBalanceAmount!;
                monthlyPaymentCollectionAmount=data.monthlyPaymentCollectionAmount!;
                isLoading = false;
              }else{

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
                  child:
                  Container(
                    width: double.infinity, // Set width to fill parent width
                    decoration: BoxDecoration(
                      color: ColorConstant.edit_bg_color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child:
                    Column( // Use Row to split into two columns
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                       Row(
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
                                                 avgRating.toString() ?? "",
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
                                     await Navigator.push(context, MaterialPageRoute(builder: (context) => TodayVisitsScreen()));
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
                                                 todayVisits.toString() ?? "",
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
                                     await Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentCollectionScreen()));
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
                                           "assets/ic_payments.svg",
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
                                                 "₹${monthlyPaymentCollectionAmount}" ?? "",
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
                                               pendingComplaints.toString() ?? "",
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
                                     await Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyVisitsScreen()));
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
                                                 thisMonthsVisits.toString() ?? "",
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
                                     await Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
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
                                           "assets/ic_payments.svg",
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
                                                 "₹${paymentCollectionWalletBalanceAmount}" ?? "",
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
                        SizedBox(height: 25,),
                        Container(
                          height: 80,
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => NearbyGenerators()));
                            },
                            child:
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  SvgPicture.asset(
                                    "assets/ic_nearby.svg",
                                    height: 50,
                                    width: 50,
                                  ),
                                  SizedBox(width: 20,),
                                  Spacer(),
                                  Container(
                                    child:Text(
                                          "Nearby Generators",
                                          style: TextStyle(
                                            fontSize: FontConstant.Size15,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            color: ColorConstant.erp_appColor,
                                          ),
                                        ),
                                  ),
                                  Spacer(),
                                  SizedBox(width: 20,)
                                ],
                              ),
                            ),
                          ),
                        )
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