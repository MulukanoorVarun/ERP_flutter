import 'package:flutter/material.dart';

class ColorConstant {
  static Color erp_appColor = fromHex("#011842");
  static Color edit_bg_color = fromHex("#E4EFF9");
  static Color appbardash = fromHex("#1A0D00");
  static Color scafcolor = fromHex("#F3F4FB");
  static Color buttonback = fromHex("#FFEBCC");
  static Color DarkOrange = fromHex("#FF7000");
  static Color accent_color = const Color.fromRGBO(255, 153, 0, 1.0);
  static Color black = const Color.fromRGBO(26, 13, 0, 1.0);
  static Color Fillcolor = const Color.fromRGBO(241, 242, 244, 1.0);
  static Color productlistcard = const Color.fromRGBO(255, 255, 255, 1.0);
  static Color Text = const Color.fromRGBO(132, 132, 132, 1.0);
  static Color Textfield = const Color.fromRGBO(148, 148, 148, 1.0);
  static Color accent_color_opacity = const Color.fromRGBO(245, 226, 201, 1.0);
  static Color red = const Color.fromRGBO(206, 206, 206, 1.0);
  static Color cart1kg = const Color.fromRGBO(96, 96, 96, 1.0);
  static Color Couponamount = const Color.fromRGBO(5, 111, 15, 1.0);
  static Color cartbackground = const Color.fromRGBO(243, 244, 251, 1.0);
  static Color gradient = const Color.fromRGBO(45, 129, 185, 1.0);
  static Color dusty = const Color.fromRGBO(220, 174, 150, 1.0);
  static Color yellowww = const Color.fromRGBO(45, 129, 185, 1.0);
  static Color Dikazo = const Color.fromRGBO(255, 153, 0, 1.0);
  static Color dark_font_grey = const Color.fromRGBO(62, 68, 71, 1.0);
  static Color halfWhite = const Color.fromRGBO(241, 242, 244, 1.0);
  static Color halfWhite1 = const Color.fromRGBO(241, 242, 244, 1.0); // if not sure , use the same color as accent color
  /*configurable colors ends*/
  static  Color greenfp = const Color.fromARGB(1, 18, 125, 0);
  static Color greenfps = fromHex("#127D00");

  /*If you are not a developer, do not change the bottom colors*/
  static Color white = const Color.fromRGBO(253, 252, 252, 1.0);
  static Color light_grey = const Color.fromRGBO(239,239,239, 1);
  static Color dark_grey = const Color.fromRGBO(112,112,112, 1);
  static Color medium_grey = const Color.fromRGBO(132,132,132, 1);
  static Color medium_grey_50 = const Color.fromRGBO(132,132,132, .5);
  static Color grey_153 = const Color.fromRGBO(153,153,153, 1);
  static Color bggreen = fromHex("#06590E");
  static Color font_grey = const Color.fromRGBO(73,73,73, 1);
  static Color textfield_grey = const Color.fromRGBO(209,209,209, 1);
  static Color golden = const Color.fromRGBO(248, 181, 91, 1);
  static Color shimmer_base = Colors.grey.shade50;
  static Color shimmer_highlighted = Colors.grey.shade200;
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}