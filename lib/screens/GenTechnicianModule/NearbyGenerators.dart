import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:GenERP/Utils/Constants.dart';
import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
import '../../Services/other_services.dart';
import '../../Services/user_api.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../../Utils/MyWidgets.dart';
import '../../models/NearbyGeneratorsResponse.dart';
import '../GenTracker/GeneratoraDetails.dart';
import '../background_service.dart';



class NearbyGenerators extends StatefulWidget {
  const NearbyGenerators({Key? key}) : super(key: key);
  @override
  State<NearbyGenerators> createState() => _NearbyGeneratorsState();
}

class _NearbyGeneratorsState extends State<NearbyGenerators> {
  final ImagePicker _picker = ImagePicker();
  // late LocationService locationService;
  TextEditingController _locationController = TextEditingController();
  String googleApikey = "AIzaSyAA2ukvrb1kWQZ2dttsNIMynLJqVCYYrhw";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(17.439112226708446, 78.43292499146135);
  String locationdd = "Search Location";
  // var latlongs = "17.439112226708446, 78.43292499146135";
  var latlongs = "";
  var radius = "1";
  List<Marker> markers = [];
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

  @override
  void initState() {
    _getLocationPermission();
    //LoadNearbyGeneratorsAPI();
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    //  locationService = LocationService();
    super.dispose();
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
      //
      // markers.add(Marker(
      //   markerId: MarkerId('current_location'),
      //   position:
      //   LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      //   infoWindow: InfoWindow(title: 'Current Location'),
      //   icon: BitmapDescriptor.defaultMarker,
      // ));

      setState(() {
        final lat = currentLocation!.latitude;
        final lang = currentLocation!.longitude!;
        latlongs = '$lat,$lang';
        LoadNearbyGeneratorsAPI();
      });
    }
  }

  void _onCameraMove(CameraPosition position) {
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer(Duration(seconds: 1), () {
      _getLocationPermission();
    });
  }


  String? empId;
  String? sessionId;
  List<Nearbygenerators> generatorslist=[];
  Future<void> LoadNearbyGeneratorsAPI() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    print(empId);
    print(sessionId);
    print(_locationController.text);
    print(latlongs);
    print(_image);
    try {
      await UserApi.loadNearbyGeneratorsAPI(empId,sessionId,latlongs,radius).then((data) => {
        if (data != null)
          {
            setState(() {
              if (data.error == 0) {
                generatorslist=data.list!;
                _updateMarkersFromApiResponse(data.list!);
                isLoading = false;
              } else {

              }
            })
          } else {
          toast(context,"Something went wrong, Please try again.")
        }
      });

    } on Exception catch (e) {
      print("$e");
    }
  }
  Future<void> _updateMarkersFromApiResponse(
      List<Nearbygenerators> generatorslist) async {
    markers = await _createMarkersFromApiResponse(generatorslist);

    await Future.forEach(generatorslist, (store) async {
      String address = await _getAddressFromLatLng(store.loc);
      addresses.add(address);
    });
    for (int i = 0; i < addresses.length; i++) {
      print('List of Addresses:' "${addresses[i]}");
      // print('List of Addresses:' "${addresses[1]}" );
    }
  }

  Future<List<Marker>> _createMarkersFromApiResponse(
      List<Nearbygenerators> generatorslist ) async {
    List<Marker> markers = [];

    // print("Hello Nutsby!");
    ByteData data = await rootBundle.load("assets/images/navigation_pin.png");
    Uint8List bytes = data.buffer.asUint8List();

    await Future.forEach(generatorslist, (generator) async {
      ui.Codec codec = await ui.instantiateImageCodec(bytes,
          targetWidth: 75, targetHeight: 95);
      ui.FrameInfo fi = await codec.getNextFrame();
      Uint8List resizedBytes =
      (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();

      markers.add(Marker(
        markerId: MarkerId(generator.generatorId.toString()),
        position: _parseLatLng(generator.loc),
        icon: BitmapDescriptor.fromBytes(resizedBytes),
        infoWindow: InfoWindow(
          title: "Customer Name: ${generator.accName}",
          snippet: "Product Name: ${generator.productName}",
        ),
        onTap: () {
        int index = generatorslist.indexWhere((techResponse) => techResponse.generatorId == generator.generatorId);
        print("index:${index}");
        if (index != -1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GeneratorDetails(
                actName: generator.accName,
                location: generator.loc,
                generatorId: generator.generatorId,
              ),
            ),
          );
        }
      },
      ));
    });

    return markers;
  }


  LatLng _parseLatLng(String? location) {
    if (location != null) {
      List<String> parts = location.split(',');
      if (parts.length == 2) {
        double lat = double.tryParse(parts[0]) ?? 0.0;
        double lng = double.tryParse(parts[1]) ?? 0.0;
        return LatLng(lat, lng);
      }
    }
    return const LatLng(0.0, 0.0);
  }


  Future<String> _getAddressFromLatLng(String? location) async {
    if (location != null) {
      List<String> parts = location.split(',');
      if (parts.length == 2) {
        double lat = double.tryParse(parts[0]) ?? 0.0;
        double lng = double.tryParse(parts[1]) ?? 0.0;

        List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(lat, lng);

        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;
          String address = '${placemark.street ?? ''}, '
              '${placemark.thoroughfare ?? ''} '
          // '${placemark.subThoroughfare ?? ''}, '
          // '${placemark.name ?? ''}, '
              '${placemark.subLocality ?? ''}, '
              '${placemark.locality ?? ''}, '
              '${placemark.administrativeArea ?? ''}, '
              '${placemark.subAdministrativeArea ?? ''} '
              '${placemark.postalCode ?? ''}, '
              '${placemark.country ?? ''}';
          return address.trim();
        }
      }
    }
    return "Address not found";
  }
  
  InfoDialogue(BuildContext context) {
    double _currentValue = 0.0;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Radius (Kms)',
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: FontConstant.Size25,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        content:Container(
          height: 200,
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Value: $_currentValue',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 20.0),
              Slider(
                value: _currentValue,
                max: 100,
                divisions: 5, // Optional: Creates discrete steps in the SeekBar
                label: _currentValue.round().toString(), // Optional: Displays a label above the current value
                activeColor: Colors.blue, // Color for the active part of the SeekBar
                inactiveColor: Colors.grey, // Color for the inactive part of the SeekBar
                thumbColor: Colors.red, // Color for the thumb (indicator) of the SeekBar
                onChanged: (value) {
                  // Update _currentValue when SeekBar value changes
                  setState(() {
                    _currentValue = value;
                  });
                },
              ),

            ],
          ),
        ),
      ),
      ),
      barrierDismissible: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: (isLoading)?Loaders():SafeArea(
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
                    InkWell(
                      onTap: (){
                        Navigator.pop(context,true);
                      },
                      child:SvgPicture.asset(
                        "assets/back_icon.svg",
                        height: 24,
                        width: 24,
                      ),),
                    SizedBox(width: 20),
                    Center(
                      child: Text(
                        "Nearby Generators",
                        style: TextStyle(
                          fontSize: FontConstant.Size18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        InfoDialogue(context);
                      },
                      child:SvgPicture.asset(
                        "assets/ic_location1.svg",
                        height: 35,
                        width: 35,
                      ),),
                    SizedBox(width: 20),
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
