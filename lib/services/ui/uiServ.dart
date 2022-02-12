import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showAlert(context, title, message, button) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context, false), // passing false
              child: Text(button),
            ),
          ],
        );
      });
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade800,
      textColor: Colors.white,
      fontSize: 16.0);
}
