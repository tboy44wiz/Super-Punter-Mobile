import 'package:flutter/material.dart';

class AppSnackBar {
  //  Custom SnackBar.
  SnackBar snackBar(String message, String messageType) {
    return SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: (messageType == 'Success') ?
      (Colors.green[200]) :
      (messageType == 'Error') ?
      (Colors.red[200]) :
      (Colors.blue[200]),
    );
  }
}
