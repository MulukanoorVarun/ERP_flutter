import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';
import '../Utils/storage.dart';
import '../screens/splash.dart';


class LogoutDialogue extends StatefulWidget {
  // final String? prod_id;
  const LogoutDialogue({super.key});

  @override
  State<LogoutDialogue> createState() => _LogoutDialogueDialogueState();
}

class _LogoutDialogueDialogueState extends State<LogoutDialogue> {
  var username = "";
  var email = "";
  var loginStatus = 0;
  var curdate = "";
  var empId = "";
  var session = "";
  final Color _buttonColor = const Color(0x00BF634D);

  @override
  void initState() {

    super.initState();
  }
  Future<void> LogoutApiFunction() async {
    try{
      loginStatus = await PreferenceService().getInt("loginStatus") ?? 0;
      empId = await PreferenceService().getString("UserId") ?? "";
      username = await PreferenceService().getString("UserName") ?? "";
      email = await PreferenceService().getString("UserEmail") ?? "";
      session = await PreferenceService().getString("Session_id") ?? "";
      await UserApi.LogoutFunctionApi(empId??"",session??"").then((data) => {
        if (data != null)
          {
            setState(() {
              if (data.error == 0) {
                PreferenceService().clearPreferences();
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Splash()));
              } else {
                print(data.toString());
              }
            })
          }
        else
          {print("Something went wrong, Please try again.")}
      });
    }on Exception catch (e) {
      print("$e");
    }
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor:   ColorConstant.Fillcolor,
      title: Text('Notify on Product Avaiable',style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
              fontSize: FontConstant.Size15,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
          color: Colors.black)),
      content:SizedBox(
        height: 200,
        width: size.width,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 0.5,color: Colors.grey,),
            const SizedBox(height: 5,),
            Container(
              child: Text("We are thrilled to let you know when the product is available. Stay tuned for the good news! Have a good day :)",
                  style: TextStyle(fontSize: FontConstant.Size15,color: Colors.grey),maxLines: 4,textAlign: TextAlign.justify),
            ),
            const SizedBox(height: 5,),
            const Divider(thickness: 0.5,color: Colors.grey,),
            const SizedBox(height: 5,),
            Container(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () async {
                  setState(() {

                  });
                  // var res= await showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return RequestSubmittedDialogue();
                  //   },
                  // );
                  // if(res){
                  //   isLoading = true;
                  // }else{
                  //   toast(context, "it's false");
                  // }


                },
                child:
                Container(
                  width: 145,
                  height: 35,
                  // padding:,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          5),
                      color: Colors
                          .orange),
                  child: const Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    children: [
                      Text(
                        "Click Here!",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            )


          ],
        ),

      ),


    );
  }
}

