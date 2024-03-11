import 'dart:async';

import 'package:GenERP/Utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_download_manager/flutter_download_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Services/other_services.dart';
import '../Services/user_api.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';
import '../Utils/MyWidgets.dart';

const MAX_PROGRESS = 100;

Future main() async {
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  await Permission.storage.request();
}

class WhizzdomScreen extends StatefulWidget {
  final String url;
  const WhizzdomScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<WhizzdomScreen> createState() => _WhizzdomScreenState();
}

class _WhizzdomScreenState extends State<WhizzdomScreen> {
  final Completer<InAppWebViewController> _controller =
  Completer<InAppWebViewController>();
  var empId = "";
  var sessionId = "";
  bool isLoading = true;
  InAppWebViewController? webViewController;

  final GlobalKey webViewKey = GlobalKey();
  var dl = DownloadManager();
  @override
  void initState() {
  //  loadData();
    print("URL:${widget.url}");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                      child: Text("Whizzdom",
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
        body: Container(
            child: Column(children: <Widget>[
              Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: WebUri(widget.url),),
                    androidOnGeolocationPermissionsShowPrompt:
                        (InAppWebViewController controller, String origin) async {
                      return GeolocationPermissionShowPromptResponse(
                          origin: origin, allow: true, retain: true);
                    },
                    initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                        useWideViewPort: true,
                        loadWithOverviewMode: true,
                        allowContentAccess: true,
                        geolocationEnabled: true,
                        allowFileAccess: true,
                        databaseEnabled: true, // Enables the WebView database
                        domStorageEnabled: true, // Enables DOM storage
                        builtInZoomControls: true, // Enables the built-in zoom controls
                        displayZoomControls: false, // Disables displaying zoom controls
                        safeBrowsingEnabled: true, // Enables Safe Browsing
                        clearSessionCache: true,
                      ),

                      ios: IOSInAppWebViewOptions(
                        allowsInlineMediaPlayback: true,
                      ),
                    ),
                    androidOnPermissionRequest: (InAppWebViewController controller,
                        String origin, List<String> resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    onWebViewCreated: (controller) {
                      _controller.complete(controller);
                    },
                    onLoadStart: (controller, url) {},
                    onLoadStop: (controller, url) {},
                  ))
            ])),
      ),
    );
  }
}
