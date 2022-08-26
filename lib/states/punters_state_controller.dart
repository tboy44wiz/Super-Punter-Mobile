import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import '../models/user_model.dart';
import '../routes/api_routes/api_route_names.dart';
import '../routes/app_routes/app_route_names.dart';
import '../services/api_service.dart';
import '../widgets/app_toast_widget.dart';

import 'package:http/http.dart' as http;

class PunterStateController extends GetxController {

  int _selectedBottomNavigationBarIndex = 0;
  final List<String> _sportTypeList = ["All", "Basketball", "Baseball", "Boxing", "Car Racing", "Football", "etc"];
  List<Map<String, dynamic>> _topRatedList = [
    {
      "adsImage": "./assets/images/podcast_one.png",
      "sportType": "Soccer",
      "sportName": "EPL",
      "contenders": "Chelsea vs Liverpool",
      "duration": "23:10",
      "views": "2.6",
    },
    {
      "adsImage": "./assets/images/podcast_two.png",
      "sportType": "Soccer",
      "sportName": "LaLiga",
      "contenders": "Sevilla Vs Barcelona",
      "duration": "23:10",
      "views": "1.9",
    }
  ];

  //  Profile Data
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _phoneTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  bool _isEditUser = false;
  bool _hidePassword = true;
  bool _isLoading = false;
  File? _pickedFile;
  final ImagePicker _imagePicker = ImagePicker();

  final AppToastWidget _appToastWidget = AppToastWidget();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  User _user = User();
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();

  /*
  * GETTERS
  * */
  int get selectedBottomNavigationBarIndex => _selectedBottomNavigationBarIndex;
  List<String> get sportTypeList => _sportTypeList;
  List<Map<String, dynamic>> get topRatedList => _topRatedList;

  //  Profile Data
  TextEditingController get nameTextEditingController => _nameTextEditingController;
  TextEditingController get emailTextEditingController => _emailTextEditingController;
  TextEditingController get phoneTextEditingController => _phoneTextEditingController;
  TextEditingController get passwordTextEditingController => _passwordTextEditingController;
  bool get isEditUser => _isEditUser;
  bool get hidePassword => _hidePassword;
  bool get isLoading => _isLoading;
  File? get pickedFile => _pickedFile;

  AutovalidateMode get autoValidateMode => _autoValidateMode;
  User get user => _user;
  FlutterSecureStorage get flutterSecureStorage => _flutterSecureStorage;



  /*
  * SETTERS
  * */
  void updateSelectedBottomNavigationBarIndex(int index) {
    _selectedBottomNavigationBarIndex = index;
    update();
  }
  void updateTopRatedList(List<Map<String, dynamic>> topRatedList) {
    _topRatedList = topRatedList;
    update();
  }
  void updateIsEditUser(bool value) {
    _isEditUser = value;
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
  void updateUserModel(User userValue) {
    _user = userValue;
    update();
  }





  void getUserData() async {
    var _userData = await _flutterSecureStorage.read(key: "loggedInUser");

    if (_userData != null) {
      Map<String, dynamic> _decodedUSerData = jsonDecode(_userData);

      return updateUserModel(User.fromMap(_decodedUSerData));
    }
  }

  void updateAllTextEditingControllers() {
    _nameTextEditingController.text = _user.name!;
    _emailTextEditingController.text = _user.email!;
    (_user.phone != null) ? _phoneTextEditingController.text = _user.phone! : _phoneTextEditingController.text = "";
    _passwordTextEditingController.text = "";
  }

  //  Take a picture.
  Future<void> takePicture(ImageSource imageSource) async {
    try {
      final image = await _imagePicker.pickImage(
        source: imageSource,
        maxHeight: 600.0,
        maxWidth: 600.0,
        imageQuality: 80,
      );
      if (image != null) {
        // Note: The "image" is type "XFile" and need to be made type "File" as did below.
        _pickedFile = File(image.path);
        return update();
      }
      _appToastWidget.elegantNotification("No image selected.", "Error");
    } on PlatformException catch (e) {
      throw Exception(e);
    }
  }

  //  Update User.
  Future<void> updateUser() async {
    updateIsLoading(true);
    Map<String, dynamic> updateData = (_phoneTextEditingController.text != "" && _passwordTextEditingController.text != "") ?
    {
      "name": _nameTextEditingController.text,
      "phone": _phoneTextEditingController.text,
      "password": _passwordTextEditingController.text,
    } : (_phoneTextEditingController.text != "") ? {
      "name": _nameTextEditingController.text,
      "phone": _phoneTextEditingController.text,
    } : (_passwordTextEditingController.text != "") ? {
      "name": _nameTextEditingController.text,
      "password": _passwordTextEditingController.text,
    } : {
      "name": _nameTextEditingController.text,
    };

    var response = await APIService.updateUserService(updateUserRoute, updateData, _user.id!, _user.token!);
    bool isSuccess = response!.data["success"];
    // print(response);

    if (isSuccess) {
      updateIsLoading(false);
      updateIsEditUser(false);

      Map<String, dynamic> userData = response.data["data"];
      String _encodedUserData = jsonEncode(userData);
      await _flutterSecureStorage.write(key: "loggedInUser", value: _encodedUserData);
      updateUserModel(User.fromMap(userData));

      Get.toNamed(punterProfileScreen);
      _appToastWidget.elegantNotification(response.data["message"], "Success");
    } else {
      updateIsLoading(false);
      MotionToast.success(
        height: 50.0,
        width:  300.0,
        description: Text("Ooops!!! ${response.data['message']}"),
        borderRadius: 5.0,
        toastDuration: const Duration(seconds: 15),
      ).show(Get.context!);
    }
  }



  //  Logout Punter.
  void logoutPunter() async {
    await _flutterSecureStorage.delete(key: 'loggedInUser');

    //  Return to the Login Screen.
    Get.offNamed(loginScreen);
  }
}