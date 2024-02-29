import 'package:GenERP/Utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../Utils/ColorConstant.dart';
import '../Utils/FontConstant.dart';

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
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    main();
  }

  void main() async {
    empId = await PreferenceService().getString("UserId") ?? "";
    sessionId = await PreferenceService().getString("Session_id") ?? "";
    if (await PreferenceService().getString("redirectUrl") == null) {
      webPageUrl =
          "https://erp.gengroup.in/ci/app/home/web_erp?emp_id=$empId&session_id=$sessionId";
    } else {
      webPageUrl =
          "https://erp.gengroup.in/ci/app/home/web_erp?emp_id=$empId&session_id=$sessionId&redirect_url=${await PreferenceService().getString("redirectUrl").toString()}";
    }
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
        body: SafeArea(
          child: Container(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              // initialUrlRequest: URLRequest(
              //   url: WebUri.uri(Uri.parse(webPageUrl))
              // ),
              onLoadStart: (controller, url) {
                WebUri.uri(Uri.parse(webPageUrl));
              },
            ),
          ),
        ));
  }

}
