import 'package:connectivity_plus/connectivity_plus.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// getheader() async {
//
//
//   final access_token = await PreferenceService().getString("access_token");
//   final refresh_token =await PreferenceService().getString("refresh_token");
//   print("hi${refresh_token}");
//
//
//   Map<String, String> b= {
//     "refresh_token":refresh_token!,
//
//     "access_token": "Bearer ${access_token}",
//     "client-id":"0b8486cff241e8fa7053c6cb795d28eb1af584b0"!
//   };
//   return b;
// }

//
// HeaderValues() async {
//   Map<String, String> ValueArray = {
//     "client-id":"37662aa448b2ac44dcf400df14f965f4b8852cb3"
//   };
//   final accessToken = await PreferenceService().getString("access_token");
//   if(accessToken!="" && accessToken!=null)
//     {
//       ValueArray['Authorization']="Bearer $accessToken";
//     }
//   return ValueArray;
// }
getheader() async {
  // CartCountFun();
  final Ssessionid = await PreferenceService().getString("token");
  // print("Akash ${Ssessionid} Mohan");
  // var pincode = await PreferenceService().getString('PostCode');
  // if (pincode == null) {
  //   pincode = "500038";
  // }
  // print("Akash ${pincode} Mohan");
  // Map<String, String> a = {authorization: Ssessionid!, "postcode": pincode!};
  // return a;
}
//
//
// CheckHeaderValidity() async{
//   String timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10);
//   OtpVerifyModal response = OtpVerifyModal();
//   final token = await PreferenceService().getString("refresh_token");
//   final validityTimestamp = await PreferenceService().getString("access_expiry_timestamp");
//   var status=true;
//   if(int.parse(validityTimestamp!)<=int.parse(timestamp))
//     {
//       await UserApi.UpdateRefreshToken(token).then((data) =>
//       {
//         if (data != null)
//           {
//             response=data,
//             print(response.error.toString()),
//             PreferenceService().saveString("access_token", response.accessToken!),
//             PreferenceService().saveString("access_expiry_timestamp", response.accessExpiryTimestamp!),
//             status=true,
//             // if(response!.error=="1"){
//             //         return true,
//             //       }else{
//             //     return false,
//             //   }
//
//           }else{
//           status=false
//         }
//       });
//     }else{
//     status=true;
//   }
//   return status;
// }
//
toast(text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
//
// toast(context,text) {
//
//   // OwnToast(context, text, "0");
//   Fluttertoast.showToast(
//       msg: text,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: ColorConstant.DarkOrange,
//       textColor: Colors.white,
//       fontSize: 16.0
//   );
// }
//
Future<bool> CheckNetwork() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    print("onnetwork");
    return true;
    // setLoader(true);
    // if (!mounted) return;
    // splashApiService(context, sessionId)
    //     .then((data) => {
    //   if (data != null)
    //     {
    //       if (data.error == 0)
    //         {
    //           _preferenceService.saveString(
    //               "walletAvailable", data.userWalletAvailable),
    //           _preferenceService.saveInt(
    //               "isAuctionAvailable", data.isAuctionsAvailable),
    //           Navigator.push(
    //               context,
    //               SlideRightRoute(
    //                   page: const Dashboard(
    //                     pageNum: 0,
    //                   ))),
    //         }
    //       else
    //         {showToast(data.message)},
    //       setState(() {}),
    //     },
    //   setLoader(false),
    // })
    //     .timeout(const Duration(seconds: connectionTimeOut), onTimeout: () {
    //   setLoader(false);
    //   throw TimeoutException(timeOutError);
    // }).catchError((err) {
    //   setLoader(false);
    //   showToast(err.toString());
    // });
  } else {
    print("networkgone");
    return false;
    // setConnectivityStatus(false);
  }
}
//
// createdynamic_link(type,id,productName) async {
//   String Link = "https://nutsby.com/product_details/$id/$productName";
//   return Link;
//
// }

