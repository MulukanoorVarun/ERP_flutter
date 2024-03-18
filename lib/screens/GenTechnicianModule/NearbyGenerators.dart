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
import '../Login.dart';
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
  String googleApikey = "AIzaSyBGzvgMMKwPBAANTwaoRsAnrCpiWCj8wVs";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(17.439112226708446, 78.43292499146135);
  String locationdd = "Search Location";
  // var latlongs = "17.439112226708446, 78.43292499146135";
  var latlongs = "";
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
  String _selectedItem = 'Active'; // Initial selection

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

  double currentValue = 1.0;

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
        final lat = currentLocation!.latitude;
        final lang = currentLocation!.longitude!;
        latlongs = '$lat,$lang';
        LoadNearbyGeneratorsAPI();
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
  List<Nearbygenerators> generatorslist = [];
  Future<void> LoadNearbyGeneratorsAPI() async {
    empId = await PreferenceService().getString("UserId");
    sessionId = await PreferenceService().getString("Session_id");
    print(empId);
    print(sessionId);
    print(_locationController.text);
    print(latlongs);
    print(currentValue);
    print(_selectedItem);
    try {
      await UserApi.loadNearbyGeneratorsAPI(
              empId, sessionId, latlongs, currentValue,_selectedItem)
          .then((data) => {
                if (data != null)
                  {
                    setState(() {
                      if (data.sessionExists == 1) {
                        if (data.error == 0) {
                          generatorslist = data.list!;
                          _updateMarkersFromApiResponse(data.list!);
                          isLoading = false;
                        } else {}
                      } else {
                        PreferenceService().clearPreferences();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
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

  Future<void> _updateMarkersFromApiResponse(
      List<Nearbygenerators> generatorslist) async {
    markers = await _createMarkersFromApiResponse(generatorslist);

    await Future.forEach(generatorslist, (store) async {
      String address = await _getAddressFromLatLng(store.loc);
      addresses.add(address);
    });
    for (int i = 0; i < addresses.length; i++) {
      //print('List of Addresses:' "${addresses[i]}");
      // print('List of Addresses:' "${addresses[1]}" );
    }
  }

  Future<List<Marker>> _createMarkersFromApiResponse(
      List<Nearbygenerators> generatorslist) async {
    List<Marker> markers = [];

    // print("Hello Nutsby!");
    ByteData data = await rootBundle.load("assets/dg.png");
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
          int index = generatorslist.indexWhere((techResponse) =>
              techResponse.generatorId == generator.generatorId);
          print("index:${index}");
          if (index != -1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GeneratorDetails(
                  actName: "NearByGenerators",
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

  Future<void> infoDialogue(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return
            WillPopScope(
              onWillPop: () async {
            // Prevent dialog from closing on back press
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title:Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Filter',
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: FontConstant.Size25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: SvgPicture.asset(
                        "assets/ic_cancel.svg",
                        height: 35,
                        width: 35,
                      ),
                      onTap: () {
                        setState(() {
                          currentValue = 0.0;
                          _selectedItem = "Active";
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Divider( // Add Divider widget here
                  color: Colors.grey, // Set the color of the underline
                  thickness: 1.0, // Set the thickness of the underline
                  height: 0.0, // Set the height of the divider to 0 to avoid additional space
                ),
              ],
            ),
            content: Container(
              height: 230,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Row(
                      children: [
                        Text("Radius", // Display current value
                          style: TextStyle(fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          '${currentValue.toStringAsFixed(2)} KM', // Display current value
                          style: TextStyle(fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    Slider(
                      value: currentValue,
                      max: 100,
                      divisions: 100,
                      label: currentValue.toStringAsFixed(2),
                      activeColor: ColorConstant.erp_appColor,
                      inactiveColor: Colors.grey,
                      thumbColor: ColorConstant.erp_appColor,
                      onChanged: (value) {
                        // Update currentValue when Slider value changes
                        setState(() {
                          currentValue = value;
                        });
                      },
                    ),
                    Text(
                      'Status',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: FontConstant.Size20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
              Container(
                width: 200, // Set the desired width here
                child: DropdownButton<String>(
                  value: _selectedItem,
                  items: <String>['Active', 'Inactive', 'Suspense']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                    });
                  },
                  icon: null, // Remove the default dropdown icon
                ),
              ),
                    SizedBox(height: 30.0),
                    Container(
                        child: InkWell(
                      onTap: () {
                        markers = [];
                        LoadNearbyGeneratorsAPI();
                        Navigator.pop(context);
                        setState(() {
                          currentValue = 0.0;
                          _selectedItem = "Active";
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        decoration: BoxDecoration(
                          color: ColorConstant.erp_appColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          "Search",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            color: ColorConstant.white,
                            fontSize: FontConstant.Size15,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      barrierDismissible: false,
    );
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
                              "Nearby Generators",
                              style: TextStyle(
                                fontSize: FontConstant.Size18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              infoDialogue(context);
                            },
                             icon:Icon(
                              Icons.filter_alt,
                              color: Colors.white,
                               size: 35,
                            ),
                          ),
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
                        child: Stack(children: [
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
