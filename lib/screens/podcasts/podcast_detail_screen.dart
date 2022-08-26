import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:super_punter/widgets/show_upNext_bottom_sheet.dart';
import 'package:video_player/video_player.dart';

import '../../states/audience_state_controller.dart';
import '../../states/podcast_state_controller.dart';
import '../../widgets/show_podcast_more_option_bottom_sheet.dart';

class PodcastDetailScreen extends StatelessWidget {
  PodcastDetailScreen({Key? key}) : super(key: key);

  final AudienceStateController _audienceStateController = Get.find<AudienceStateController>();
  final PodcastStateController _podcastStateController = Get.put(PodcastStateController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _podcastStateController.initializeVideoPlayer();
    });

    return Scaffold(
      extendBody: true,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          gradient : LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color.fromRGBO(1, 31, 44, 1),Color.fromRGBO(5, 50, 59, 1)]
          ),
        ),

        child: GetBuilder<PodcastStateController>(builder: (controller) {
          return Column(
            children: [
              const SizedBox(height: 50.0,),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (controller.mediaType == "Video")
                    ? (controller.videoPlayerController.value.isInitialized) ? (
                          AspectRatio(
                              aspectRatio: 16.0/9.0,
                              child: VideoPlayer(_podcastStateController.videoPlayerController)
                          )
                      ) : (
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                      )
                    : Image.network(controller.podcast.featuredImageFile!),
                  ],
                ),
              ),

              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0,
                      ),
                      child: Column(
                        children: [
                          //  Video Name, Punters
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        (controller.podcast.title!.length > 35)
                                        ? controller.podcast.title!.replaceRange(35, null, "...")
                                        : controller.podcast.title!,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(153, 247, 255, 1.0),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(width: 10.0,),
                                      Text(
                                        "(${controller.podcast.leagueAbbrev})",
                                        style: const TextStyle(
                                          color: Color.fromRGBO(153, 247, 255, 0.7),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3.0,),

                                  Text(
                                    "${controller.podcast.punters}".split(",").join(", "),
                                    style: const TextStyle(
                                      color: Color.fromRGBO(153, 247, 255, 0.7),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30.0,),

                          //  Video Progress Indicator.
                          VideoProgressIndicator(
                            controller.videoPlayerController,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              backgroundColor: Color.fromRGBO(129, 129, 129, 1.0),
                              playedColor: Color.fromRGBO(153, 247, 255, 1.0),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: 5.0,),

                          //  Video Timer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: controller.videoPlayerController,
                                builder: (context, VideoPlayerValue value, child) {
                                  //Do Something with the value.
                                  return Text(
                                    // value.position.toString(),
                                    controller.convertToMinutesSeconds(value.position),
                                    style: const TextStyle(
                                      color: Color.fromRGBO(153, 247, 255, 0.7),
                                      fontSize: 12.0,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                controller.convertToMinutesSeconds(controller.videoPlayerController.value.duration),
                                style: const TextStyle(
                                  color: Color.fromRGBO(153, 247, 255, 0.7),
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25.0,),


                          //Control Buttons Prev, Play/Pause Next.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              //  Like Icon
                              Container(
                                height: 35.0,
                                width: 35.0,
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromRGBO(99, 162, 166, 0.76),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    controller.updateIsPodcastIconLiked();
                                    controller.createOrDeletePodcastLiked(controller.podcast.id!, _audienceStateController.user.id!, _audienceStateController.user.token!);
                                  },
                                  child: Icon(
                                    (controller.isPodcastIconLiked) ? Iconsax.like_15 : Iconsax.like_1,
                                    color: const Color.fromRGBO(153, 247, 255, 1.0),
                                    size: 16.0,
                                  ),
                                ),
                              ),

                              //  Rewind Icon
                              ElevatedButton(
                                onPressed: () {
                                  controller.videoPlayerController.seekTo(
                                      Duration(
                                          seconds: controller.videoPlayerController.value.position.inSeconds - 10
                                      )
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color.fromRGBO(11, 64, 71, 0.9),
                                  shape:const CircleBorder(),
                                  padding: const EdgeInsets.all(6.0),
                                ),
                                child: const Icon(Icons.fast_rewind),
                              ),

                              //  Play Icon
                              ElevatedButton(
                                onPressed: () {
                                  (controller.videoPlayerController.value.isPlaying) ? ({
                                    controller.updateIsPlaying(false),
                                    controller.videoPlayerController.pause(),
                                  }) : ({
                                    controller.updateIsPlaying(true),
                                    controller.videoPlayerController.play(),
                                    controller.handleCreateViewPodcast(controller.podcast.id!, _audienceStateController.user.id!, _audienceStateController.user.token!),
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color.fromRGBO(11, 64, 71, 0.9),
                                  shape:const CircleBorder(),
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                child: Icon(
                                    (controller.isPlaying) ? (Icons.pause) : (Icons.play_arrow)
                                ),
                              ),

                              //  FastForward Icon
                              ElevatedButton(
                                onPressed: () {
                                  controller.videoPlayerController.seekTo(
                                      Duration(
                                          seconds: controller.videoPlayerController.value.position.inSeconds + 10
                                      )
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color.fromRGBO(11, 64, 71, 0.9),
                                  shape:const CircleBorder(),
                                  padding: const EdgeInsets.all(6.0),
                                ),
                                child: const Icon(Icons.fast_forward),
                              ),

                              //  More Option Icon
                              SizedBox(
                                width: 40.0,
                                child: TextButton(
                                  onPressed: () {
                                    ShowPodcastMoreOptionBottomSheet.showPodcastMoreOptionBottomSheet(controller.podcast, controller.likeCounter, controller.viewCounter);
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Icon(
                                    Icons.more_vert,
                                    color: Color.fromRGBO(153, 247, 255, 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25.0,),

                          //  Media Type.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                  controller.updateMediaType("Audio");
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: (controller.mediaType == "Audio")
                                      ? const Color.fromRGBO(99, 162, 166, 0.76)
                                      : Colors.transparent,
                                  shadowColor: Colors.transparent.withOpacity(0.1),
                                  minimumSize: const Size(100.0, 40.0),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(99, 162, 166, 0.76),
                                    width: 1.0,
                                  ),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(
                                  "Audio",
                                  style: TextStyle(
                                    color: Color.fromRGBO(153, 247, 255, 1.0),
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: (){
                                  controller.updateMediaType("Video");
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: (controller.mediaType == "Video")
                                      ? const Color.fromRGBO(99, 162, 166, 0.76)
                                      : Colors.transparent,
                                  shadowColor: Colors.transparent.withOpacity(0.1),
                                  minimumSize: const Size(100.0, 40.0),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(99, 162, 166, 0.76),
                                    width: 1.0,
                                  ),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(
                                  "Video",
                                  style: TextStyle(
                                    color: Color.fromRGBO(153, 247, 255, 1.0),
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                ),
              ),
            ],
          );
        }
        ),
      ),

      //  Bottom Navigation Bar.
      bottomNavigationBar: GetBuilder<PodcastStateController>(builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            gradient : LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromRGBO(1, 31, 44, 1),Color.fromRGBO(5, 50, 59, 1)]
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  Back Button
                  Container(
                    height: 35.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color.fromRGBO(99, 162, 166, 0.16)
                    ),
                    margin: const EdgeInsets.only(left: 15.0),
                    child: TextButton(
                      onPressed: () {
                        controller.resetIsPodcastLikedAndIsPodcastIconLiked;  //  Reset the "IsPodcastLiked" and "IsPodcastIconLiked" when you return to "AudienceHomeScreen".
                        controller.updateViewCounter(0);  //  Reset the View counter to zero (0).
                        controller.updateIsPlaying(false);
                        controller.updateIsViewed(false);
                        controller.videoPlayerController.pause();
                        controller.videoPlayerController.seekTo(
                            const Duration(seconds: 0)
                        );
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5.0)
                      ),
                      child: const Icon(
                        Iconsax.arrow_left,
                        color: Color.fromRGBO(11, 64, 71, 0.9),
                      ),
                    ),
                  ),

                  const Text(
                    "Up next",
                    style: TextStyle(
                      color: Color.fromRGBO(11, 64, 71, 0.8),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 30.0,),

                  //  Up Button
                  TextButton(
                    onPressed: () {
                      ShowUpNextBottomSheet.showUpNextBottomSheet();
                    },
                    child: const Icon(
                      Iconsax.arrow_up_2,
                      color: Color.fromRGBO(11, 64, 71, 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
