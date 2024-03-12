import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:GenERP/screens/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart' as geo_location;

import 'package:google_api_headers/google_api_headers.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as Location;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Services/other_services.dart';
import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/Constants.dart';
import '../Utils/FontConstant.dart';
import '../Utils/MyWidgets.dart';
import '../Utils/storage.dart';
import 'CheckOutScreen.dart';
import 'FrontCameraCapture.dart';
import 'background_service.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);
  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final ImagePicker _picker = ImagePicker();

  // late LocationService locationService;
  TextEditingController _locationController = TextEditingController();
  String googleApikey = "AIzaSyAA2ukvrb1kWQZ2dttsNIMynLJqVCYYrhw";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(17.439112226708446, 78.43292499146135);
  String locationdd = "Search Location";
  late LatLng CurrentLocation;

  // var latlongs = "17.439112226708446, 78.43292499146135";
  var latlongs = "";
  Set<Marker> markers = {};
  List<String> addresses = [];
  var address_loading = true;
  Location.Location currentLocation1 = Location.Location();
  Location.LocationData? currentLocation;
  bool isLocationEnabled = false;
  bool hasLocationPermission = false;
  Timer? _timer;
  File? _image;
  var image_picked = 0;
  bool isLoading = true;
  var _validateLocation;

  late Set<Circle> circles;

  @override
  void initState() {
    _getLocationPermission();
    _getCurrentLocation();
    //  locationService = LocationService();
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    //  locationService = LocationService();
    super.dispose();
  }


  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: geo_location.LocationAccuracy.high
    );
    setState(() {
      CurrentLocation = LatLng(position.latitude, position.longitude);
    });
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

      // circles = Set.from([
      //   Circle(
      //     circleId: CircleId("value"),
      //     center:
      //         LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      //     radius: 200,
      //     strokeColor: Colors.blue,
      //     strokeWidth: 1,
      //   )
      // ]);

      setState(() {
        final lat = currentLocation!.latitude;
        final lang = currentLocation!.longitude!;
        latlongs = '$lat,$lang';
        //Storelocatorfunction(latlongs);
      });
    }
  }

  void _onCameraMove(CameraPosition position) {
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer(Duration(seconds: 1), () {
      _getLocationPermission();
    });
  }

  Future<bool> _onBackPressed() async {
    Navigator.pop(context, true);
    return true;
  }

  _imgFromCamera() async {
    if (_locationController.text.isEmpty) {
      setState(() {
        _validateLocation = "Please Enter location";
        print(_validateLocation);
      });
    } else {
      _validateLocation = "";
      // Capture a photo
      try {
        final XFile? galleryImage = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: imageQuality,
          preferredCameraDevice: CameraDevice.front,
        );
        print("added1");
        setState(() {
          print("added2");
          _image = File(galleryImage!.path);
          print("added3");
          image_picked = 1;
          print("added4");
          if (_image != null) {
            print("added5");
            var file =
                FlutterImageCompress.compressWithFile(galleryImage!.path);
            {
              print("added6");
              if (file != null) {
                print("added7");
                CheckIn();
              }
            }
          }
        });
      } catch (e) {
        debugPrint("mmmm: ${e.toString()}");
      }
    }
  }

  String? empId;
  String? sessionId;
  Future<void> CheckIn() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    print(empId);
    print(sessionId);
    print(_locationController.text);
    print(latlongs);
    print(_image);
    try {
      await UserApi.CheckInApi(
              empId, sessionId, _locationController.text, latlongs, _image)
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.error == 0) {
                        toast(context, "CheckedIn Successfully");
                        BackgroundLocation.startLocationService();
                        Navigator.pop(context, true);
                        isLoading = false;
                      } else {
                        isLoading = false;
                        toast(context, "CheckedIn UnSuccessfull");
                        print(data.error.toString());
                      }
                    })
                  }
                else
                  {toast(context, "Something went wrong, Please try again.")}
              });
    } on Exception catch (e) {
      print("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: (isLoading)
          ? Loaders()
          : SafeArea(
              child: Container(
                color: ColorConstant.erp_appColor,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      color: ColorConstant.erp_appColor,
                      height: 50,
                      child: Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20)),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: SvgPicture.asset(
                              "assets/back_icon.svg",
                              height: 24,
                              width: 24,
                            ),
                          ),
                          SizedBox(width: 20),
                          Center(
                            child: Text(
                              "Check In",
                              style: TextStyle(
                                fontSize: FontConstant.Size18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        // Apply border radius using ClipRRect
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        // padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Stack(children: [
                          GoogleMap(
                            myLocationEnabled: true,
                            zoomGesturesEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: CurrentLocation,
                              zoom: 20.0,
                            ),
                            markers: markers.toSet(),
                          //  zoomControlsEnabled: false,
                        //    minMaxZoomPreference: MinMaxZoomPreference(14, 14),
                          //  scrollGesturesEnabled: false,
                          //   liteModeEnabled: true,
                           // circles: circles,
                            mapType: MapType.normal,
                            onMapCreated: (controller) {
                              setState(() {
                                mapController = controller;
                              });
                            },
                            onCameraMove: _onCameraMove,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: size.height * 0.25,
                              decoration: BoxDecoration(
                                color: ColorConstant.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      height: 50,
                                      width: 320,
                                      child: TextFormField(
                                        controller: _locationController,
                                        cursorColor: ColorConstant.black,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText: "Enter Check In Location",
                                          hintStyle: TextStyle(
                                              fontSize: FontConstant.Size15,
                                              color: ColorConstant.grey_153,
                                              fontWeight: FontWeight.w400),
                                          filled: true,
                                          fillColor:
                                              ColorConstant.edit_bg_color,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: ColorConstant
                                                    .edit_bg_color),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: ColorConstant
                                                    .edit_bg_color),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: ColorConstant
                                                    .edit_bg_color),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_validateLocation != null) ...[
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(
                                              top: 2.5, bottom: 2.5, left: 25),
                                          child: Text(
                                            _validateLocation,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: FontConstant.Size10,
                                            ),
                                          ),
                                        )),
                                  ] else ...[
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                        });
                                        // _imgFromCamera();
                                        if (_locationController.text.isEmpty) {
                                          setState(() {
                                            _validateLocation =
                                                "Please Enter location";
                                            print(_validateLocation);
                                          });
                                        } else {
                                          _validateLocation = "";
                                          _image = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FrontCameraCapture()));
                                          print("${_image} _image akash");
                                          setState(() {
                                            isLoading = true;
                                            image_picked = 1;
                                            CheckIn();
                                          });
                                        }
                                      },
                                      // onTap: () async {
                                      //
                                      //  // BackgroundLocation.stopLocationService();
                                      //   _imgFromCamera();
                                      // },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 45,
                                        width: screenWidth,
                                        margin: EdgeInsets.only(
                                            left: 30.0, right: 30.0),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.erp_appColor,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Text(
                                          "Punch In (Upload Selfie)",
                                          style: TextStyle(
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                            color: ColorConstant.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
