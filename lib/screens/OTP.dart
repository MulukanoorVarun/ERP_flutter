import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';

class OTPDisplay extends StatefulWidget {
  @override
  _OTPDisplayState createState() => _OTPDisplayState();
}

class _OTPDisplayState extends State<OTPDisplay> {
  late Stream<dynamic> otpStream;
  final secretKey = 'TESTINGAPPSECRETKEY';

  @override
  void initState() {
    super.initState();
    otpStream = generateOTPStream();
    otpStream.listen((otp) {
      print('Generated OTP: $otp');
    });
  }

  Stream<dynamic> generateOTPStream() {
    return Stream<dynamic>.periodic(
      const Duration(seconds: 0),
          (val) => OTP.generateTOTPCodeString(
        secretKey,
        DateTime.now().millisecondsSinceEpoch,
        length: 6,
        interval: 30,
        algorithm: Algorithm.SHA1,
        isGoogle: true,
      ),
    ).asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: otpStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            'OTP: ${snapshot.data}',
            style: TextStyle(fontSize: 24),
          );
        } else if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
            style: TextStyle(fontSize: 24),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
