import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

import '../models/user_model.dart';
import '../routes/api_routes/api_route_names.dart';
import '../routes/app_routes/app_route_names.dart';
import '../services/api_service.dart';
import '../widgets/app_snackBar_widget.dart';
import '../widgets/app_toast_widget.dart';
import './audience_state_controller.dart';


class AuthStateController extends GetxController {

  String _name = "";
  String _phone = "";
  String _email = "";
  String _password = "";
  final String _role = "Users";
  String _otp = "";
  bool _hidePassword = true;
  bool _isLoading = false;

  User _user = User();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final AppSnackBar _appSnackBar = AppSnackBar();
  final AppToastWidget _appToastWidget = AppToastWidget();
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();

  final AudienceStateController _audienceStateController = Get.put(AudienceStateController());


  /*
  * GETTERS
  * */
  String get name => _name;
  String get phone => _phone;
  String get email => _email;
  String get password => _password;
  String get role => _role;
  String get otp => _otp;
  bool get hidePassword => _hidePassword;
  bool get isLoading => _isLoading;
  User get user => _user;

  AutovalidateMode get autoValidateMode => _autoValidateMode;
  FlutterSecureStorage get flutterSecureStorage => _flutterSecureStorage;


  /*
  * SETTERS
  * */
  void updateName(String value) {
    _name = value;
    update();
  }
  void updatePhone(String value) {
    _phone = value;
    update();
  }
  void updateEmail(String value) {
    _email = value;
    update();
  }
  void updatePassword(String value) {
    _password = value;
    update();
  }
  /*void updateRole(String value) {
    _role = value;
    update();
  }*/
  void updateOTP(String value) {
    _otp = value;
    update();
  }
  void updateHidePassword() {
    _hidePassword = !_hidePassword;
    update();
  }
  void updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }
  void updateAutoValidateMode() {
    _autoValidateMode = AutovalidateMode.onUserInteraction;
    update();
  }
  void updateUser(User userValue) {
    _user = userValue;
    update();
  }



  @override
  void onInit() {
    // TODO: implement onInit
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

    });
    super.onInit();
  }



  //  Login User.
  Future<void> loginUser() async {
    updateIsLoading(true);
    Map<String, dynamic> loginData = {
      "email": _email,
      "password": _password,
    };
    var response = await APIService.loginUserService(loginUserRoute, loginData);
    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);

      Map<String, dynamic> userData = response.data["data"];
      String _encodedUserData = jsonEncode(userData);

      //  Save to Flutter Secure Storage
      await _flutterSecureStorage.write(key: "loggedInUser", value: _encodedUserData);

      Get.offAndToNamed(adsScreen);
    } else {
      updateIsLoading(false);
      String responseMessage = response.data["message"];
      MotionToast.error(
        height: 50.0,
        width:  300.0,
        description: Text("Ooops!!! $responseMessage"),
        borderRadius: 5.0,
        toastDuration: const Duration(seconds: 4),
      ).show(Get.context!);
    }
  }


  //  Signup User.
  Future<void> signupUser() async {
    updateIsLoading(true);
    Map<String, dynamic> signupData = {
      "name": _name,
      "email": _email,
      "password": _password,
      "role": _role
    };
    var response = await APIService.signupUserService(signUpUserRoute, signupData);
    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);
      Map<String, dynamic> userData = response.data["data"];
      String _encodedUserData = jsonEncode(userData);

      //  Save to Flutter Secure Storage and USer Model
      await _flutterSecureStorage.write(key: "loggedInUser", value: _encodedUserData);
      updateUser(User.fromMap(userData));

      String responseMessage = response.data["message"];
      Get.toNamed(verifyOTPScreen, parameters: {
        "responseMessage" : responseMessage,
      });
    } else {
      updateIsLoading(false);
      String responseMessage = response.data["message"];
      MotionToast.error(
        height: 50.0,
        width:  300.0,
        description: Text("Ooops!!! $responseMessage"),
        borderRadius: 5.0,
        toastDuration: const Duration(seconds: 5),
      ).show(Get.context!);
    }
  }

  //  Send User Verification OTP.
  Future<void> sendVerificationOTP() async {
    updateIsLoading(true);

    String? _userData = await _flutterSecureStorage.read(key: "loggedInUser");
    if (_userData!.isNotEmpty) {
      Map<String, dynamic> _decodedUSerData = jsonDecode(_userData);
      updateUser(User.fromMap(_decodedUSerData));
    }

    Map<String, dynamic> otpData = {
      "name": _user.name,
      "email": _user.email,
    };

    var response = await APIService.sendVerificationOTPService(sendVerificationOTPRoute, otpData);
    bool isSuccess = response!.data["success"];
    // print("USER DATA::: $response");

    if (isSuccess) {
      updateIsLoading(false);
      String responseMessage = response.data["message"];

      Get.toNamed(verifyOTPScreen, parameters: {
        "responseMessage" : responseMessage,
      });
      MotionToast.success(
        height: 80.0,
        width:  300.0,
        description: Text(responseMessage),
        borderRadius: 5.0,
        toastDuration: const Duration(seconds: 4),
      ).show(Get.context!);
    } else {
      updateIsLoading(false);
      String responseMessage = response.data["message"];
      MotionToast.error(
        height: 50.0,
        width:  300.0,
        description: Text("Ooops!!! $responseMessage"),
        borderRadius: 5.0,
        toastDuration: const Duration(seconds: 4),
      ).show(Get.context!);
    }

  }

  //  Verify OTP.
  Future<void> verifyOTPs() async {
    updateIsLoading(true);
    Map<String, dynamic> otpData = {
      "email": _user.email!,
      "otp": _otp,
    };

    var response = await APIService.verifyOTPService(verifyOTPRoute, _user.id!, otpData, _user.token!);
    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);

      Map<String, dynamic> userData = response.data["data"];
      String _encodedUserData = jsonEncode(userData);

      //  Save to Flutter Secure Storage
      await _flutterSecureStorage.write(key: "loggedInUser", value: _encodedUserData);
      // print(userData);

      String responseMessage = response.data["message"];
      if (userData["role"] == "Audience") {
        Get.offNamed(audienceMainScreen);
      } else {
        Get.offNamed(punterHomeScreen);
      }
      MotionToast.success(
        height: 50.0,
        width:  300.0,
        description: Text(responseMessage),
        borderRadius: 5.0,
        toastDuration: const Duration(seconds: 4),
      ).show(Get.context!);
    } else {
      updateIsLoading(false);
      String responseMessage = response.data["message"];
      MotionToast.error(
        height: 50.0,
        width:  300.0,
        description: Text("Ooops!!! $responseMessage"),
        borderRadius: 5.0,
        toastDuration: const Duration(seconds: 4),
      ).show(Get.context!);
    }

  }
}