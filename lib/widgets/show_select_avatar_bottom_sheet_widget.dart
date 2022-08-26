import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_punter/states/punters_state_controller.dart';

import '../states/audience_state_controller.dart';

class ShowSelectAvatarBottomSheetWidget {
  static void showSelectAvatarBottomSheet(String userRole) {
    Get.bottomSheet(
        Container(
          height: 170.0,
          width: Get.width,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //  Title.
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 3.0,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),

                    const Text(
                      'Choose photo from',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color.fromRGBO(11, 64, 71, 0.8),
                        fontSize: 14.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    //  Profile
                    ListTile(
                      onTap: () {
                        (userRole == "Audience")
                        ? ({
                          Get.find<AudienceStateController>().takePicture(ImageSource.camera),
                        })
                        : ({
                          Get.find<PunterStateController>().takePicture(ImageSource.camera),
                        });
                        Get.back() ;//  To Automatically Close the BottomSheet.
                      },
                      leading: const Icon(
                        Iconsax.camera,
                        color: Color.fromRGBO(11, 64, 71, 0.8),
                        size: 22.0,
                      ),
                      title: const Text(
                        "Camera",
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
                        Get.find<AudienceStateController>().takePicture(ImageSource.gallery);
                        Get.back(); //  To Automatically Close the BottomSheet.
                      },
                      leading: const Icon(
                        Iconsax.gallery,
                        color: Color.fromRGBO(11, 64, 71, 0.8),
                        size: 22.0,
                      ),
                      title: const Text(
                        "Gallery",
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
              ),
            ],
          ),
        ));
  }
}