import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../Services/other_services.dart';
import '../Utils/MyWidgets.dart';



class FrontCameraCapture extends StatefulWidget {
  const FrontCameraCapture({Key? key}) : super(key: key);

  @override
  State<FrontCameraCapture> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<FrontCameraCapture> {
  late List<CameraDescription> _cameras;
  late CameraController cam_controller;


  File? _image;
  var image_picked = 0;
  bool isLoading = true;

  Future<void> _getavailableCameras() async {
    _cameras = await availableCameras();

    print("${_cameras} mmmmmmmmmmmmmm");
    cam_controller = CameraController(_cameras[1], ResolutionPreset.max);
    cam_controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isLoading=false;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            toast(context, "CameraAccessDenied");
            // Handle access errors here.
            break;
          default:
            toast(context, "Unable to Open");
            // Handle other errors here.
            break;
        }
      }
    });
  }
  @override
  void initState() {
    _getavailableCameras();
    // _getLocationPermission();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // if (!cam_controller.value.isInitialized) {
    //   return Loaders();
    // }
    return MaterialApp(
      home:(isLoading)?Loaders():
          Column(
            children: [
              Container(
                  child: CameraPreview(cam_controller)),

              Container(
                padding: EdgeInsets.all(10),
                height: size.height*0.12,
                child: TextButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white70),),onPressed: () async {
                  final image = await cam_controller.takePicture();
                
                
                  _image = File(image.path);
                  Navigator.pop(context,_image);
                  print("${_image} image_path akash");
                }, child: Icon(Icons.camera,size: 35,color: Colors.black,),),
              )
            ],
          ),
      // Text("Capture",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 25)),

    );
  }
}
