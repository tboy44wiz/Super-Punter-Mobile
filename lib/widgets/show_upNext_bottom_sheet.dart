import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_punter/states/podcast_state_controller.dart';

import '../routes/app_routes/app_route_names.dart';

class ShowUpNextBottomSheet {

  static void showUpNextBottomSheet () {
    Get.bottomSheet(
      Container(
          height: Get.height / 1.4,
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
          // margin: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
            // borderRadius: BorderRadius.horizontal(left: Radius.circular(20.0), right: Radius.circular(20.0)),
            color: Colors.white,
          ),
          child: Column(
            children: [
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

              //  Up Next
              Expanded(
                flex: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Up next",
                      style: TextStyle(
                        color: Color.fromRGBO(11, 64, 71, 0.8),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),

                    GetBuilder<PodcastStateController>(builder: (controller) {
                        return SizedBox(
                          height: Get.height / 1.67,
                          child: ListView.builder(
                            itemCount: controller.upcomingPodcasts.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  String currentPodcastId = controller.podcast.id!;
                                  controller.updatePodcast(controller.upcomingPodcasts[index]);

                                  if (currentPodcastId != controller.upcomingPodcasts[index].id) {
                                    Get.back();
                                    Get.offAndToNamed(podcastDetailScreen);
                                  } else {
                                    Get.back();
                                  }
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    height: 47.0,
                                    width: 77.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(controller.upcomingPodcasts[index].featuredImageFile!),
                                      ),
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        ("${controller.upcomingPodcasts[index].contestantA!} Vs ${controller.upcomingPodcasts[index].contestantB!}".length > 25)
                                            ? "${controller.upcomingPodcasts[index].contestantA!} Vs ${controller.upcomingPodcasts[index].contestantB!}".replaceRange(25, null, "...")
                                            : "${controller.upcomingPodcasts[index].contestantA!} Vs ${controller.upcomingPodcasts[index].contestantB!}",
                                        style: const TextStyle(
                                            color: Color.fromRGBO(11, 64, 71, 0.9),
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),

                                      Container(
                                        height: 20,
                                        width: 45,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: const Color.fromRGBO(99, 162, 166, 0.16)
                                        ),
                                        child: Text(
                                          controller.upcomingPodcasts[index].leagueAbbrev!,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(11, 64, 71, 0.8),
                                            fontSize: 11.0,
                                          ),
                                          // textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: const Text(
                                    "2.9K views",
                                    style: TextStyle(
                                      color: Color.fromRGBO(11, 64, 71, 0.9),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  /*trailing: const Icon(
                                    Iconsax.arrow_right_3,
                                    color: Color.fromRGBO(11, 64, 71, 0.9),
                                  ),*/
                                ),
                              );
                            },
                          ),
                        );
                      }
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      isScrollControlled: true,
    );
  }
}