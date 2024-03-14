import 'dart:async';
import 'dart:io';
import 'package:GenERP/Utils/ColorConstant.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../Services/other_services.dart';
import '../Utils/FontConstant.dart';
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.erp_appColor,
        title: Text(
          'Capture Image',
          style: TextStyle(
            fontSize: FontConstant.Size18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context,true);
          },
        ),
      ),
      body: (isLoading)
          ? Loaders()
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
               height: size.height * 0.8, // Adjusted height for camera preview
              child: CameraPreview(cam_controller),
            ),
            Container(
              height: size.height * 0.1,
              padding: EdgeInsets.all(10),
              child: Center(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white70),
                  overlayColor: MaterialStatePropertyAll(Colors.white70),
                ),
                onPressed: () async {
                  final image = await cam_controller.takePicture();
                  _image = File(image.path);
                  Navigator.pop(context, _image);
                  print("${_image} image_path akash");
                },
                child: Icon(
                  Icons.camera,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }


// Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: ColorConstant.erp_appColor,
  //       title: Text(
  //         'Capture Image',
  //         style: TextStyle(
  //           fontSize: FontConstant.Size18,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //         ),
  //       ),
  //       leading: IconButton(
  //         icon: Icon(
  //           Icons.arrow_back,
  //           color: Colors.white,
  //         ),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //       ),
  //     ),
  //     body: (isLoading) ? Loaders()
  //         : ListView( // Wrap the Column with a ListView
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),// Set shrinkWrap to true
  //       children: [
  //         Container(
  //           height: size.height * 0.8,
  //           child: CameraPreview(cam_controller),
  //         ),
  //         Container(
  //           padding: EdgeInsets.all(10),
  //           height: size.height * 0.1,
  //           child: TextButton(
  //
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStatePropertyAll(Colors.white70),
  //               overlayColor:  MaterialStatePropertyAll(Colors.white70),
  //             ),
  //             onPressed: () async {
  //               final image = await cam_controller.takePicture();
  //               _image = File(image.path);
  //               Navigator.pop(context, _image);
  //               print("${_image} image_path akash");
  //             },
  //             child: Icon(
  //               Icons.camera,
  //               size: 35,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
