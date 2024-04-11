import 'package:GenERP/screens/GenTechnicianModule/PaymentDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../../Utils/storage.dart';
import '../../models/AccountSuggestionResponse.dart';
import '../Login.dart';

class AccountSuggestion extends StatefulWidget {
  const AccountSuggestion({Key? key}) : super(key: key);

  @override
  State<AccountSuggestion> createState() => _AccountSuggestionState();
}

class _AccountSuggestionState extends State<AccountSuggestion> {
  var empId = "";
  var session = "";
  var searched_string = "";
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  List<AccountList>? accountList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> AccountSuggestionAPI() async {
    empId = await PreferenceService().getString("UserId") ?? "";
    session = await PreferenceService().getString("Session_id") ?? "";
    try {
      UserApi.AccountSuggestionAPI(empId, session, _searchController.text)
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.sessionExists == 1) {
                        if (data.error == 0) {
                          isLoading = false;
                          accountList = data.accountList!;
                          // if(accountList!.length.toDouble() <= double.parse(accountList!.last.toString())){
                          isLoading = false;
                          // }
                        } else {
                          isLoading = false;
                          accountList = [];
                        }
                      } else {
                        PreferenceService().clearPreferences();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      }
                    })
                  }
                else
                  {isLoading = false}
              });
    } on Error catch (e) {
      print(e.toString());
    }
  }

  Future<void> _refresh() async {
    // Simulate a delay to mimic fetching new data from an API
    await Future.delayed(const Duration(seconds: 2));
    // Generate new data or update existing data
    if (searched_string.length >= 3) {
      print("searched_string:${searched_string}");
      setState(() {
        isLoading = true;
        AccountSuggestionAPI();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
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
                child: Text("Search Accounts",
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
              size: 30.0,
            ),
          ),
        ),
      ),
      body: (isLoading)
          ? Loaders()
          : RefreshIndicator(
              onRefresh: _refresh,
              color: ColorConstant.erp_appColor,
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 55,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        controller: _searchController,
                        cursorColor: ColorConstant.black,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            searched_string = value;
                          });
                          if (value.length >= 3) {
                            AccountSuggestionAPI();
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Account Name.....",
                          hintStyle: TextStyle(
                              fontSize: FontConstant.Size15,
                              color: ColorConstant.Textfield,
                              fontWeight: FontWeight.w400),
                          filled: true,
                          fillColor: ColorConstant.edit_bg_color,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                width: 0, color: ColorConstant.edit_bg_color),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                width: 0, color: ColorConstant.edit_bg_color),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 25.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Note: Enter Minimum 3 Characters",
                        style: TextStyle(
                          color: ColorConstant.grey_153,
                          fontSize: FontConstant.Size12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      child: Divider(
                        color: ColorConstant.edit_bg_color,
                        thickness: 5,
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        child: GridView.builder(
                            itemCount: accountList!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        1, // 4 items in a row for tablet
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 2,
                                    childAspectRatio: (100 / 25)),
                            padding: const EdgeInsets.all(5),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (accountList!.length > 0) {
                                return InkWell(
                                  onTap: () {
                                    // if(actname == "pendingComplaints"&&status=="Open"){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentDetails(
                                            account_name: "Account",
                                            name:
                                                accountList![index].accountName,
                                            genId: "",
                                            refId:
                                                accountList![index].accountId,
                                          ),
                                        ));
                                    // }
                                  },
                                  child: SizedBox(
                                    child: Container(
                                      width: screenWidth * 0.9,
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Text(
                                        "${accountList![index].accountName}",
                                        textAlign: TextAlign.start,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: FontConstant.Size15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Expanded(
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
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Container(
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "No Data Available",
                                              style: TextStyle(
                                                fontSize: FontConstant.Size18,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color:
                                                    ColorConstant.erp_appColor,
                                              ),
                                            )),
                                      )),
                                ));
                              }
                            }),
                      ),
                    ))
                  ],
                ),
              ),
            ),
    );
  }
}
