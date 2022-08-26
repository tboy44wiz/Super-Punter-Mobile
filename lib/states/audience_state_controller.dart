import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:super_punter/models/user_model.dart';

import '../routes/api_routes/api_route_names.dart';
import '../routes/app_routes/app_route_names.dart';
import '../services/api_service.dart';
import '../widgets/app_snackBar_widget.dart';
import '../widgets/app_toast_widget.dart';

class AudienceStateController extends GetxController {

  int _selectedBottomNavigationBarIndex = 0;
  final List<String> _sportTypeList = ["All", "Basketball", "Baseball", "Boxing", "Car Racing", "Football", "etc"];

  //  Profile Data
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _phoneTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  String _email = "";
  bool _isEditUser = false;
  bool _hidePassword = true;
  bool _isLoading = false;
  File? _pickedFile;
  final ImagePicker _imagePicker = ImagePicker();
  User _user = User();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final AppSnackBar _appSnackBar = AppSnackBar();
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  final AppToastWidget _appToastWidget = AppToastWidget();

  /*
  * GETTERS
  * */
  int get selectedBottomNavigationBarIndex => _selectedBottomNavigationBarIndex;

  //  Profile Data
  TextEditingController get nameTextEditingController => _nameTextEditingController;
  TextEditingController get emailTextEditingController => _emailTextEditingController;
  TextEditingController get phoneTextEditingController => _phoneTextEditingController;
  TextEditingController get passwordTextEditingController => _passwordTextEditingController;
  String get email => _email;
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
  void updateEmail(String value) {
    _email = value;
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
    String? _userData = await _flutterSecureStorage.read(key: "loggedInUser");

    if (_userData!.isNotEmpty) {
      Map<String, dynamic> _decodedUSerData = jsonDecode(_userData);
      return updateUserModel(User.fromMap(_decodedUSerData));
    }
  }

  void updateAllTextEditingControllers() {
    _nameTextEditingController.text = _user.name!;
    _emailTextEditingController.text = _user.email!;
    _phoneTextEditingController.text = _user.phone!;
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
    Map<String, dynamic> updateData = {
      "name": _nameTextEditingController.text,
      "phone": _phoneTextEditingController.text,
      "email": _emailTextEditingController.text,
      // "password": _passwordTextEditingController.text,
    };
    // print("KKKKKKK::: $updateData");

    var response = await APIService.updateUserService(updateUserRoute, updateData, _user.id!, _user.token!);
    bool isSuccess = response!.data["success"];
    // print(response);

    if (isSuccess) {
      updateIsLoading(false);
      updateIsEditUser(false);

      String responseMessage = response.data["message"];
      Map<String, dynamic> userData = response.data["data"];
      String _encodedUserData = jsonEncode(userData);
      await _flutterSecureStorage.write(key: "loggedInUser", value: _encodedUserData);
      updateUserModel(User.fromMap(userData));

      _appToastWidget.elegantNotification(response.data["message"], "Success");
      if (_user.isVerified!) {
        return Get.toNamed(audienceProfileScreen);
      }
      return Get.toNamed(verifyOTPScreen, parameters: {
        "responseMessage" : responseMessage,
      });
    } else {
      updateIsLoading(false);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          _appSnackBar.snackBar("Ooops!!! ${response.data['message']}", "Error")
      );
    }
  }

  //  Delete User.
  Future<void> deleteUser() async {
    if (_email != _user.email) {
       return MotionToast.error(
         height: 50.0,
         width:  300.0,
         description: const Text("Email not valid. Please put your correct email address."),
         borderRadius: 5.0,
         toastDuration: const Duration(seconds: 4),
       ).show(Get.context!);
    }
    updateIsLoading(true);

    var response = await APIService.deleteUserService(deleteUserRoute, _user.id!, _user.token!);
    bool isSuccess = response!.data["success"];
    // print(response);

    if (isSuccess) {
      updateIsLoading(false);
      return Get.offAllNamed(loginScreen);
    } else {
      updateIsLoading(false);

      return MotionToast.error(
        height: 50.0,
        width:  300.0,
        description: Text("Ooops!!! ${response.data['message']}"),
        borderRadius: 5.0,
        toastDuration: const Duration(seconds: 4),
      ).show(Get.context!);
    }
  }


  //  Logout Audience.
  void logoutAudience() async {
    await _flutterSecureStorage.delete(key: 'loggedInUser');

    //  Return to the Login Screen.
    Get.offNamed(loginScreen);
  }
}
