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

class WebERP extends StatefulWidget {
  final String url;
  const WebERP({Key? key, required this.url}) : super(key: key);

  @override
  State<WebERP> createState() => _WebERPState();
}

class _WebERPState extends State<WebERP> {
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
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadData() async {
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
    empId = await PreferenceService().getString("UserId") ?? "";
    sessionId = await PreferenceService().getString("Session_id") ?? "";
    print(1724);
    print("Loaded empId: $empId");
    print("Loaded sessionId: $sessionId");
    setState(() {
      isLoading = false;
    });
  }
  Future<void> _refresh() async {
    // Simulate a delay to mimic fetching new data from an API
    await Future.delayed(const Duration(seconds: 2));
    // Generate new data or update existing data
    setState(() {
      isLoading = true;
      // DashboardApiFunction();
    });
  }

  //////////////////testing

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: _refresh, child: MaterialApp(
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
                      child: Text("ERP",
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
                    initialUrlRequest: URLRequest(url: WebUri(widget.url),
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
                        safeBrowsingEnabled: true,// Enables Safe Browsing
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

                    onLoadStart: (controller, url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                    onLoadStop: (controller, url) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onDownloadStartRequest: (controller, url) async {
                      await UserApi.download_files(
                          empId, sessionId, "${url.url}", context)
                          .then((data) => {print(data)});
                      // final taskid = await FlutterDownloader.enqueue(
                      //   url: url.toString(),
                      //   savedDir: "/storage/emulated/0/Download",
                      //   showNotification: true, // show download progress in status bar (for android)
                      //   openFileFromNotification: true, // click on notification to open downloaded file (for android)
                      // );
                    },
                  ))
            ])),
      ),
    ));
  }
  ///////////////////testign

  // Future<void> downloadFile(String url) async {
  //   // Implement your download logic here
  //   print("Downloading file from: $url");
  //   // Example: Use flutter_downloader package to download the file
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: ColorConstant.erp_appColor,
  //         elevation: 0,
  //         title: Container(
  //             child: Row(
  //           children: [
  //             // Spacer(),
  //             Container(
  //               child: InkWell(
  //                 onTap: () => Navigator.pop(context, true),
  //                 child: Text("ERP",
  //                     textAlign: TextAlign.left,
  //                     style: TextStyle(
  //                       color: ColorConstant.white,
  //                       fontSize: FontConstant.Size18,
  //                       fontWeight: FontWeight.w500,
  //                     )),
  //               ),
  //             ),
  //           ],
  //         )),
  //         titleSpacing: 0,
  //         leading: Container(
  //           margin: const EdgeInsets.only(left: 10),
  //           child: GestureDetector(
  //             onTap: () => Navigator.pop(context, true),
  //             child: const Icon(
  //               Icons.arrow_back_ios,
  //               color: Colors.white,
  //               size: 24.0,
  //             ),
  //           ),
  //         ),
  //       ),
  //       body:(isLoading)?Loaders(): SafeArea(
  //         child: Container(
  //           child: InAppWebView(
  //             key: webViewKey,
  //             initialUrlRequest: URLRequest(url: WebUri(widget.url),),
  //             onWebViewCreated: (controller) {
  //               _controller.complete(controller);
  //             },
  //
  //             onLoadStart: (controller, url) {
  //               print("Akash");
  //               // This is called when the page starts loading
  //               setState(() {
  //                 isLoading = true; // Set isLoading to true when the page starts loading
  //               });
  //             },
  //             onLoadStop: (controller, url) {
  //               setState(() {
  //                 print("stop");
  //                 isLoading = false;
  //               });
  //             },
  //             onLoadError: (controller, url, code, message) {
  //               // Handle loading errors
  //               print("Error loading $url: $code, $message");
  //             },
  //             onProgressChanged: (controller, progress) {
  //
  //                 setState(() {
  //                   isLoading = false;
  //                 });
  //
  //             },
  //
  //
  //             initialOptions: InAppWebViewGroupOptions(
  //               crossPlatform: InAppWebViewOptions(
  //                   javaScriptEnabled: true,
  //                   useOnDownloadStart: true,
  //                   allowFileAccessFromFileURLs: true,
  //                   allowUniversalAccessFromFileURLs: true
  //               ),
  //             ),
  //
  //
  //             initialSettings: InAppWebViewSettings(
  //               allowUniversalAccessFromFileURLs: true,
  //               allowFileAccessFromFileURLs: true,
  //               allowFileAccess: true,
  //               iframeAllow: "camera;microphone;location",
  //               domStorageEnabled: true,
  //               allowContentAccess: true,
  //               javaScriptEnabled: true,
  //               cacheMode:CacheMode.LOAD_DEFAULT,
  //               supportZoom:true,
  //               builtInZoomControls:true,
  //               displayZoomControls: false,
  //               textZoom: 125,
  //               blockNetworkImage: false,
  //               loadsImagesAutomatically: true,
  //               safeBrowsingEnabled: true,
  //               useWideViewPort: true,
  //               loadWithOverviewMode: true,
  //               javaScriptCanOpenWindowsAutomatically: true,
  //               mediaPlaybackRequiresUserGesture: false,
  //               geolocationEnabled: true,
  //                 useOnDownloadStart:true,
  //
  //             ),
  //             // initialUrlRequest: URLRequest(
  //             //   url: WebUri.uri(Uri.parse(webPageUrl))
  //             // ),
  //             // onLoadStop: (controller, url) {
  //             //   setState(() {
  //             //     isLoading = false;
  //             //   });
  //             // },
  //             //
  //
  //               onDownloadStartRequest:(controller, downloadStartRequest) async {
  //                 print("littu1");
  //
  //                 var dl = DownloadManager();
  //                 print("littu2");
  //
  //                 dl.addDownload(downloadStartRequest.url.path, "/storage/emulated/0/Download");
  //                 print("littu3");
  //
  //                 print("${downloadStartRequest.url.path } 3.5");
  //
  //                 final taskId = await FlutterDownloader.enqueue(
  //                   url: downloadStartRequest.url.toString(),
  //                   fileName:downloadStartRequest.suggestedFilename.toString() ,
  //                   savedDir:'/storage/emulated/0/Download',
  //                 );
  //
  //                 //
  //                 // DownloadTask? task = dl.getDownload(downloadStartRequest.url.path.toString());
  //                 // print("littu4");
  //                 //
  //                 // print("${task} littu4.5");
  //                 // task?.status.addListener(() {
  //                 //   print(task.status.value);
  //                 //   print("littu5");
  //                 //
  //                 //   // print("littu");
  //                 // });
  //                 // print("littu6");
  //                 //
  //                 // print(downloadStartRequest.mimeType.toString());
  //                 // print("littu6.5");
  //                 //
  //                 // task?.request.forceDownload;
  //                 // task?.request.path;
  //                 // task?.request.url;
  //                 // task?.progress.addListener(() {
  //                 //   print("littu10");
  //                 //
  //                 //   print(task.progress.value);
  //                 // });
  //                 //
  //                 // await dl.whenDownloadComplete(downloadStartRequest.url.toString());
  //
  //
  //                 // DownloadStartRequest(url: downloadStartRequest.url,contentLength: 10,mimeType: downloadStartRequest.mimeType);
  //               },
  //
  //
  //             // onDownloadStart: (controller, url) async {
  //             //   toast(context, "0");
  //             //   // );
  //             //   var dio = Dio();
  //             //
  //             //   var dl = DownloadManager();
  //             //
  //             //   dl.addDownload(url.path, "/storage/emulated/0/Download");
  //             //
  //             //
  //             //   DownloadTask? task = dl.getDownload(url.toString());
  //             //
  //             //   task?.status.addListener(() {
  //             //     print(task.status.value);
  //             //     print(task.progress.value);
  //             //     print("littu");
  //             //   });
  //             //
  //             //   print("littu");
  //             //   print(url.data);
  //             //   print(url.host);
  //             //   print(url.path);
  //             //   var response = await dio.download("${url!.data}","/sdcard/download/");
  //             //   if (response.statusCode == 200) {
  //             //     toast(context, "Download successful. Check your downloads.");
  //             //   }else{
  //             //     toast(context, "Download failed. Status code: ${response.statusCode}");
  //             //   }
  //             //
  //             //   await dl.whenDownloadComplete(url.toString());
  //             //
  //             // },
  //             // onDownloadStart: (controller, downloadStartRequest) async {
  //             //   var dl = DownloadManager();
  //             //   dl.addDownload(downloadStartRequest.url.path, "/storage/emulated/0/Download");
  //             //
  //             //   DownloadTask? task = dl.getDownload(downloadStartRequest.url.toString());
  //             //
  //             //   task?.status.addListener(() {
  //             //     print(task.status.value);
  //             //     print("Download status changed");
  //             //   });
  //             //
  //             //   task?.progress.addListener(() {
  //             //     print(task.progress.value);
  //             //     print("Download progress changed");
  //             //   });
  //             //
  //             //   await dl.whenDownloadComplete(downloadStartRequest.url.toString());
  //             // },
  //
  //
  //
  //
  //             // pullToRefreshController: PullToRefreshController(
  //             //   onRefresh: () {
  //             //     setState(() {
  //             //       isLoading = true;
  //             //       loadData();
  //             //     });
  //             //
  //             //   },
  //             // ),
  //
  //           ),
  //         ),
  //       ));
  // }
}
