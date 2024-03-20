import 'dart:async';

import 'package:GenERP/Utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_download_manager/flutter_download_manager.dart';
import 'package:flutter_svg/svg.dart';
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
  PullToRefreshController? pullToRefreshController;
  PullToRefreshSettings pullToRefreshSettings = PullToRefreshSettings(
    color: ColorConstant.erp_appColor,
  );
  bool pullToRefreshEnabled = true;

  final GlobalKey webViewKey = GlobalKey();
  var dl = DownloadManager();
  @override
  void initState() {
    //  loadData();
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: pullToRefreshSettings,
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
    print("URL:${widget.url}");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController!.canGoBack()) {
          webViewController!.goBack();
          return false; // Prevent default back button behavior
        }
        return true; // Allow default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.erp_appColor,
          elevation: 0,
          title: Container(
              child: Row(
            children: [
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
              SizedBox(width: 10),
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
            width: 10,
          ),
          leadingWidth: 20,
        ),
        body: Container(
            child: Column(children: <Widget>[
          Expanded(
              child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(widget.url),
                ),
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
                  webViewController = controller;
                  _controller.complete(controller);
                },
                pullToRefreshController: pullToRefreshController,
                onLoadStart: (controller, url) {
                  return setState(() {
                    isLoading = true;
                  });
                },
                onLoadStop: (controller, url) {
                  pullToRefreshController?.endRefreshing();
                  return setState(() {
                    isLoading = false;
                  });
                },
                onReceivedError: (controller, request, error) {
                  pullToRefreshController?.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController?.endRefreshing();
                  }
                },
              ),
              if (isLoading) ...[Loaders()]
            ],
          ))
        ])),
      ),
    );
  }
}
