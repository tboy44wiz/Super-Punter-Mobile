
import 'package:get/get.dart';

class SettingsStateController extends GetxController {

  //  Terms & Privacy Screen Variables.
  String _selectedTab = 'Terms';

  /*
  * Getters
  * */
  String get selectedTab => _selectedTab;


  /*
  * Setters
  * */
  void updateSelectedTab(String value) {
    _selectedTab = value;
    update();
  }
}