import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../routes/app_routes/app_route_names.dart';
import '../../states/audience_state_controller.dart';
import '../../states/podcast_state_controller.dart';
import '../../widgets/app_snackBar_widget.dart';

class AudienceHomeScreen extends StatelessWidget {
  AudienceHomeScreen({Key? key}) : super(key: key);

  final AudienceStateController _audienceStateController = Get.find<AudienceStateController>();
  final PodcastStateController _podcastStateController = Get.put(PodcastStateController());
  final AppSnackBar _appSnackBar = AppSnackBar();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _audienceStateController.getUserData();
      _podcastStateController.getAllPodcasts();
    });

    return Scaffold(
      //  Body.
      body: GetBuilder<AudienceStateController>(builder: (controller) {
        return (controller.user.id != null)
            ? Container(
                height: Get.height,
                width: Get.width,
                color: Colors.white54,
                padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Welcome message with Avatar.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Hi, ",
                              style: TextStyle(
                                color: Color.fromRGBO(11, 64, 71, 0.8),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              controller.user.name!,
                              style: const TextStyle(
                                color: Color.fromRGBO(11, 64, 71, 0.8),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 15.0,),

                            InkWell(
                              onTap: () {
                                Get.toNamed(audienceProfileScreen);
                              },
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(27.0),
                                    color: const Color.fromRGBO(99, 162, 166, 0.76),
                                    image: DecorationImage(
                                      image: (controller.user.picture != null)
                                          ? NetworkImage(controller.user.picture!)
                                          : const AssetImage("./assets/images/profile.png") as ImageProvider,
                                      fit: BoxFit.cover,
                                    )),
                                child: null,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15.0,),

                    GetBuilder<PodcastStateController>(builder: (controller) {
                      return Expanded(
                        flex: 1,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            //  Search Box.
                            Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color.fromRGBO(99, 162, 166, 0.16),
                              ),
                              padding: const EdgeInsets.all(0.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText: "| Search",
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(99, 162, 166, 0.76),
                                    fontSize: 14.0,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 18.0,
                                  ),
                                  suffixIcon: Icon(
                                    Iconsax.search_normal,
                                    color: Color.fromRGBO(11, 64, 71, 0.6),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Color.fromRGBO(11, 64, 71, 0.8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15.0),

                            //  Choose your favorite
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Sport type",
                                  style: TextStyle(
                                    color: Color.fromRGBO(11, 64, 71, 0.8),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10.0,),

                                //  Sports List
                                SizedBox(
                                  height: 30.0,
                                  child: ListView.builder(
                                    itemCount: controller.sportTypeList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          controller.updateSelectedSportIndex(index);
                                          controller.handleSportsTypeItemClicked(controller.sportTypeList[index]);
                                        },
                                        child: AnimatedContainer(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 5.0,
                                            horizontal: 10.0,
                                          ),
                                          duration: const Duration(milliseconds: 500),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14.0),
                                            color: (controller.selectedSportIndex == index) ? (
                                                const Color.fromRGBO(99, 162, 166, 0.16)
                                            ) : (
                                                Colors.white
                                            ),
                                          ),
                                          child: Text(
                                            (controller.selectedSportIndex == index) ? (
                                                "  ${controller.sportTypeList[index]}  "
                                            ) : (
                                                controller.sportTypeList[index]
                                            ),
                                            style: const TextStyle(
                                                color: Color.fromRGBO(11, 64, 71, 0.8),
                                                fontSize: 12.0,
                                                height: 1.5
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0,),

                            (!controller.isLoading) ?
                            Column(
                              children: [
                                //  Upcoming
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Upcoming",
                                          style: TextStyle(
                                            color: Color.fromRGBO(11, 64, 71, 0.8),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(podcastListScreen, parameters: {
                                              "from": "UpComing"
                                            });
                                          },
                                          child: const Text(
                                            "See more",
                                            style: TextStyle(
                                                color: Color.fromRGBO(11, 64, 71, 0.8),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),

                                    SizedBox(
                                      height: 140.0,
                                      child: ListView.builder(
                                        itemCount: controller.upcomingPodcasts.length,
                                        scrollDirection: Axis.horizontal,
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
                                            child: Card(
                                              elevation: 3.0,
                                              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 5.0),
                                              shadowColor: Colors.black38,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: Container(
                                                height: 140.0,
                                                width: 225.0,
                                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20.0),
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
                                                      height: 30,
                                                      width: 57,
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
                                                      height: 35,
                                                      width: 35,
                                                      padding: const EdgeInsets.only(left: 4.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          color: Colors.white
                                                      ),
                                                      child: const Icon(
                                                        Iconsax.play,
                                                        color: Color(0xff06353C),
                                                        size: 22.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0,),

                                //  Ads Two
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 80.0,
                                    width: 345.0,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("./assets/images/bet9ja_ads.png")
                                        )
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15.0,),

                                //  Top Rated
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Top rated",
                                          style: TextStyle(
                                            color: Color.fromRGBO(11, 64, 71, 0.8),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(podcastListScreen, parameters: {
                                              "from": "TopRated"
                                            });
                                          },
                                          child: const Text(
                                            "See more",
                                            style: TextStyle(
                                                color: Color.fromRGBO(11, 64, 71, 0.8),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),

                                    SizedBox(
                                      height: 160.0,
                                      child: ListView.builder(
                                        itemCount: controller.topRatedPodcasts.length,
                                        scrollDirection: Axis.horizontal,
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
                                                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 5.0),
                                                  shadowColor: Colors.black38,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                  ),
                                                  child: Container(
                                                    height: 100.0,
                                                    width: 205.0,
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
                                                SizedBox(
                                                  width: 205.0,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        (controller.topRatedPodcasts[index].title!.length > 25)
                                                            ? controller.topRatedPodcasts[index].title!.replaceRange(25, null, "...")
                                                            : controller.topRatedPodcasts[index].title!,
                                                        // controller.topRatedPodcasts[index].contestantA!,
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(11, 64, 71, 0.8),
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),

                                                      Container(
                                                        height: 22,
                                                        width: 52,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20.0),
                                                            color: const Color.fromRGBO(99, 162, 166, 0.16)
                                                        ),
                                                        child: Text(
                                                          controller.topRatedPodcasts[index].sportsName!,
                                                          style: const TextStyle(
                                                            color: Color.fromRGBO(11, 64, 71, 0.8),
                                                            fontSize: 11.0,
                                                          ),
                                                          // textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "${controller.topRatedPodcasts[index].viewsCount} ${int.parse(controller.topRatedPodcasts[index].viewsCount!) <= 1 ? 'view' : 'views'}",
                                                  style: const TextStyle(
                                                    color: Color.fromRGBO(11, 64, 71, 0.8),
                                                    fontSize: 12.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ) :
                            Shimmer.fromColors(
                              baseColor: const Color(0xFFDADADA),
                              highlightColor: const Color(0xFFD0D0D0),
                              child: Column(
                                children: [
                                  //  Upcoming
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 12.0,
                                            width: 90.0,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(5.0)
                                            ),
                                          ),

                                          Container(
                                            height: 10.0,
                                            width: 60.0,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(5.0)
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12.0),

                                      SizedBox(
                                        height: 140.0,
                                        child: ListView.builder(
                                          itemCount: controller.upcomingPodcasts.length,
                                          // itemCount: _upcomingList.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Card(
                                              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 5.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: Container(
                                                height: 140.0,
                                                width: 225.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0,),

                                  //  Ads Two
                                  Container(
                                    height: 80.0,
                                    width: 345.0,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 22.0,),

                                  //  Top Rated
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 12.0,
                                            width: 90.0,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(5.0)
                                            ),
                                          ),

                                          Container(
                                            height: 10.0,
                                            width: 60.0,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(5.0)
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12.0),

                                      SizedBox(
                                        height: 160.0,
                                        child: ListView.builder(
                                          itemCount: controller.topRatedPodcasts.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Card(
                                                  elevation: 3.0,
                                                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 5.0),
                                                  shadowColor: Colors.black38,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                  ),
                                                  child: Container(
                                                    height: 100.0,
                                                    width: 205.0,
                                                    padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 9.0),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 22,
                                                          width: 52,
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
                                                        const SizedBox(
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 205.0,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      Container(
                                                        height: 12.0,
                                                        width: 40.0,
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius: BorderRadius.circular(5.0)
                                                        ),
                                                      ),

                                                      Container(
                                                        height: 22,
                                                        width: 52,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20.0),
                                                            color: const Color.fromRGBO(99, 162, 166, 0.16)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 9.0,
                                                  width: 65.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius: BorderRadius.circular(5.0)
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              )
            : GetBuilder<PodcastStateController>(builder: (controller) {
              return Container(
                height: Get.height,
                width: Get.width,
                padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                child: Shimmer.fromColors(
                  baseColor: const Color(0xFFDADADA),
                  highlightColor: const Color(0xFFD0D0D0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Welcome message with Avatar.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 9.0,
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5.0)
                                  ),
                                ),
                                const SizedBox(width: 10.0,),

                                InkWell(
                                  onTap: () {
                                    Get.toNamed(audienceProfileScreen);
                                  },
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(99, 162, 166, 0.76),
                                    ),
                                    child: null,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 15.0,),

                        Expanded(
                          flex: 1,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              //  Search Box.
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: const Color.fromRGBO(99, 162, 166, 0.16),
                                ),
                              ),
                              const SizedBox(height: 25.0,),

                              //  Choose your favorite
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 9.0,
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5.0)
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),

                                  Container(
                                    height: 12.0,
                                    width: 130.0,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5.0)
                                    ),
                                  ),
                                  const SizedBox(height: 18.0,),

                                  //  Sports List
                                  SizedBox(
                                    height: 30.0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index) {
                                        return AnimatedContainer(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 5.0,
                                            horizontal: 10.0,
                                          ),
                                          duration: const Duration(milliseconds: 500),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14.0),
                                            color: Colors.grey,
                                          ),
                                          child: Container(
                                            width: 50.0,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(5.0)
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25.0,),

                              //  Upcoming
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 12.0,
                                        width: 90.0,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(5.0)
                                        ),
                                      ),

                                      Container(
                                        height: 10.0,
                                        width: 60.0,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(5.0)
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12.0),

                                  SizedBox(
                                    height: 140.0,
                                    child: ListView.builder(
                                      itemCount: controller.upcomingPodcasts.length,
                                      // itemCount: _upcomingList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Card(
                                          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 5.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: Container(
                                            height: 140.0,
                                            width: 225.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0,),

                              //  Ads Two
                              Container(
                                height: 80.0,
                                width: 345.0,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 22.0,),

                              //  Top Rated
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 12.0,
                                        width: 90.0,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(5.0)
                                        ),
                                      ),

                                      Container(
                                        height: 10.0,
                                        width: 60.0,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(5.0)
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12.0),

                                  SizedBox(
                                    height: 160.0,
                                    child: ListView.builder(
                                      itemCount: controller.topRatedPodcasts.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                              elevation: 3.0,
                                              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 5.0),
                                              shadowColor: Colors.black38,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                height: 100.0,
                                                width: 205.0,
                                                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 9.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 22,
                                                      width: 52,
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
                                                    const SizedBox(
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 205.0,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Container(
                                                    height: 12.0,
                                                    width: 40.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius.circular(5.0)
                                                    ),
                                                  ),

                                                  Container(
                                                    height: 22,
                                                    width: 52,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20.0),
                                                        color: const Color.fromRGBO(99, 162, 166, 0.16)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 9.0,
                                              width: 65.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius: BorderRadius.circular(5.0)
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
