
import 'package:flutter/material.dart';
 


class Helpers {
  showSnackBar(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(message),
      ),
    );
  }
   AppBar appBar(BuildContext context, String title){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title:  Container(
        child: Text(title,
            style:TextStyle(
              color: Colors.orangeAccent,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            )),
      ),
      titleSpacing: 0,
      leading: Container(
        margin: EdgeInsets.only(left: 10),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24.0,
          ),
        ),
      ),
    );
   }


}
