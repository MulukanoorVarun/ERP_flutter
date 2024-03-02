import 'dart:developer';
import 'dart:io';

import 'package:GenERP/Utils/ColorConstant.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../Services/other_services.dart';
import '../Services/user_api.dart';
import '../Utils/storage.dart';
import 'dart:convert';


class Scanner extends StatefulWidget {
  final from;
  const Scanner({Key? key,required this.from}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey scannerKey = GlobalKey(debugLabel: 'QR');
  var empId="";
  var session="";
  QRViewController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    }
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
  void _onQRViewCreated(QRViewController controller) {
    setState(() {

    });
    controller.scannedDataStream.listen((scanData)  {
      var a  =  scanData;
      setState(() {
        // result = scanData;

        print(a.toString());
        print("littu");
      });
    });
  }
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print(scanData.code);
        print("a");
        print(scanData.format);
        print("b");
        print(scanData.rawBytes);
        if(widget.from == "dashboard"){
          var decodedata = jsonDecode(scanData.code!);
          var token = decodedata['data']['token'];
          print(token);
          var type = decodedata['type'];
          LoadQRAPIFunction(token,type);
        }
        if(widget.from =="generatorDetails"){

        }
        if(widget.from =="registerComplaint"){

        }
        if(widget.from =="tagGenerator"){

        }
        if(widget.from =="tagLocation"){

        }

      });
    });
  }


  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<void> LoadQRAPIFunction(type,token) async{
    session= await PreferenceService().getString("Session_id")??"";
    empId= await PreferenceService().getString("UserId")??"";
    try{
      await UserApi.QRLoginRequestAPI(empId, session,type,token).then((data)=>{
        if(data!=null){
          setState((){
            if(data.sessionExists==1){
              if(data.error==0){
                toast(context,data.message);

              }else if(data.error==1){
                toast(context, data.message);
              }else if(data.error==2){
                toast(context, data.message);
              }
              else{
                toast(context, "Something Went wrong, Please Try Again!");
              }
            }else{
              toast(context, "Your session has expired, please login again!");
            }

          })
        }else{

        }
      });

    } on Error catch(e){
      print(e.toString());
    }
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(

          child: QRView(
              onQRViewCreated: onQRViewCreated,
            key: scannerKey,

            cameraFacing: CameraFacing.back,

            overlay: QrScannerOverlayShape(
                borderColor: ColorConstant.erp_appColor,
                borderRadius: 0,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
            ),

        ),
      );
  }
  }