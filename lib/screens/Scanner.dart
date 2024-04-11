import 'dart:developer';
import 'dart:io';

import 'package:GenERP/Utils/ColorConstant.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/GenInventory/PartDetails.dart';
import 'package:GenERP/screens/GenTracker/ComplaintHistory.dart';
import 'package:GenERP/screens/GenTracker/QRScanner.dart';
import 'package:GenERP/screens/GenTracker/TagGenerator.dart';
import 'package:GenERP/screens/GenTracker/TagLocation.dart';
import 'package:GenERP/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Location;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import '../Services/other_services.dart';
import '../Services/user_api.dart';
import '../Utils/FontConstant.dart';
import '../Utils/storage.dart';
import 'dart:convert';

import 'GenTracker/GeneratoraDetails.dart';
import 'GenTracker/RegisterComplaint.dart';

class Scanner extends StatefulWidget {
  final from;
  const Scanner({Key? key, required this.from}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey scannerKey = GlobalKey(debugLabel: 'QR');
  var empId = "";
  var session = "";
  Location.Location currentLocation1 = Location.Location();
  Location.LocationData? currentLocation;
  var latlongs = "";
  Set<Marker> markers = {};
  List<String> addresses = [];
  bool isLocationEnabled = false;
  bool hasLocationPermission = false;
  String googleApikey = "AIzaSyAA2ukvrb1kWQZ2dttsNIMynLJqVCYYrhw";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(17.439112226708446, 78.43292499146135);
  String locationdd = "Search Location";
  bool isLoading = true;
  TextEditingController Generator_id = TextEditingController();
  var _error_genID = "";
  QRViewController? controller;
  var _error_engNo = "";
  TextEditingController Engine_no = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocationPermission();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Future<void> _getLocationPermission() async {
    // Check if location services are enabled
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();

// Check if the app has been granted location permission
    LocationPermission permission = await Geolocator.checkPermission();
    hasLocationPermission = permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;

    final Location.Location location = Location.Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    isLoading = false;
    permissionGranted = (await location.hasPermission());
    if (permissionGranted == PermissionStatus) {
      permissionGranted = (await location.requestPermission());
      if (permissionGranted != PermissionStatus) {
        return;
      }
    }
    final Location.LocationData locData = await location.getLocation();

    setState(() {
      currentLocation = locData;
    });

    if (currentLocation != null) {
      mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        )),
      );

      markers.add(Marker(
        markerId: MarkerId('current_location'),
        position:
            LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        infoWindow: InfoWindow(title: 'Current Location'),
        icon: BitmapDescriptor.defaultMarker,
      ));

