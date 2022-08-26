import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:super_punter/screens/podcasts/favorite_podcast_screen.dart';

import '../../states/audience_state_controller.dart';
import '../../widgets/app_snackBar_widget.dart';
import '../../widgets/show_more_option_bottom_sheet_widget.dart';
import '../notification/notification_list_screen.dart';
import 'audience_home_screen.dart';

class AudienceMainScreen extends StatelessWidget {
  AudienceMainScreen({Key? key}) : super(key: key);

  final AudienceStateController _audienceStateController = Get.put(AudienceStateController());
  final AppSnackBar _appSnackBar = AppSnackBar();

  final List<Widget> individualsWidgetScreensList = [
    AudienceHomeScreen(),
    const FavoritePodcastScreen(),
    NotificationListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //  Body.
      body: DoubleBackToCloseApp(
        snackBar: _appSnackBar.snackBar('Tap back again to exit the app.', 'Info'),
        child: GetBuilder<AudienceStateController>(builder: (controller) {
          // return individualsWidgetScreensList[controller.selectedBottomNavigationBarIndex];
          return individualsWidgetScreensList[controller.selectedBottomNavigationBarIndex];
        }),
      ),

      //  Bottom Navigation Bar.
      bottomNavigationBar: GetBuilder<AudienceStateController>(builder: (controller) {
        return BottomAppBar(
          child: SizedBox(
            height: 60.0,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //  Home
                TextButton(
                  onPressed: () {
                    controller.updateSelectedBottomNavigationBarIndex(0);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.home,
                        color: (controller.selectedBottomNavigationBarIndex == 0) ?
                        const Color.fromRGBO(11, 64, 71, 0.9) :
                        Colors.grey,
                      ),
                      const SizedBox(height: 5.0),

                      Container(
                        height: 4.0,
                        width: 4.0,
                        decoration: BoxDecoration(
                          color: (controller.selectedBottomNavigationBarIndex == 0) ?
                          const Color.fromRGBO(11, 64, 71, 0.9) :
                          Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ],
                  ),
                ),

                //  Favorite
                TextButton(
                  onPressed: () {
                    controller.updateSelectedBottomNavigationBarIndex(1);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.heart, size: 24.0,
                        color: (controller.selectedBottomNavigationBarIndex == 1) ?
                        const Color.fromRGBO(11, 64, 71, 0.9) :
                        Colors.grey,
                      ),
                      const SizedBox(height: 5.0),

                      Container(
                        height: 4.0,
                        width: 4.0,
                        decoration: BoxDecoration(
                          color: (controller.selectedBottomNavigationBarIndex == 1) ?
                          const Color.fromRGBO(11, 64, 71, 0.9) :
                          Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ],
                  ),
                ),

                //  Notification
                TextButton(
                  onPressed: () {
                    controller.updateSelectedBottomNavigationBarIndex(2);
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Icon(
                            Iconsax.notification,
                            color: (controller.selectedBottomNavigationBarIndex == 2) ?
                            const Color.fromRGBO(11, 64, 71, 0.9) :
                            Colors.grey,
                          ),
                          Positioned(
                            top: 1.0,
                            right: 4.0,
                            child: Visibility(
                              visible: false,
                              child: Container(
                                height: 7.0,
                                width: 7.0,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.5),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5.0),

                      Container(
                        height: 4.0,
                        width: 4.0,
                        decoration: BoxDecoration(
                          color: (controller.selectedBottomNavigationBarIndex == 2) ?
                          const Color.fromRGBO(11, 64, 71, 0.9) :
                          Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ],
                  ),
                ),

                //  More
                TextButton(
                  onPressed: () {
                    ShowMoreOptionBottomSheetWidget.showMoreOptionBottomSheet("Audience");
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.more_vert,
                        color: (controller.selectedBottomNavigationBarIndex == 3) ?
                        const Color.fromRGBO(11, 64, 71, 0.9) :
                        Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
