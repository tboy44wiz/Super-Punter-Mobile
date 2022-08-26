import 'dart:async';

import 'package:get/get.dart';

class SplashStateController extends GetxController {

  @override
  void onInit() {
    super.onInit();

    startTimer();
  }

  Timer startTimer() {

    Duration duration = const Duration(seconds: 4);
    return Timer(duration, () {
      //  TODO
    });
  }
}