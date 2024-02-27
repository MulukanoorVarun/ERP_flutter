// //
// //
// // import 'package:nutsby/Repositories/repository.dart';
// // import 'package:flutter/material.dart';
// // import '../Repositories/refresh_token_repository.dart';
// // import '../Screens/login.dart';
// // import '../Utils/Helpers.dart';
// // import '../Utils/storage.dart';
// //
// // Future<String?> getData() async {
// //   return await PreferenceService().getString("refresh_token");
// // }
// //
// // Future<String?> getDataa() async {
// //   return await PreferenceService().getString("access_token");
// // }
// //
// // Future<int?> getDataaa() async {
// //   return await PreferenceService().getInt("token_expiry_time");
// // }
// //
// //  var reqparams = Map();
// // DateTime? dbDate;
// //
// //
// // class getAccessTokenn extends StatefulWidget {
// //   const getAccessTokenn({Key? key}) : super(key: key);
// //
// //   @override
// //   State<getAccessTokenn> createState() => _getAccessTokennState();
// // }
// //
// // class _getAccessTokennState extends State<getAccessTokenn> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return getRefreshToken("","");
// //   }
// //
// //   getRefreshToken(String Authorization, String? refreshToken) {
// //     reqparams = {
// //     };
// //
// //     debugPrint('dsdfsd');
// //     serverPostRequest(reqparams, refreshToken.toString(), true).then((value) =>
// //     {
// //       debugPrint(
// //           "${value.error}.... ${value.message}..${value.accesstoken}"),
// //       if (value != null)
// //         {
// //           debugPrint('data'),
// //           if (value.error == 0)
// //             {
// //               debugPrint('channel1'),
// //               debugPrint("${value.error}.... ${value.message}"),
// //               getDataa().then((value) =>
// //               {
// //                 debugPrint("access_token: $value"),
// //               }),
// //               Helpers().showSnackBar(context, value.message),
// //               debugPrint('channel'),
// //             }
// //           else
// //             {},
// //           debugPrint("${value.error}.... ${value.message}")
// //         }
// //     }).catchError((err) {
// //       if (err == 403) {
// //         RToken(refreshToken.toString())
// //             .then((value) =>
// //         {
// //           if (value != null)
// //             {
// //               PreferenceService().saveTokens(value),
// //               // PreferenceService().saveString(
// //               //     "access_token", value.accessToken),
// //               // PreferenceService().saveString(
// //               //     "refresh_token",
// //               //     value.refreshToken),
// //               // PreferenceService().saveInt(
// //               //     "token_expiry_time",
// //               //     value.accessExpiryTimestamp),
// //               setState(() {
// //                 Authorization = value.accessToken;
// //                 refreshToken = value.refreshToken;
// //               }),
// //               getRefreshToken(value.accessToken,
// //                   value.refreshToken),
// //             }
// //         })
// //             .catchError((err) {
// //           if (err == 403) {
// //             PreferenceService().clearPreferences();
// //             Navigator.pushReplacement(
// //                 context, MaterialPageRoute(builder: (c) => const Login()));
// //           }
// //         });
// //       }
// //     });
// //     getDataaa().then((value) => {
// //       dbDate =
// //           DateTime.fromMillisecondsSinceEpoch(value! * 1000),
// //       debugPrint(
// //           "compare: ${dbDate?.compareTo(DateTime.now())}"),
// //       if (dbDate?.compareTo(DateTime.now()) == 1)
// //         {
// //           //dbDate is greater than the current datetime
// //           getRefreshToken(Authorization ?? "", refreshToken),
// //
// //         }
// //       else
// //         {
// //           //dbDate is lesser or eqUAL TO the current datetime(0, -1 will get here)
// //
// //           RToken(refreshToken.toString())
// //               .then((value) => {
// //             if (value != null)
// //               {
// //                 PreferenceService().saveTokens(value),
// //                 // PreferenceService().saveString(
// //                 //     "access_token", value.accessToken),
// //                 // PreferenceService().saveString(
// //                 //     "refresh_token",
// //                 //     value.refreshToken),
// //                 // PreferenceService().saveInt(
// //                 //     "token_expiry_time",
// //                 //     value.accessExpiryTimestamp),
// //                 setState(() {
// //                   Authorization = value.accessToken;
// //                   refreshToken = value.refreshToken;
// //
// //                 }),
// //                 getRefreshToken(value.accessToken,
// //                     value.refreshToken),
// //               }
// //           })
// //               .catchError((err) {
// //             if (err == 403) {}
// //           }),
// //         }
// //     });
// //   }
// // }
// //
// //
// //
//
//
// import 'package:flutter/material.dart';
// import 'package:nutsby/Repositories/repository.dart';
// import 'package:nutsby/Screens/login.dart';
// import 'package:nutsby/Screens/product_list.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Repositories/dashboard.repository.dart';
// import '../Repositories/refresh_token_repository.dart';
// import '../Utils/Helpers.dart';
// import '../Utils/storage.dart';
//
// class MainScreenn extends StatefulWidget {
//   const MainScreenn({Key? key}) : super(key: key);
//
//   @override
//   State<MainScreenn> createState() => _MainScreennState();
// }
//
// class _MainScreennState extends State<MainScreenn> {
//   TextEditingController controller =TextEditingController();
//   String? Authorization, refreshToken;
//   DateTime? dbDate;
//   var requestParameter = Map();
//   @override
//   void initState() {
//     super.initState();
//     getData().then((value) => {
//       setState(() {
//         refreshToken = value;
//       }),
//       debugPrint("refresh_token: $value"),
//     });
//     getDataa().then((value) => {
//       debugPrint("access_token: $value"),
//       setState(() {
//         Authorization = value;
//       }),
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextButton(
//               onPressed: () {
//                 getDataaa().then((value) => {
//                   dbDate =
//                       DateTime.fromMillisecondsSinceEpoch(value! * 1000),
//                   debugPrint(
//                       "compare: ${dbDate?.compareTo(DateTime.now())}"),
//                   if (dbDate?.compareTo(DateTime.now()) == 1)
//                     {
//                       //dbDate is greater than the current datetime
//                       getAccessToken(refreshToken),
//                     }
//                   else
//                     {
//                       //dbDate is lesser or eqUAL TO the current datetime(0, -1 will get here)
//
//                       RToken(refreshToken.toString())
//                           .then((value) => {
//                         if (value != null)
//                           {
//                             debugPrint('adf${refreshToken}'),
//                             PreferenceService().saveTokens(value),
//                             // PreferenceService().saveString(
//                             //     "access_token", value.accessToken),
//                             // PreferenceService().saveString(
//                             //     "refresh_token",
//                             //     value.refreshToken),
//                             // PreferenceService().saveInt(
//                             //     "token_expiry_time",
//                             //     value.accessExpiryTimestamp),
//                             setState(() {
//                               Authorization = value.accessToken;
//                               refreshToken = value.refreshToken;
//
//                             }),
//                             getAccessToken(
//                                 value.refreshToken),
//                           }
//                       })
//                           .catchError((err) {
//                         if (err == 403) {}
//                       }),
//                     }
//                 });
//               },
//               child: Text('next'))
//         ],
//       ),
//     );
//   }
//
//   Future<String?> getData() async {
//     return await PreferenceService().getString("refresh_token");
//   }
//
//   Future<String?> getDataa() async {
//     return await PreferenceService().getString("access_token");
//   }
//
//   Future<int?> getDataaa() async {
//     return await PreferenceService().getInt("token_expiry_time");
//   }
//
//   getAccessToken(String? refreshToken) {
//     requestParameter = {
//
//     };
//
//     debugPrint('dsdfsd');
//     serverPostRequest(requestParameter, refreshToken.toString(), true).then((value) => {
//       debugPrint(
//           "${value.error}.... ${value.message}..${value.accesstoken}"),
//       if (value != null)
//         {
//           debugPrint('data'),
//           if (value.error == 0)
//             {
//               debugPrint('channel1'),
//               debugPrint("${value.error}.... ${value.message}"),
//               getDataa().then((value) => {
//                 debugPrint("access_token: $value"),
//               }),
//               Helpers().showSnackBar(context, value.message),
//               debugPrint('channel'),
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context)=>product_list())
//               ),
//             }
//           else
//             {},
//           debugPrint("${value.error}.... ${value.message}")
//         }
//     }).catchError((err){
//       if(err == 403){
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
//               }),
//               getAccessToken(value.accessToken,
//               ),
//             }
//         })
//             .catchError((err) {
//           if (err == 403) {
//             PreferenceService().clearPreferences();
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const Login()));
//           }
//         });
//       }
//     });
//   }
// }
//
