import 'package:GenERP/screens/Login.dart';
import 'package:flutter/material.dart';
 

import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/Constants.dart';
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
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
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
      title: Align(
          alignment: Alignment.topLeft,
          child:Text('Confirm Log Out',style:  TextStyle(
                color: Colors.black,
                fontSize: FontConstant.Size22,
                fontWeight: FontWeight.w200

          ),)
      ),
      content: Container(
          width:400,
          height: 75,
          alignment: Alignment.center,
          child:Text('$username you are signing out from  $appName app on this device ',
            maxLines:4,style:  TextStyle(
                  color: Colors.black,
                  fontSize: FontConstant.Size18,
                  fontWeight: FontWeight.w100


            ),)

      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Colors.white70),
          ),
          onPressed: () {
            print("pressed");
            LogoutApiFunction();
          },
          child: Text(
            "LOG OUT",
            style: TextStyle(
                color: ColorConstant.black,
                fontWeight: FontWeight.w100,
                fontSize: FontConstant.Size15,

            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            "CANCEL",
            style:  TextStyle(
                color: ColorConstant.black,
                fontWeight: FontWeight.w100,
                fontSize: FontConstant.Size15,
            ),
          ),
        ),
      ],

    );
  }
}

