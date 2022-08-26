import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';

class AppToastWidget {
  elegantNotification(String message, String messageType) {
   return ElegantNotification(
      icon: Icon(
        (messageType == "Success")
            ? Icons.task_alt
            : (messageType == "Warning")
            ? Icons.warning_amber
            : (messageType == "Error")
            ? Icons.cancel_outlined //warning_2
            : Icons.info_outline,
        color: (messageType == "Success")
            ? const Color.fromRGBO(1, 93, 8, 1.0)
            : (messageType == "Warning")
            ? const Color.fromRGBO(255, 90, 4, 1.0)
            : (messageType == "Error")
            ? const Color.fromRGBO(255, 22, 22, 1.0)
            : const Color.fromRGBO(0, 56, 162, 1.0),
      ),
      height: 60.0,
      description: Text(
        message,
        style: TextStyle(
          color:  (messageType == "Success")
              ? const Color.fromRGBO(1, 93, 8, 1.0)
              : (messageType == "Warning")
              ? const Color.fromRGBO(255, 90, 4, 1.0)
              : (messageType == "Error")
              ? const Color.fromRGBO(255, 22, 22, 1.0)
              : const Color.fromRGBO(0, 56, 162, 1.0),
          fontSize: 14.0,
        ),
      ),
      background: (messageType == "Success")
          ? (Colors.green[200]!)
          : (messageType == "Warning")
          ? (Colors.orangeAccent[100]!)
          : (messageType == "Error")
          ? (Colors.red[200]!)
          : (Colors.blue[200]!),
      notificationPosition: NOTIFICATION_POSITION.bottom,
      dismissible: true,
      displayCloseButton: false,
      showProgressIndicator: false,
      toastDuration: const Duration(seconds: 5),
    ).show(Get.context!);
  }
}