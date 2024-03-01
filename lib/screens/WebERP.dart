import 'package:GenERP/Utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_download_manager/flutter_download_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';
import '../Utils/MyWidgets.dart';

const MAX_PROGRESS = 100;
class WebERP extends StatefulWidget {
  final String url;
  const WebERP({Key? key,required this.url}) : super(key: key);

  @override
  State<WebERP> createState() => _WebERPState();
}

class _WebERPState extends State<WebERP> {

  var empId = "";
  var sessionId = "";
  var webPageUrl = "";
  bool isLoading = true;
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();
  var dl = DownloadManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  void onDispose() {
    // TODO: implement initState

    super.dispose();
  }


  Future<void> loadData() async {
    empId = await PreferenceService().getString("UserId") ?? "";
    sessionId = await PreferenceService().getString("Session_id") ?? "";
    print(1724);
    print("Loaded empId: $empId");
    print("Loaded sessionId: $sessionId");
      setState(() {
        isLoading = false;
      });


  }
  Future<void> downloadFile(String url) async {
    // Implement your download logic here
    print("Downloading file from: $url");
    // Example: Use flutter_downloader package to download the file
  }


  @override
  Widget build(BuildContext context) {
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
                  child: Text("Web ERP",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.ubuntu(
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
        body:(isLoading)?Loaders(): SafeArea(
          child: Container(
            child: InAppWebView(
              key: webViewKey,
              onProgressChanged: (controller, progress) {
                if(progress < MAX_PROGRESS){
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              // initialUrlRequest: URLRequest(
              //   url: WebUri.uri(Uri.parse(webPageUrl))
              // ),
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
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  useOnDownloadStart: true,
                  allowFileAccessFromFileURLs: true,
                  allowUniversalAccessFromFileURLs: true,
                ),
              ),
                onDownloadStartRequest:(controller, downloadStartRequest) async {
                  var dl = DownloadManager();
                  dl.addDownload(downloadStartRequest.url.path, "/storage/emulated/0/Download");

                  DownloadTask? task = dl.getDownload(downloadStartRequest.url.toString());

                  task?.status.addListener(() {
                    print(task.status.value);
                    print("littu");
                  });

                  task?.progress.addListener(() {
                    print(task.progress.value);
                  });

                  await dl.whenDownloadComplete(downloadStartRequest.url.toString());


                  DownloadStartRequest(url: downloadStartRequest.url,contentLength: 10);
                },
              onDownloadStart: (controller, url) async {
                // DownloadTask task = await DownloadStartRequest.enqueue(
                //   url: url.toString(),
                //   headers: {"User-Agent": controller.settings.userAgent},
                //   savedDir: "/storage/emulated/0/Download",
                //   showNotification: true,
                //   openFileFromNotification: true,
                // );

                var dl = DownloadManager();
                dl.addDownload(url.path, "/storage/emulated/0/Download");

                DownloadTask? task = dl.getDownload(url.toString());

                task?.status.addListener(() {
                  print(task.status.value);
                  print("littu");
                });

                task?.progress.addListener(() {
                  print(task.progress.value);
                });

                await dl.whenDownloadComplete(url.toString());

              },

              androidOnPermissionRequest: (controller, origin, resources) async {
                Map<Permission, PermissionStatus> statuses = await [
                Permission.location,
                Permission.locationWhenInUse,
                Permission.locationAlways,
                Permission.notification,
                Permission.accessNotificationPolicy
                // Add more permissions as needed
                ].request();
                statuses.forEach((permission, status) {
                  if (!status.isGranted) {
                    // Handle denied permissions
                  }

                });

              },

              // pullToRefreshController: PullToRefreshController(
              //   onRefresh: () {
              //     setState(() {
              //       isLoading = true;
              //       loadData();
              //     });
              //
              //   },
              // ),

            ),
          ),
        ));
  }


}
