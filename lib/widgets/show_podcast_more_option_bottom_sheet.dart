import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../models/podcast_model.dart';


class ShowPodcastMoreOptionBottomSheet {

  static void showPodcastMoreOptionBottomSheet (Podcast podcast, int likeCounter, int viewCounter) {
    Get.bottomSheet(
        Container(
          height: 270.0,
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
                flex: 3,
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
                    const SizedBox(height: 30.0),

                    //  Podcast name.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${podcast.contestantA} Vs ${podcast.contestantB}",
                          style: const TextStyle(
                              color: Color.fromRGBO(11, 64, 71, 0.8),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        Text(
                          "(${podcast.leagueAbbrev})",
                          style: const TextStyle(
                            color: Color.fromRGBO(11, 64, 71, 0.8),
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Divider(thickness: 1.5,),
              const SizedBox(height: 10.0),

              Expanded(
                flex: 8,
                child: Column(
                  children: [

                    //  Punters.
                    ListTile(
                      leading: const Icon(
                        Iconsax.profile_2user,
                        color: Color.fromRGBO(11, 64, 71, 0.8),
                        size: 22.0,
                      ),
                      title: Text(
                        "${podcast.punters}".split(",").join(", "),
                        style: const TextStyle(
                            color: Color.fromRGBO(11, 64, 71, 0.8),
                            fontSize: 16.0
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      horizontalTitleGap: 0.0,
                    ),

                    //  Views.
                    ListTile(
                      leading: const Icon(
                        Iconsax.eye,
                        color: Color.fromRGBO(11, 64, 71, 0.8),
                        size: 22.0,
                      ),
                      title: Row(
                        children: [
                          Text(
                            viewCounter.toString(), //"1.6K",
                            style: const TextStyle(
                              color: Color.fromRGBO(11, 64, 71, 0.8),
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      horizontalTitleGap: 0.0,
                    ),

                    //  Likes.
                    ListTile(
                      leading: const Icon(
                        Iconsax.like_1,
                        color: Color.fromRGBO(11, 64, 71, 0.8),
                        size: 22.0,
                      ),
                      title: Text(
                        likeCounter.toString(),
                        style: const TextStyle(
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