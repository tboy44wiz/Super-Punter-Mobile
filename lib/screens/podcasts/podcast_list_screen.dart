import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:super_punter/states/podcast_state_controller.dart';

import '../../routes/app_routes/app_route_names.dart';
import '../../states/audience_state_controller.dart';
import '../../states/punters_state_controller.dart';


class PodcastListScreen extends StatelessWidget {
  PodcastListScreen({Key? key}) : super(key: key);

  final AudienceStateController _audienceStateController = Get.find<AudienceStateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  App Bar
      appBar: AppBar(
        // backgroundColor: Colors.grey[100],
        backgroundColor: Colors.white10,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        flexibleSpace: Container(
          height: 100.0,
          padding: const EdgeInsets.only(top: 50.0, left: 5.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.black54,
                  icon: const Icon(Iconsax.arrow_left),
                  padding: const EdgeInsets.all(0.0),
                  iconSize: 24.0,
                ),
              ),

              Text(
                (Get.parameters['from'] == "UpComing")
                    ? "Upcoming Games"
                    : "Top Rated",
                style: const TextStyle(
                  color: Color.fromRGBO(11, 64, 71, 0.8),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 40.0,
                width: 40.0,
              ),
            ],
          ),
        ),
      ),

      //  Body
      body: GetBuilder<PodcastStateController>(builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white54,
            child: (Get.parameters['from'] == "UpComing")
                ? GridView.builder(
                    itemCount: controller.upcomingPodcasts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                    ),
                    padding: const EdgeInsets.all(20.0),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          controller.handleIsPodcastIconLiked(
                            _audienceStateController.user.id,
                            controller.upcomingPodcasts[index],
                          );
                          controller.updateViewCounter(int.parse(controller.upcomingPodcasts[index].viewsCount!));
                          Get.toNamed(podcastDetailScreen);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 3.0,
                              shadowColor: Colors.black38,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                height: 100.0,
                                width: 180.0,
                                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 9.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: NetworkImage(controller.upcomingPodcasts[index].featuredImageFile!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 22,
                                      width: 52,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Colors.white
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "./assets/images/sound_wave.png",
                                            height: 11.0,
                                          ),
                                          Text(
                                            controller.upcomingPodcasts[index].duration!,
                                            style: const TextStyle(
                                              color: Color.fromRGBO(11, 64, 71, 0.8),
                                              fontSize: 12.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      padding: const EdgeInsets.only(left: 2.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Colors.white
                                      ),
                                      child: const Icon(
                                        Iconsax.play,
                                        color: Color(0xff06353C),
                                        size: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                controller.upcomingPodcasts[index].title!,
                                style: const TextStyle(
                                  color: Color.fromRGBO(11, 64, 71, 0.8),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    itemCount: controller.topRatedPodcasts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                    ),
                    padding: const EdgeInsets.all(20.0),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          controller.handleIsPodcastIconLiked(
                            _audienceStateController.user.id,
                            controller.topRatedPodcasts[index],
                          );
                          controller.updateViewCounter(int.parse(controller.topRatedPodcasts[index].viewsCount!));
                          Get.toNamed(podcastDetailScreen);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 3.0,
                              shadowColor: Colors.black38,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                height: 100.0,
                                width: 180.0,
                                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 9.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: NetworkImage(controller.topRatedPodcasts[index].featuredImageFile!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 22,
                                      width: 52,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Colors.white
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "./assets/images/sound_wave.png",
                                            height: 11.0,
                                          ),
                                          Text(
                                            controller.topRatedPodcasts[index].duration!,
                                            style: const TextStyle(
                                              color: Color.fromRGBO(11, 64, 71, 0.8),
                                              fontSize: 12.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      padding: const EdgeInsets.only(left: 2.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Colors.white
                                      ),
                                      child: const Icon(
                                        Iconsax.play,
                                        color: Color(0xff06353C),
                                        size: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                controller.topRatedPodcasts[index].title!,
                                style: const TextStyle(
                                  color: Color.fromRGBO(11, 64, 71, 0.8),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          );
        }
      ),
    );
  }
}
