import 'dart:async';

import 'package:get/get.dart';

import '../routes/app_routes/app_route_names.dart';

class AdsStateController extends GetxController {

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();

    startTimer();
  }

  Timer startTimer() {
    var duration = const Duration(seconds: 2);
    return _timer = Timer(duration, () {
      Get.offNamed(audienceMainScreen);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer.cancel();
    Get.delete<AdsStateController>();
  }
}