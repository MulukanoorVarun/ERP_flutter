
import 'package:GenERP/Utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Helpers.dart';
class getToken{
  DateTime? dbDate;
  String? Authorization, refreshToken;

  BuildContext? get context => null;
  // final provider = Provider<String>((ref) {
  //   return 'Hello world';
  // });
  Future<String?> getData() async {
    return await PreferenceService().getString("refresh_token");
  }

  Future<String?> getDataa() async {
    return await PreferenceService().getString("access_token");
  }

  Future<int?> getDataaa() async {
    return await PreferenceService().getInt("token_expiry_time");
  }

  // getaddToken(){
  //   getDataaa().then((value) => {
  //     dbDate =
  //         DateTime.fromMillisecondsSinceEpoch(value! * 1000),
  //     debugPrint(
  //         "compare: ${dbDate?.compareTo(DateTime.now())}"),
  //     if (dbDate?.compareTo(DateTime.now()) == 1)
  //       {
  //         //dbDate is greater than the current datetime
  //         getscreen(Authorization ?? "", refreshToken),
  //
  //       }
  //     else
  //       {
  //         //dbDate is lesser or eqUAL TO the current datetime(0, -1 will get here)
  //
  //         RToken(refreshToken.toString())
  //             .then((value) => {
  //           if (value != null)
  //             {
  //               PreferenceService().saveTokens(value),
  //               // PreferenceService().saveString(
  //               //     "access_token", value.accessToken),
  //               // PreferenceService().saveString(
  //               //     "refresh_token",
  //               //     value.refreshToken),
  //               // PreferenceService().saveInt(
  //               //     "token_expiry_time",
  //               //     value.accessExpiryTimestamp),
  //               setState(() {
  //                 Authorization = value.accessToken;
  //                 refreshToken = value.refreshToken;
  //
  //               }),
  //               getscreen(value.accessToken,
  //                   value.refreshToken),
  //             }
  //         })
  //             .catchError((err) {
  //           if (err == 403) {}
  //         }),
  //       }
  //   });
  // }
  //
  // getscreen(String Authorization, String? refreshToken) {
  //   debugPrint('dsdfsd');
  //   home(Authorization, refreshToken.toString()).then((value) => {
  //     debugPrint(
  //         "${value.error}.... ${value.message}..${value.accesstoken}"),
  //     if (value != null)
  //       {
  //         debugPrint('data'),
  //         if (value.error == 0)
  //           {
  //             debugPrint('channel1'),
  //             debugPrint("${value.error}.... ${value.message}"),
  //             getDataa().then((value) => {
  //               debugPrint("access_token: $value"),
  //             }),
  //             Helpers().showSnackBar( context!, value.message),
  //             debugPrint('channel'),
  //             Navigator.push(context!,
  //                 MaterialPageRoute(builder: (context)=>product_list())
  //             ),
  //           }
  //         else
  //           {},
  //         debugPrint("${value.error}.... ${value.message}")
  //       }
  //   }).catchError((err){
  //     if(err == 403){
  //       RToken(refreshToken.toString())
  //           .then((value) => {
  //         if (value != null)
  //           {
  //             PreferenceService().saveTokens(value),
  //             // PreferenceService().saveString(
  //             //     "access_token", value.accessToken),
  //             // PreferenceService().saveString(
  //             //     "refresh_token",
  //             //     value.refreshToken),
  //             // PreferenceService().saveInt(
  //             //     "token_expiry_time",
  //             //     value.accessExpiryTimestamp),
  //             setState(() {
  //               Authorization = value.accessToken;
  //               refreshToken = value.refreshToken;
  //             }),
  //             getscreen(value.accessToken,
  //                 value.refreshToken),
  //           }
  //       })
  //           .catchError((err) {
  //         if (err == 403) {
  //           PreferenceService().clearPreferences();
  //           Navigator.pushReplacement(context!, MaterialPageRoute(builder: (c) => const Login()));
  //         }
  //       });
  //     }
  //   });
  // }

  setState(Null Function() param0) {

  }
}

