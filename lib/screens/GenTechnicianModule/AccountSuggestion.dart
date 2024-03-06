import 'package:GenERP/screens/GenTechnicianModule/PaymentDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/storage.dart';
import '../../models/AccountSuggestionResponse.dart';
import '../Login.dart';

class AccountSuggestion extends StatefulWidget{
  const AccountSuggestion({Key?key}): super(key:key);

  @override
  State<AccountSuggestion> createState() => _AccountSuggestionState();
}

class _AccountSuggestionState extends State<AccountSuggestion>{
  var empId = "";
  var session =  "";
  var searched_string = "";
  final TextEditingController _searchController = TextEditingController();
  List<AccountList>? accountList = [];

  @override
  void initState(){
    super.initState();
  }


  Future<void> AccountSuggestionAPI() async {
    empId= await PreferenceService().getString("UserId")??"";
    session= await PreferenceService().getString("Session_id")??"";
    try {
      UserApi.AccountSuggestionAPI(
          empId, session,_searchController.text).then((data) =>
      {
        if(data != null){
          setState(() {
            if (data.sessionExists == 1) {
              if (data.error == 0) {
                accountList = data.accountList!;

              } else {
                accountList = [];
              }
            } else {
              PreferenceService().clearPreferences();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }
          })
        }
      });
    } on Error catch (e) {
      print(e.toString());
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
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child:
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              height: 55,
              margin:EdgeInsets.only(left:15.0,right:15.0),
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
              margin: EdgeInsets.only(top:5.0,left: 25.0),
              alignment: Alignment.topLeft,
              child: Text("Note: Enter Minimum 3 Characters",style: TextStyle(
                color: ColorConstant.grey_153,
                fontSize: FontConstant.Size12,
                fontWeight: FontWeight.w300,
              ),),
            ),
            Container(
              child: Divider(
                color: ColorConstant.edit_bg_color,thickness: 5,
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: GridView.builder(
                        itemCount: accountList!.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                            1, // 4 items in a row for tablet
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 2,
                            childAspectRatio: (100 / 10)),
                        padding: const EdgeInsets.all(5),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {

                          if(accountList!.length>0){
                            return InkWell(
                                onTap: () {
                                  // if(actname == "pendingComplaints"&&status=="Open"){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      PaymentDetails(
                                      account_name: "Account",
                                      name:"",
                                      genId: "",
                                      refId: accountList![index].accountId,
                                    ),
                                    ));
                                  // }
                                },
                                child:Container(
                                  width: screenWidth*0.6,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "${accountList![index].accountName}",
                                            textAlign:
                                            TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: ColorConstant
                                                    .black,
                                                fontSize: FontConstant
                                                    .Size15,
                                                fontWeight:
                                                FontWeight.w300),
                                          ),
                                        ),


                                      ],
                                    ))
                            );
                          }else{
                            return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "No Data Available",
                                  style: TextStyle(
                                    fontSize: FontConstant.Size18,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    color: ColorConstant.erp_appColor,
                                  ),
                                ));
                          }


                        }),
                  ),
                ))
          ],
        ),
      ),
    );
  }

}