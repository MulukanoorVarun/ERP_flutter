import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:GenERP/screens/GenTracker/TagGenerator.dart';
import 'package:GenERP/screens/GenTracker/TagLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../../models/NearbyGeneratorsResponse.dart';

class FollowUpList extends StatefulWidget {
  const FollowUpList({Key? key}) : super(key: key);

  @override
  State<FollowUpList> createState() => _FollowUpListState();
}

class _FollowUpListState extends State<FollowUpList> {

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  String? empId;
  String? sessionId;
  String? complaintId;
  Future<void> LoadFollowupListAPI() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    print(empId);
    print(sessionId);
    try {
      await UserApi.loadFollowupListAPI(empId,sessionId,complaintId).then((data) => {
        if (data != null)
          {
            setState(() {
              if (data.error == 0) {
                isLoading = false;
              } else {

              }
            })
          } else {
          toast(context,"Something went wrong, Please try again.")
        }
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
                      child: Text("Follow Up Details",
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
                            (255 / 140)),
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