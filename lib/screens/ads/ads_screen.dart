import 'dart:async';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_punter/routes/app_routes/app_route_names.dart';
import 'package:super_punter/states/ads_state_controller.dart';
import 'package:super_punter/states/auth_state_controller.dart';

import '../../widgets/app_snackBar_widget.dart';

class AdsScreen extends StatelessWidget {
  AdsScreen({Key? key}) : super(key: key);

  final AdsStateController _adsStateController = Get.put(AdsStateController());
  final AppSnackBar _appSnackBar = AppSnackBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //  Body.
      body: DoubleBackToCloseApp(
        snackBar: _appSnackBar.snackBar('Tap back again to exit the app.', 'Info'),
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.only(
            left: 40.0,
            top: 30.0,
            right: 40.0,
            bottom: 70.0,
          ),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/ads_image.png"),
                  fit: BoxFit.cover
              )
          ),
          child: const Center(
            child: Text(
              "Motion Ads",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
