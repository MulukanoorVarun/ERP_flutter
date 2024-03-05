import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:GenERP/screens/GenTracker/TagGenerator.dart';
import 'package:GenERP/screens/GenTracker/TagLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';


import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../../models/PaymentCollectionWalletResponse.dart';
import '../../models/TodayVisitResponse.dart';
import '../Profile.dart';
import '../Scanner.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  bool isLoading = false;

  @override
  void initState() {
    LoadTransactionsListAPI();
    super.initState();
  }

  String? empId;
  String? sessionId;
  List<HistoryList> historyList=[];
  //TotalDet totalDet;
  Future<void> LoadTransactionsListAPI() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    try {
      print(empId);
      print(sessionId);
      await UserApi.loadTransactionsListAPI("752","bb1bd615748920990e679a575b0684cf3f53367620dd775a47e4a771bde22f313f4d7722ce131d65427ce054053aed8eb0ca").then((data) => {
        if (data != null)
          {
            setState(() {
              if(data.error==0){
                historyList=data.historyList!;
                //totalDet=data.totalDet!;
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
            body:(isLoading)?Loaders():
            SafeArea(
                child: Container(
                  color:ColorConstant.erp_appColor,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        color: ColorConstant.erp_appColor,
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(0,40,20,10)),
                            SvgPicture.asset(
                              "assets/back_icon.svg",
                              height: 24,
                              width: 24,
                            ),
                          SizedBox(width: 30,),
                            Text(
                              "Wallet",
                              style:  TextStyle(
                                fontSize: FontConstant.Size22,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: ColorConstant.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.topCenter,
                        color: ColorConstant.erp_appColor,
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(10,0,20,10)),
                            Text(
                              "Balance",
                              style:  TextStyle(
                                fontSize: FontConstant.Size22,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: ColorConstant.white,
                              ),
                            ),
                            Text(
                              "12345",
                              style:  TextStyle(
                                fontSize: FontConstant.Size22,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: ColorConstant.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.topCenter,
                        color: ColorConstant.erp_appColor,
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(0,0,20,20)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/ic_credit.svg",
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(padding: EdgeInsets.fromLTRB(0,0,20,20)),
                                    Text(
                                      "Credited",
                                      style:  TextStyle(
                                        fontSize: FontConstant.Size22,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        color: ColorConstant.white,
                                      ),
                                    ),
                                    Text(
                                      "12345",
                                      style:  TextStyle(
                                        fontSize: FontConstant.Size22,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        color: ColorConstant.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/ic_debit.svg",
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(padding: EdgeInsets.fromLTRB(0,0,20,20)),
                                    Text(
                                      "Debited",
                                      style:  TextStyle(
                                        fontSize: FontConstant.Size22,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        color: ColorConstant.white,
                                      ),
                                    ),
                                    Text(
                                      "12345",
                                      style:  TextStyle(
                                        fontSize: FontConstant.Size22,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        color: ColorConstant.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 30,)
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),


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
                          padding: EdgeInsets.fromLTRB(0, 20, 5, 20),
                          child: Column(// Set max height constraints
                            children: [
                              GridView.builder(
                                  itemCount: 3,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: (MediaQuery.of(context).size.width < 600)
                                          ? 1  // 2 items in a row for mobile
                                          : 4, // 4 items in a row for tablet
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 2,
                                      childAspectRatio:
                                      (255 / 60)),
                                  padding: const EdgeInsets.all(5),
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        child: Card(
                                          elevation: 0,
                                          shadowColor: Colors.white,
                                          margin: const EdgeInsets.fromLTRB(
                                              3.0, 0.0, 0.0, 5.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                          ),
                                          child: Row(
                                              children: [
                                                Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [

                                                    Text(
                                                      "Money taken from the customer",
                                                      style:  TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: ColorConstant.black,
                                                      ),
                                                    ),

                                                    Text(
                                                      "30 Aug 2023",
                                                      style: TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: ColorConstant.black,
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                Spacer(),

                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "fgdfg",
                                                      style:  TextStyle(
                                                        fontSize: FontConstant.Size15,
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: ColorConstant.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),


                                              ]),


                                          // CategoryProductCard(context,UpdateFavoriteFunction,AddToCartFunction,mak,productlist[index])
                                        ));
                                    return null;
                                  }),
                              ],
                          ),

                        ),
                      ),
                    ],
                  ),
                )
            ));

  }
}