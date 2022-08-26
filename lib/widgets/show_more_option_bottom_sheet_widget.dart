import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:super_punter/states/audience_state_controller.dart';
import 'package:super_punter/states/punters_state_controller.dart';

import '../routes/app_routes/app_route_names.dart';


class ShowMoreOptionBottomSheetWidget {

  static void showMoreOptionBottomSheet (String userRole) {
    Get.bottomSheet(
      Container(
        height: 250.0,
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            //  Title.
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    height: 3.0,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),

            Expanded(
              flex: 12,
              child: Column(
                children: [
                  //  Profile
                  ListTile(
                    onTap: () {
                      Get.back();
                      (userRole == "Audience") ? (
                          Get.toNamed(audienceProfileScreen)
                      ) : (
                          Get.toNamed(punterProfileScreen)
                      );
                    },
                    leading: const Icon(
                      Iconsax.frame_1,
                      color: Color.fromRGBO(11, 64, 71, 0.8),
                      size: 22.0,
                    ),
                    title: const Text(
                      "Profile",
                      style: TextStyle(
                          color: Color.fromRGBO(11, 64, 71, 0.8),
                          fontSize: 16.0
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    horizontalTitleGap: 0.0,
                  ),

                  //  About Super Punter
                  ListTile(
                    onTap: () {
                      Get.back();
                      Get.toNamed(aboutSuperPunterScreen);
                    },
                    leading: const Icon(
                      Iconsax.info_circle,
                      color: Color.fromRGBO(11, 64, 71, 0.8),
                      size: 22.0,
                    ),
                    title: const Text(
                      "About SuperPunters",
                      style: TextStyle(
                          color: Color.fromRGBO(11, 64, 71, 0.8),
                          fontSize: 16.0
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    horizontalTitleGap: 0.0,
                  ),

                  //  Terms & Conditions
                  ListTile(
                    onTap: () {
                      Get.back();
                      Get.toNamed(termsAndPrivacyScreen);
                    },
                    leading: const Icon(
                      Iconsax.warning_2,
                      color: Color.fromRGBO(11, 64, 71, 0.8),
                      size: 22.0,
                    ),
                    title: const Text(
                      "Terms & Conditions",
                      style: TextStyle(
                          color: Color.fromRGBO(11, 64, 71, 0.8),
                          fontSize: 16.0
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    horizontalTitleGap: 0.0,
                  ),

                  //  Theme
                  /*ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Iconsax.sun_1,
                      color: Color.fromRGBO(11, 64, 71, 0.8),
                      size: 22.0,
                    ),
                    title: const Text(
                      "Theme",
                      style: TextStyle(
                          color: Color.fromRGBO(11, 64, 71, 0.8),
                          fontSize: 16.0
                      ),
                    ),
                    trailing: const Icon(
                      Iconsax.toggle_on_circle,
                      color: Color.fromRGBO(11, 64, 71, 0.8),
                      size: 22.0,
                    ),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    horizontalTitleGap: 0.0,
                  ),*/

                  const Divider(),

                  //  Logout
                  ListTile(
                    onTap: () {
                      Get.back();
                      (userRole == "Audience") ? (
                          Get.find<AudienceStateController>().logoutAudience()
                      ) : (
                          Get.find<PunterStateController>().logoutPunter()
                      );
                    },
                    leading: const Icon(
                      Iconsax.logout,
                      color: Color.fromRGBO(11, 64, 71, 0.8),
                      size: 22.0,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                          color: Color.fromRGBO(11, 64, 71, 0.8),
                          fontSize: 16.0
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    horizontalTitleGap: 0.0,
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}