      setState(() {
        final lat = currentLocation!.latitude;
        final lang = currentLocation!.longitude!;
        latlongs = '$lat,$lang';
        //Storelocatorfunction(latlongs);
      });
    }
  }

  void onQRViewCreated(QRViewController controller) {
    print("QRVIEW");
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (widget.from == "dashboard") {
          Map<String, dynamic> obj = jsonDecode(scanData.code!);
          if (obj["type"] == "login") {
            print("type:" + obj["type"]);
            print("token:" + (obj["data"]["token"]));
            controller!.pauseCamera();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
            LoadQRAPIFunction(obj["type"], (obj["data"]["token"]));
          }
        } else if (widget.from == "generatorDetails") {
          Navigator.pop(context, true);
          PreferenceService().saveString("result", scanData.code!);
          controller!.pauseCamera();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GeneratorDetails(
                  actName: "",
                  location: "",
                  generatorId: scanData.code,
                ),
              ));

          // LoadgeneratorDetailsApifunction(scanData.code!);
        } else if (widget.from == "registerComplaint") {
          Navigator.pop(context);
          PreferenceService().saveString("result", scanData.code!);
          controller!.pauseCamera();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RegisterComplaint(generator_id: scanData.code)));
          // LoadgeneratorDetailsApifunction(scanData.code!);
        } else if (widget.from == "tagGenerator") {
          Navigator.pop(context, true);
          PreferenceService().saveString("result", scanData.code!);
          PreferenceService().saveString("from", "scanner");
          controller!.pauseCamera();
          TagGeneratorDialogue(scanData.code!);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => TagGenerator()));
        } else if (widget.from == "tagLocation") {
          PreferenceService().saveString("result", scanData.code!);
          print("result:${scanData.code!}");
          print("latlongs:${latlongs}");
          controller!.pauseCamera();
          TagLocationAPIFunction(scanData.code!, latlongs);
          // Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(
          //     builder: (context) =>
          //         TagLocation()));
        } else if (widget.from == "inventory") {
          Navigator.pop(context);
          PreferenceService().saveString("result", scanData.code!);
          controller!.pauseCamera();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PartDetailsScreen(part_id: scanData.code)));
        } else if (widget.from == "pendingComplaints") {
          Navigator.pop(context);
          PreferenceService().saveString("result", scanData.code!);
          controller!.pauseCamera();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ComplaintDetails(
                        gen_id: scanData.code!,
                        act_name: widget.from,
                      )));
        }
      });
    });
  }

  Future TagGeneratorDialogue(id) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 20,
            shadowColor: Colors.black,
            title: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "#" + id,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: FontConstant.Size22,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                )),
            content: Container(
              height: 125,
              child: Column(children: [
                Container(
                  alignment: Alignment.center,
                  width: 450,
                  height: 50,
                  margin: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    controller: Engine_no,
                    cursorColor: ColorConstant.black,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Enter Engine Number",
                      hintStyle: TextStyle(
                          fontSize: FontConstant.Size15,
                          color: ColorConstant.Textfield,
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: ColorConstant.edit_bg_color,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 0, color: ColorConstant.edit_bg_color),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 0, color: ColorConstant.edit_bg_color),
                      ),
                    ),
                  ),
                ),
                if (_error_engNo != null) ...[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 25),
                    child: Text(
                      "$_error_engNo",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: FontConstant.Size10,
                      ),
                    ),
                  )
                ] else ...[
                  SizedBox(
                    height: 15,
                  ),
                ],
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 45,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        color: ColorConstant.erp_appColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              ColorConstant.erp_appColor),
                          overlayColor: MaterialStateProperty.all(
                              ColorConstant.erp_appColor),
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: ColorConstant.white,
                            fontWeight: FontWeight.w300,
                            fontSize: FontConstant.Size15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 45,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        color: ColorConstant.erp_appColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              ColorConstant.erp_appColor),
                          overlayColor: MaterialStateProperty.all(
                              ColorConstant.erp_appColor),
                        ),
                        onPressed: () => {
                          Navigator.pop(context, true),
                          setState(() {
                            TagGeneratorAPIFunction(id, Engine_no.text);
                          }),
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: ColorConstant.white,
                            fontWeight: FontWeight.w300,
                            fontSize: FontConstant.Size15,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
          barrierDismissible: false,
        ) ??
        false;
  }

  Future<void> TagGeneratorAPIFunction(Generator_id, Engine_no) async {
    session = await PreferenceService().getString("Session_id") ?? "";
    empId = await PreferenceService().getString("UserId") ?? "";

    try {
      await UserApi.TagGeneratorAPI(empId, session, Generator_id, Engine_no)
          .then((data) => {
                if (data != null)
                  {
                    print("tagg"),
                    // Navigator.pop(context, true),
                    setState(() {
                      if (data.sessionExists == 1) {
                        if (data.error == 0) {
                          toast(context, "Generator Tagged Successfully!");
                        } else if (data.error == 1) {
                          toast(context,
                              "The Generator may already have been Linked or The Engine Number is Incorrect!");
                        } else if (data.error == 2) {
                          toast(context,
                              "This QR Code is already registered with another generator");
                        } else {
                          toast(context,
                              "Something Went wrong, Please Try Again!");
                        }
                      } else {
                        toast(context,
                            "Your session has expired, please login again!");
                      }
                    })
                  }
                else
                  {
                    toast(context,
                        "No response from server, Please try again later!")
                  }
              });
    } on Error catch (e) {
      print(e.toString());
    }
  }

  Future<void> TagLocationAPIFunction(Generator_id, latlongs) async {
    session = await PreferenceService().getString("Session_id") ?? "";
    empId = await PreferenceService().getString("UserId") ?? "";
    try {
      await UserApi.TagLocationAPI(empId, session, Generator_id, latlongs)
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.sessionExists == 1) {
                        if (data.error == 0) {
                          toast(context, "Location Tagged Successfully!!");
                          Navigator.pop(context, true);
                        } else if (data.error == 1) {
                          toast(context, "Enter Valid Generator Id");
                        } else {
                          toast(context,
                              "Something Went wrong, Please Try Again!");
                        }
                      } else {
                        PreferenceService().clearPreferences();
                        toast(context,
                            "Your session has expired, please login again");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Splash()));
                      }
                    })
                  }
                else
                  {
                    toast(context,
                        "No Response from server, Please try again later!")
                  }
              });
    } on Error catch (e) {
      print(e.toString());
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<void> LoadQRAPIFunction(type, token) async {
    session = await PreferenceService().getString("Session_id") ?? "";
    empId = await PreferenceService().getString("UserId") ?? "";
    print("empId:$empId");
    try {
      await UserApi.QRLoginRequestAPI(empId, session, type, token)
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.sessionExists == 1) {
                        if (data.error == 0) {
                          toast(context, data.message);
                        } else if (data.error == 1) {
                          toast(context, data.message);
                        } else if (data.error == 2) {
                          toast(context, data.message);
                        } else {
                          toast(context,
                              "Something Went wrong, Please Try Again!");
                        }
                      } else {
                        toast(context,
                            "Your session has expired, please login again!");
                      }
                    })
                  }
                else
                  {}
              });
    } on Error catch (e) {
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
        ? 300.0
        : 450.0;
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
                child: Text("Scanner",
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
      body: Center(
        child: Container(
          child: QRView(
            onQRViewCreated: onQRViewCreated,
            key: scannerKey,
            formatsAllowed: [
              BarcodeFormat.qrcode,
            ],
            cameraFacing: CameraFacing.back,
            overlay: QrScannerOverlayShape(
                borderColor: ColorConstant.erp_appColor,
                borderRadius: 0,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
          ),
        ),
      ),
    );
  }
}
