import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:GenERP/screens/GenTracker/TagGenerator.dart';
import 'package:GenERP/screens/GenTracker/TagLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';

class PaymentCollectionScreen extends StatefulWidget {
  const PaymentCollectionScreen({Key? key}) : super(key: key);

  @override
  State<PaymentCollectionScreen> createState() => _PaymentCollectionScreenState();
}

class _PaymentCollectionScreenState extends State<PaymentCollectionScreen> {

  bool isLoading = false;

  @override
  void initState() {
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
                      child: Text("Payment Details",
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
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: GridView.builder(
                        itemCount: 3,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (MediaQuery.of(context).size.width < 600)
                                ? 1  // 2 items in a row for mobile
                                : 4, // 4 items in a row for tablet
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 2,
                            childAspectRatio:
                            (255 / 120)),
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
                                child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      Padding(padding:const EdgeInsets.all(8.0),),

                                      Row(
                                        children: [
                                          SizedBox(width: 10,),
                                          Text(
                                            "Date ",
                                            style:  TextStyle(
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorConstant.black,
                                            ),
                                          ),
                                          Text(
                                            "Date ",
                                            style:  TextStyle(
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorConstant.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontSize: FontConstant.Size15,
                                                    fontWeight: FontWeight.w400,
                                                    overflow: TextOverflow.ellipsis,
                                                    color: ColorConstant.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10,),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontSize: FontConstant.Size15,
                                                    fontWeight: FontWeight.w400,
                                                    overflow: TextOverflow.ellipsis,
                                                    color: ColorConstant.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),

                                      Row(
                                        children: [
                                          SizedBox(width: 10,),
                                          Text(
                                            "view Proof ",
                                            style:  TextStyle(
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorConstant.black,
                                            ),
                                          ),
                                          Text(
                                            "Date ",
                                            style:  TextStyle(
                                              fontSize: FontConstant.Size15,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorConstant.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),


                                // CategoryProductCard(context,UpdateFavoriteFunction,AddToCartFunction,mak,productlist[index])
                              ));
                          return null;
                        }),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}