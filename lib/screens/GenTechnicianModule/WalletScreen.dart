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
  bool isLoading = true;

  @override
  void initState() {
    LoadTransactionsListAPI();
    super.initState();
  }

  String? empId;
  String? sessionId;
  List<HistoryList> historyList = [];
  TotalDet? totalDet;
  //TotalDet totalDet;
  Future<void> LoadTransactionsListAPI() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    try {
      print(empId);
      print(sessionId);
      await UserApi.loadTransactionsListAPI(empId, sessionId).then((data) => {
            if (data != null)
              {
                setState(() {
                  if (data.error == 0) {
                    historyList = data.historyList!;
                    totalDet = data.totalDet!;
                    isLoading = false;
                  } else {
                    isLoading = false;
                  }
                })
              }
            else
              {print("Something went wrong, Please try again.")}
          });
    } on Exception catch (e) {
      print("$e");
    }
  }

  Future<void> _refresh() async {
    // Simulate a delay to mimic fetching new data from an API
    await Future.delayed(const Duration(seconds: 2));
    // Generate new data or update existing data
    setState(() {
      isLoading = true;
      LoadTransactionsListAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      color: ColorConstant.erp_appColor,
      child: Scaffold(
          body: (isLoading)
              ? Loaders()
              : Container(
                  color: ColorConstant.erp_appColor,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          color: ColorConstant.erp_appColor,
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 40, 20, 10)),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context, true);
                                },
                                child: SvgPicture.asset(
                                  "assets/back_icon.svg",
                                  height: 29,
                                  width: 29,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "Wallet",
                                style: TextStyle(
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
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 20, 10)),
                              Text(
                                "Balance",
                                style: TextStyle(
                                  fontSize: FontConstant.Size22,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  color: ColorConstant.white,
                                ),
                              ),
                              Text(
                                totalDet?.balanceAmount ?? "",
                                style: TextStyle(
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
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 20)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/ic_credit.svg",
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 0, 20, 20)),
                                      Text(
                                        "Credited",
                                        style: TextStyle(
                                          fontSize: FontConstant.Size22,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                          color: ColorConstant.white,
                                        ),
                                      ),
                                      Text(
                                        totalDet?.creditAmount ?? "",
                                        style: TextStyle(
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 0, 20, 20)),
                                      Text(
                                        "Debited",
                                        style: TextStyle(
                                          fontSize: FontConstant.Size22,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                          color: ColorConstant.white,
                                        ),
                                      ),
                                      Text(
                                        totalDet?.creditAmount ?? "",
                                        style: TextStyle(
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
                              SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (historyList.length > 0) ...[
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context)
                                  .size
                                  .height, // Set width to fill parent width
                              decoration: BoxDecoration(
                                color: ColorConstant.edit_bg_color,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(0, 20, 5, 20),
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Container(
                                  child: Column(
                                    // Set max height constraints
                                    children: [
                                      GridView.builder(
                                          itemCount: historyList.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: (MediaQuery
                                                                  .of(context)
                                                              .size
                                                              .width <
                                                          600)
                                                      ? 1 // 2 items in a row for mobile
                                                      : 4, // 4 items in a row for tablet
                                                  crossAxisSpacing: 4,
                                                  mainAxisSpacing: 2,
                                                  childAspectRatio: (255 / 60)),
                                          padding: const EdgeInsets.all(5),
                                          physics:
                                              const BouncingScrollPhysics(),
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
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(children: [
                                                Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 200,
                                                      child: Text(
                                                        historyList[index]
                                                                .description ??
                                                            "",
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: ColorConstant
                                                              .black,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      historyList[index]
                                                              .datetime ??
                                                          "",
                                                      style: TextStyle(
                                                        fontSize:
                                                            FontConstant.Size15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color:
                                                            ColorConstant.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                if (historyList[index]
                                                        .transactionType ==
                                                    "Credit") ...[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "+ ₹ ${historyList[index].amount}" ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: ColorConstant
                                                              .Couponamount,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ] else ...[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "- ₹ ${historyList[index].amount}" ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: FontConstant
                                                              .Size15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: ColorConstant
                                                              .absent_color,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
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
                            ),
                          ),
                        ] else ...[
                          Expanded(
                            child: Container(
                                width: double
                                    .infinity, // Set width to fill parent width
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: ColorConstant.edit_bg_color,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "No Data Available",
                                            style: TextStyle(
                                              fontSize: FontConstant.Size18,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorConstant.erp_appColor,
                                            ),
                                          )),
                                    ))),
                          )
                        ]
                      ],
                    ),
                  ))),
    );
  }
}
