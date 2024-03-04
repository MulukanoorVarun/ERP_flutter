import 'package:GenERP/Services/other_services.dart';
import 'package:GenERP/Services/user_api.dart';
import 'package:GenERP/Utils/storage.dart';
import 'package:GenERP/screens/AddAccount.dart';
import 'package:GenERP/screens/AttendanceHistory.dart';
import 'package:GenERP/screens/Dashboard.dart';
import 'package:GenERP/screens/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
 
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Location;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import '../../Utils/ColorConstant.dart';
import '../../Utils/FontConstant.dart';
import '../Scanner.dart';
import '../splash.dart';

class TagLocation extends StatefulWidget {
  const TagLocation({Key? key}) : super(key: key);

  @override
  State<TagLocation> createState() => _TagLocationState();
}

class _TagLocationState extends State<TagLocation> {
  var session = "";
  var empId = "";
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void onDispose(){
    Generator_id.dispose();
    super.dispose();
    _getLocationPermission();
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

  Future<void> TagLocationAPIFunction() async{
    session= await PreferenceService().getString("Session_id")??"";
    empId= await PreferenceService().getString("UserId")??"";
    try{
      if(Generator_id.text.isEmpty){
        setState(() {
          _error_genID = "Enter Generator Id";
        });
      }
      else{
        setState(() {
          _error_genID = "";
          _error_genID.isEmpty;
        });
        await UserApi.TagLocationAPI(empId, session,Generator_id.text,latlongs).then((data)=>{
          if(data!=null){
            setState((){
              if(data.sessionExists==1){
                if(data.error==0){
                  toast(context,"Location Tagged Successfully!!");
                  Navigator.pop(context,true);
                }
                else if(data.error==1){
                  toast(context, "Enter Valid Generator Id");
                }
                else{
                  toast(context, "Something Went wrong, Please Try Again!");
                }
              }else{
                PreferenceService().clearPreferences();
                toast(context,"Your session has expired, please login again");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Splash()));
              }
            })
          }else{
            toast(context, "No Response from server, Please try again later!")
          }
        });
      }

    } on Error catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                    child: Text("Tag Location",
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
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            color: ColorConstant.edit_bg_color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Expanded(
            child: Container(
              width: double.infinity, // Set width to fill parent width

              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Column(// Set max height constraints
                children: [
                  SizedBox(height: 15.0,),
                 Container(
                      child: Text("Scan QR Code or Enter ID", style: TextStyle(
                          fontSize: FontConstant.Size25,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,

                        color: ColorConstant.erp_appColor,
                      ),),),

                  SizedBox(height: 5.0,),
                  Container(
                    height: screenHeight*0.75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child:
                    Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                    InkWell(
                        onTap: ()async {
                          await Navigator.push(context,MaterialPageRoute(builder: (context)=>Scanner(from:"tagLocation")));
                        },
                        child:
                        Container(

                          child: SvgPicture.asset(
                            "assets/ic_qrcode.svg",
                            height: 350,
                            width: 350,
                          ),
                        )),
                        Container(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Spacer(),
                                Container(
                                  width:130,
                                  child:Divider(thickness: 1,color: Colors.grey) ,
                                ),
                                Spacer(),
                                Container(
                                  child: Text("OR", style:  TextStyle(
                                      fontSize: FontConstant.Size20,
                                      fontWeight: FontWeight.w300,
                                      overflow: TextOverflow.ellipsis,

                                    color: Colors.grey,
                                  ),),),
                                Spacer(),
                                Container(
                                  width:130,
                                  child:Divider(thickness: 1,color: Colors.grey) ,
                                ),
                                Spacer(),
                              ],
                            )
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          alignment: Alignment.center,
                          height: 55,
                          margin:EdgeInsets.only(left:15.0,right:15.0),
                          child: TextFormField(
                            controller: Generator_id,
                            cursorColor: ColorConstant.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Enter Generator ID",
                              hintStyle:  TextStyle(
                                  fontSize: FontConstant.Size15,
                                  color: ColorConstant.Textfield,
                                  fontWeight: FontWeight.w400,),
                              filled: true,
                              fillColor: ColorConstant.edit_bg_color,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
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
                        ),
                        if(_error_genID!=null)...[
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(
                                top: 2.5, bottom: 2.5, left: 25),
                            child: Text(
                              "$_error_genID",
                              textAlign: TextAlign.start,
                              style:  TextStyle(
                                  color: Colors.red,
                                  fontSize: FontConstant.Size10,
                              ),
                            ),
                          )
                        ]else...[
                        SizedBox(height: 20.0,),
                        ],
                        Container(
                            child: InkWell(
                              onTap: (){
                                TagLocationAPIFunction();
                                // Generator_id.dispose();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                decoration: BoxDecoration(color: ColorConstant.erp_appColor,borderRadius:BorderRadius.circular(10.0), ),
                                child: Text(
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                      color: ColorConstant.white,
                                      fontSize: FontConstant.Size15,
                                    ),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),

                  ),

                ],
              ),

            ),
          ),
        ),
      )
    );
  }
}
