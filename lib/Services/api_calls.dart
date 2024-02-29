
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<http.Response?> post(Map<String, dynamic> data, String urlLink,
    Map<String, String> headers) async {
  http.Response? response;
  debugPrint(DateTime.now().toString());
  try {
    response = await http.post(Uri.parse(urlLink),
        headers: headers, body: data);
    // jsonEncode(data)
    //log("Customer Response is ${response.body}");
  } catch (e) {
    debugPrint(e.toString());
  }
  //print("Post RESPONSE BODY IS ${response?.statusCode}");
  return response;
}


Future<http.Response?> get(String urlLink, Map<String, String> headers) async {
  http.Response? response;
  try {
    response = await http.get(
      Uri.parse(urlLink),
      headers: headers,
    );
  } catch (e) {
    debugPrint(e.toString());
  }
  //log("Get RESPONSE BODY IS ${response?.body}");
  return response;
}


Future<String?> postImage(Map<String, String> body, String urlLink,
    Map<String, String> headers, File image) async {
  try {
    var req = http.MultipartRequest('POST', Uri.parse(urlLink));
    req.headers.addAll(headers);
    req.files.add(await http.MultipartFile.fromPath('image', image.path));
    req.fields.addAll(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("**** $resBody .... $res");
      return resBody;
    } else {
      print("error: ${res.reasonPhrase}");
      return null;
    }
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<String?> postImage2(Map<String, String> body,Map<String, String> headers, String urlLink,
    File image) async {
  try {
    var req = http.MultipartRequest('POST', Uri.parse(urlLink));
    req.headers.addAll(headers);
    req.files.add(await http.MultipartFile.fromPath('check_in_image', image.path));
    req.fields.addAll(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("**** $resBody .... $res");
      return resBody;
    } else {
      print("error: ${res.reasonPhrase}");
      return null;
    }
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<String?> postImage3(Map<String, String> body, String urlLink,
     File itemImage) async {
  try {
    var req = http.MultipartRequest('POST', Uri.parse(urlLink));
    req.files.add(await http.MultipartFile.fromPath('check_out_image', itemImage.path));
    req.fields.addAll(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("**** $resBody .... $res");
      return resBody;
    } else {
      print("error: ${res.reasonPhrase}");
      return null;
    }
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}


Future<String?> PostMultipleImages(Map<String, String> body, String urlLink,
    Map<String, String> headers, List<http.MultipartFile> newList) async {
  try {
    var req = http.MultipartRequest('POST', Uri.parse(urlLink));
    req.headers.addAll(headers);
    req.files.addAll(newList);
    req.fields.addAll(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("**** $resBody .... $res");
      return resBody;
    } else {
      print("error: ${res.reasonPhrase}");
      return null;
    }
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
