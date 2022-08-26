import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../states/notification_state_controller.dart';

class NotificationListScreen extends StatelessWidget {
  NotificationListScreen({Key? key}) : super(key: key);

  final NotificationStateController _notificationStateController = Get.put(NotificationStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  App Bar
      appBar: AppBar(
        // backgroundColor: Colors.grey[100],
        backgroundColor: Colors.white10,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        flexibleSpace: Container(
          height: 100.0,
          padding: const EdgeInsets.only(top: 50.0, left: 5.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(
                height: 40.0,
                width: 40.0,
              ),

              Text(
                "Notification",
                style: TextStyle(
                  color: Color.fromRGBO(11, 64, 71, 0.8),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 40.0,
                width: 40.0,
              ),
            ],
          ),
        ),
      ),

      //  Body.
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/notification_image.png",
              height: 120.0,
              // width: 70.0,
            ),
            const SizedBox(height: 20.0),

            const Text(
              "No notification yet",
              style: TextStyle(
                color: Color.fromRGBO(99, 162, 166, 0.76),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),

            const Text(
              "When you get notifications, they will show up \n here.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(99, 162, 166, 0.76),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
