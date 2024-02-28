import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class LoginActivity extends StatefulWidget {
  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late String _deviceId;
  late String _tokenId;
  late String _deviceDetails;
  late bool _passwordVisible;
  late bool _exit;

  final RegExp _emailPattern = RegExp(
      r'^([\w.\-]+)@([\w\-]+)((\.(\w){2,63}){1,3})$'
  );

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVisible = false;
    _exit = false;
    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    try {
      String deviceId = await PlatformDeviceId.getDeviceId();
      setState(() {
        _deviceId = deviceId;
      });
    } on PlatformException {
      setState(() {
        _deviceId = 'Failed to get device id.';
      });
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    // Implement your login logic here
    // Example of sending a HTTP request
    try {
      final response = await http.post(
        Uri.parse('https://erp.gengroup.in/ci/app/auth/login'),
        body: {
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
          'deviceId': _deviceId,
          'tokenId': _tokenId,
          'deviceDetails': _deviceDetails,
        },
      );

      // Handle response
      if (response.statusCode == 200) {
        // Successful login
        print("Success");
      } else {
        // Handle other status codes
        print("fail");
      }
    } catch (e) {
      // Handle exceptions
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleBackPressed() async {
    if (_exit) {
      exit(0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Press back again to exit from the app.'),
        ),
      );
      setState(() {
        _exit = true;
      });
      Timer(Duration(seconds: 3), () {
        setState(() {
          _exit = false;
        });
      });
    }
  }
}

class PlatformDeviceId {
  static const MethodChannel _channel =
  MethodChannel('plugins.flutter.io/device_id');

  static Future<String> getDeviceId() async {
    final String deviceId = await _channel.invokeMethod('getDeviceId');
    return deviceId;
  }
}
