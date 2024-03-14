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
import '../../models/FollowUpResponse.dart';
import '../../models/NearbyGeneratorsResponse.dart';

class FollowUpList extends StatefulWidget {
  final complaintId;

  const FollowUpList({Key? key, required this.complaintId}) : super(key: key);

  @override
  State<FollowUpList> createState() => _FollowUpListState();
}

class _FollowUpListState extends State<FollowUpList> {
  bool isLoading = true;

  @override
  void initState() {
    LoadFollowupListAPI();
    super.initState();
  }

  String? empId;
  String? sessionId;
  List<Followuplist> followuplist = [];

  Future<void> LoadFollowupListAPI() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    print(empId);
    print(sessionId);
    print("complaintId:${widget.complaintId}");
    try {
      await UserApi.loadFollowupListAPI(empId, sessionId, widget.complaintId)
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.error == 0) {
                        followuplist = data.list!;
                        isLoading = false;
                      } else {
                        isLoading = false;
                      }
                    })
                  }
                else
                  {toast(context, "Something went wrong, Please try again.")}
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
      LoadFollowupListAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      color: ColorConstant.erp_appColor,
      child: Scaffold(
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
                  CupertinoIcons.back,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
            ),
          ),
          body: (isLoading)
              ? Loaders()
              : SafeArea(
                  child: Container(
                    color: ColorConstant.erp_appColor,
                    child: Column(
                      children: [
                        if (followuplist.length > 0) ...[
                          SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: double.infinity,
                                      height: MediaQuery.of(context)
                                              .size
                                              .height -
                                          56, // Set width to fill parent width
                                      decoration: BoxDecoration(
                                        color: ColorConstant.edit_bg_color,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: GridView.builder(
                                          itemCount: followuplist.length,
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
                                                  childAspectRatio:
                                                      (255 / 145)),
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
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            followuplist[index]
                                                                    .ename ??
                                                                "",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  FontConstant
                                                                      .Size15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color:
                                                                  ColorConstant
                                                                      .black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "Feedback",
                                                              style: TextStyle(
                                                                fontSize:
                                                                    FontConstant
                                                                        .Size15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: ColorConstant
                                                                    .medium_grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    10, 0),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "Type",
                                                              style: TextStyle(
                                                                fontSize:
                                                                    FontConstant
                                                                        .Size15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: ColorConstant
                                                                    .medium_grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              followuplist[
                                                                          index]
                                                                      .feedback ??
                                                                  "",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    FontConstant
                                                                        .Size15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color:
                                                                    ColorConstant
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    10, 0),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              followuplist[
                                                                          index]
                                                                      .type ??
                                                                  "",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    FontConstant
                                                                        .Size15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color:
                                                                    ColorConstant
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "Date",
                                                              style: TextStyle(
                                                                fontSize:
                                                                    FontConstant
                                                                        .Size15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: ColorConstant
                                                                    .medium_grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    10, 0),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "Time",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    FontConstant
                                                                        .Size15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: ColorConstant
                                                                    .medium_grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              followuplist[
                                                                          index]
                                                                      .date ??
                                                                  "",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    FontConstant
                                                                        .Size15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color:
                                                                    ColorConstant
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    10, 0),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              // "argfyyyyyyyyweriufgywey",
                                                              followuplist[
                                                                          index]
                                                                      .time ??
                                                                  "",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    FontConstant
                                                                        .Size15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color:
                                                                    ColorConstant
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ]),

                                              // CategoryProductCard(context,UpdateFavoriteFunction,AddToCartFunction,mak,productlist[index])
                                            ));
                                            return null;
                                          }),
                                    ),
                                  ),
                                ],
                              ))
                        ] else ...[
                          Expanded(
                              child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
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
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Container(
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
                                )),
                          ))
                        ]
                      ],
                    ),
                  ),
                )),
    );
  }
}
