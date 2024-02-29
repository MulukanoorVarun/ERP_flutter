import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:GenERP/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'LocationService.dart';
import 'background_service.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  TextEditingController _locationController = TextEditingController();
  String googleApikey = "AIzaSyAA2ukvrb1kWQZ2dttsNIMynLJqVCYYrhw";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(17.439112226708446, 78.43292499146135);
  String locationdd = "Search Location";
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
  final ImagePicker _picker = ImagePicker();
  File? _image;
  var image_picked = 0;
  @override
  void initState() {
    _getLocationPermission();
    super.initState();
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
    // Capture a photo
    try {
      final XFile? galleryImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      );
      print("added");
      setState(() {
        _image = File(galleryImage!.path);
        image_picked = 1;
        CheckOut();
      });
    } catch (e) {
      debugPrint("mmmm: ${e.toString()}");
    }
  }
  String? empId;
  String? sessionId;
  Future<void> CheckOut() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    try {
      print(empId);
      print(sessionId);
      print(_locationController.text);
      print(latlongs);
      print(_image);
      await UserApi.CheckOutApi(empId,sessionId,_locationController.text,latlongs,_image).then((data) => {
        if (data != null)
          {
            setState(() {
              if (data.error == 0) {
                BackgroundLocation.stopLocationService();
              } else {
                print(data.error.toString());
              }
            })
          }
        else
          {print("Something went wrong, Please try again.")}
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
      body: SafeArea(
        child: Container(
          color: ColorConstant.erp_appColor,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                color: ColorConstant.erp_appColor,
                height:50,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20)),
                    SvgPicture.asset(
                      "assets/back_icon.svg",
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 25),
                    Center(
                      child: Text(
                        "Check Out",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
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
                  child: Stack(
                      children: [
                        GoogleMap(
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: startLocation,
                            zoom: 14.0,
                          ),
                          markers: markers.toSet(),
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
                                SizedBox(height: 25,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child:Text(
                                    "Location",
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        fontSize: FontConstant.Size15,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: Colors.grey,
                                    ),
                                  ),),
                                SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child:Container(
                                    height: 50,
                                    width: 320,
                                    child:TextFormField(
                                      controller: _locationController,
                                      cursorColor: ColorConstant.black,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "Enter Check Out Location",
                                        hintStyle: GoogleFonts.ubuntu(
                                          textStyle: TextStyle(
                                              fontSize: FontConstant.Size15,
                                              color: ColorConstant.grey_153,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        filled: true,
                                        fillColor: ColorConstant.edit_bg_color,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                              width: 0, color: ColorConstant.edit_bg_color),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              width: 0, color: ColorConstant.edit_bg_color),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              width: 0, color: ColorConstant.edit_bg_color),
                                        ),
                                      ),
                                    ),
                                  ),),
                                SizedBox(height: 30,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child:InkWell(
                                    onTap: (){
                                      _imgFromCamera();
                                    },
                                    child:Container(
                                      alignment: Alignment.center,
                                      height: 45,
                                      width: screenWidth,
                                      margin: EdgeInsets.only(left: 30.0,right: 30.0),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.erp_appColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child:Text(
                                        "Punch Out (Upload Selfie)",
                                        style: GoogleFonts.ubuntu(
                                          textStyle: TextStyle(
                                            fontSize: FontConstant.Size18,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          color: ColorConstant.white,
                                        ),
                                      ),


                                    ),
                                  ),),

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
