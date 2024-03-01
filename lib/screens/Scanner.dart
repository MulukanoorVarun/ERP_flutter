import 'dart:developer';
import 'dart:io';

import 'package:GenERP/Utils/ColorConstant.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey scannerKey = GlobalKey(debugLabel: 'QR');
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
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // result = scanData;
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
              onQRViewCreated: _onQRViewCreated,
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