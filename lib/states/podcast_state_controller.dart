import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:super_punter/models/podcast_model.dart';
import 'package:super_punter/routes/api_routes/api_route_names.dart';
import 'package:video_player/video_player.dart';

import '../services/api_service.dart';

class PodcastStateController extends GetxController {

  int _selectedSportIndex = 0;
  final List<String> _sportTypeList = ["All", "Basketball", "Baseball", "Boxing", "Car Racing", "Football", "etc"];
  int? _selectedSportTypeIndex;
  late Podcast _podcast;
  List<Podcast> _allPodcasts = [];
  List<Podcast> _upcomingPodcasts = [];
  List<Podcast> _topRatedPodcasts = [];
  String _mediaType = "Video";
  String _playedTime = "0:0";
  late VideoPlayerController _videoPlayerController;
  late Future<void> _futureController;
  bool _isPlaying = false;
  int _viewCounter = 0;
  bool _isViewed = false;
  int _likeCounter = 0;
  bool _isPodcastLiked = false;
  bool _isPodcastIconLiked = false;
  bool _isLoading = false;


  /*
  * GETTERS
  * */
  int get selectedSportIndex => _selectedSportIndex;
  List<String> get sportTypeList => _sportTypeList;
  int? get selectedSportTypeIndex => _selectedSportTypeIndex;
  Podcast get podcast => _podcast;
  List<Podcast> get allPodcasts => _allPodcasts;
  List<Podcast> get upcomingPodcasts => _upcomingPodcasts;
  List<Podcast> get topRatedPodcasts => _topRatedPodcasts;
  String get mediaType => _mediaType;
  String get playedTime => _playedTime;
  VideoPlayerController get videoPlayerController => _videoPlayerController;
  Future get futureController => _futureController;
  bool get isPlaying => _isPlaying;
  int get viewCounter => _viewCounter;
  bool get isViewed => _isViewed;
  int get likeCounter => _likeCounter;
  bool get isPodcastLiked => _isPodcastLiked;
  bool get isPodcastIconLiked => _isPodcastIconLiked;
  bool get isLoading => _isLoading;



  /*
  * SETTERS
  * */
  updateSelectedSportIndex(int index) {
    _selectedSportIndex = index;
    update();
  }
  updateSelectedSportTypeIndex(int index) {
    _selectedSportTypeIndex = index;
    update();
  }
  void updatePodcast(Podcast podcastValue) {
    _podcast = podcastValue;
    update();
  }
  void updateAllPodcasts(List<Podcast> podcastsValue) {
    _allPodcasts = podcastsValue;
    update();
  }
  void updateUpcomingPodcasts(List<Podcast> podcastsValue) {
    _upcomingPodcasts = podcastsValue;
    update();
  }
  void updateTopRatedPodcasts(List<Podcast> podcastsValue) {
    _topRatedPodcasts = podcastsValue;
    update();
  }
  void updateMediaType(String value) {
    _mediaType = value;
    update();
  }
  void updatePlayedTime(String value) {
    _playedTime = value;
    update();
  }
  void updateIsPlaying(bool value) {
    _isPlaying = value;
    update();
  }
  void updateIsViewed(bool value) {
    _isViewed = value;
    update();
  }
  void updateViewCounter(int value) {
    _viewCounter = value;
    update();
  }
  void updateIsPodcastLiked(bool value) {
    _isPodcastLiked = value;
    update();
  }
  void updateIsPodcastIconLiked() {
    _isPodcastIconLiked = !_isPodcastIconLiked;
    update();
  }
  void resetIsPodcastLikedAndIsPodcastIconLiked() {
    _isPodcastLiked = false;
    _isPodcastIconLiked = false;
    update();
  }
  void updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getAllPodcasts();
    // initializeVideoPlayer();
  }


  //  Get All Podcasts.
  Future<void> getAllPodcasts() async {
    updateIsLoading(true);

    var response = await APIService.getAllPodcastsService(getAllPodcastsRoute);
    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);
      List<dynamic> podcastsData = response.data["data"];

      //  Convert the returned List<dynamic> to List<Podcast>
      List<Podcast> allPodcastsData = podcastsData.map((eachPodcast) => Podcast.fromMap(eachPodcast)).toList();
      List<Podcast> allUpcomingPodcastsData = podcastsData.map((eachPodcast) => Podcast.fromMap(eachPodcast)).toList();
      List<Podcast> allTopPodcastsData = podcastsData.map((eachPodcast) => Podcast.fromMap(eachPodcast)).toList();

      //  Sort according to most recent "updatedAt".
      allUpcomingPodcastsData.sort((a, b) {
        DateTime? aUpdatedAt = a.updatedAt;
        DateTime? bUpdatedAt = b.updatedAt;
        return aUpdatedAt!.compareTo(bUpdatedAt!);
      });

      //  Sort according to most "likesCount".
      allTopPodcastsData.sort((a, b) {
        String? aLikesCount = a.likesCount;
        String? bLikesCount = b.likesCount;
        return bLikesCount!.compareTo(aLikesCount!);
      });

      //  Update Podcast.
      updateAllPodcasts(allPodcastsData);
      updateUpcomingPodcasts(allUpcomingPodcastsData);
      updateTopRatedPodcasts(allTopPodcastsData);
    } else {
      // updateIsLoading(false);
      // print("Ooops!!! ${response.data['message']}");
      /*ElegantNotification.error(
        height: 50.0,
        width:  300.0,
        description: Text("Ooops!!! ${response.data['message']}"),
        toastDuration: const Duration(seconds: 5),
        showProgressIndicator: false,
      ).show(Get.context!);*/

      Get.snackbar(
        "error",
        "Ooops!!! ${response.data['message']}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //  When a Sports Type Item is Clicked.
  void handleSportsTypeItemClicked(String sportTypeIndex) {
    List<Podcast> allSelectedSportsUpcomingPodcasts = (sportTypeIndex != "All")
        ? _allPodcasts.where((eachPodcast) => eachPodcast.sportsName == sportTypeIndex).toList()
        : _allPodcasts;

    List<Podcast> allSelectedSportsTopPodcasts = (sportTypeIndex != "All")
        ? _allPodcasts.where((eachPodcast) => eachPodcast.sportsName == sportTypeIndex).toList()
        : _allPodcasts;

    //  Sort according to most recent "updatedAt".
    allSelectedSportsUpcomingPodcasts.sort((a, b) {
      DateTime? aUpdatedAt = a.updatedAt;
      DateTime? bUpdatedAt = b.updatedAt;
      return aUpdatedAt!.compareTo(bUpdatedAt!);
    });

    //  Sort according to most "likesCount".
    allSelectedSportsTopPodcasts.sort((a, b) {
      String? aLikesCount = a.likesCount;
      String? bLikesCount = b.likesCount;
      return bLikesCount!.compareTo(aLikesCount!);
    });

    //  Update Podcast.
    updateUpcomingPodcasts(allSelectedSportsUpcomingPodcasts);
    updateTopRatedPodcasts(allSelectedSportsTopPodcasts);
  }

  //  When the Liked Button Item is Clicked.
  Future<void> createOrDeletePodcastLiked(String podcastId, String userId, String token) async {
    updateIsLoading(true);

    Map<String, dynamic> podcastLikeData = {
      "podcastId": podcastId,
      "userId": userId
    };

    var response = await APIService.createOrDeletePodcastLikedService(createOrDeletePodcastLikeRoute, podcastLikeData, token);
    bool isSuccess = response!.data["success"];
    print("DDDDDDD::: $response");

    if (isSuccess) {
      updateIsLoading(false);

      Podcast likePodcast = Podcast.fromMap(response.data["data"]);

      //  Update the List of Podcast.
      Podcast matchedPodcast = _allPodcasts.firstWhere((eachPodcast) => eachPodcast.id == likePodcast.id);
      var podcastIndex = _allPodcasts.indexOf(matchedPodcast);
      _allPodcasts[podcastIndex] = likePodcast;
      List<Podcast> updatedUpcomingPodcasts = _allPodcasts;
      List<Podcast> updatedTopRatedPodcasts = _allPodcasts;
      update();

      //  Sort according to most recent "updatedAt".
      updatedUpcomingPodcasts.sort((a, b) {
        DateTime? aUpdatedAt = a.updatedAt;
        DateTime? bUpdatedAt = b.updatedAt;
        return aUpdatedAt!.compareTo(bUpdatedAt!);
      });
      //  Sort according to most "likesCount".
      updatedTopRatedPodcasts.sort((a, b) {
        String? aLikesCount = a.likesCount;
        String? bLikesCount = b.likesCount;
        return bLikesCount!.compareTo(aLikesCount!);
      });

      //  Update Podcast.
      updateUpcomingPodcasts(updatedUpcomingPodcasts);
      updateTopRatedPodcasts(updatedTopRatedPodcasts);

      if (likePodcast.likes!.isNotEmpty) {
        String likedPodcastUserId = likePodcast.likes![0].userId!;
        if (userId == likedPodcastUserId) {
          _isPodcastIconLiked = true;
          _likeCounter = int.parse(likePodcast.likesCount!);
          update();
        } else {
          _isPodcastIconLiked = false;
          _likeCounter = int.parse(likePodcast.likesCount!);
          update();
        }
      } else {
        _isPodcastIconLiked = false;
        _likeCounter = int.parse(likePodcast.likesCount!);
        update();
      }
    } else {
      updateIsLoading(false);
      MotionToast.error(
        height: 50.0,
        width:  300.0,
        description: Text("Ooops!!! ${response.data['message']}"),
        borderRadius: 5.0,
        toastDuration: const Duration(seconds: 4),
      ).show(Get.context!);
    }

  }

  //  Check if this User has already liked this Podcast.
  void handleIsPodcastIconLiked(String? loggedInUserId, Podcast selectedPodcast) {
    updatePodcast(selectedPodcast);

    if (selectedPodcast.likes!.isNotEmpty) {
      if (selectedPodcast.likes![0].userId == loggedInUserId) {
        _isPodcastIconLiked = true;
        _likeCounter = int.parse(selectedPodcast.likesCount!);
        update();
      } else {
        _isPodcastIconLiked = false;
        _likeCounter = int.parse(selectedPodcast.likesCount!);
        update();
      }
    } else {
      _isPodcastIconLiked = false;
      _likeCounter = int.parse(selectedPodcast.likesCount!);
      update();
    }
  }

  //  Call the Create View EndPoint.
  void handleCreateViewPodcast(String podcastId, String userId, String token) {
    (!isViewed)
        ? createViewPodcast(podcastId, userId, token)
        : null;
  }
  Future<void> createViewPodcast(String podcastId, String userId, String token) async {
    updateIsLoading(true);
    updateIsViewed(true);

    Map<String, dynamic> podcastViewData = {
      "podcastId": podcastId,
      "userId": userId
    };

    var response = await APIService.createViewPodcastService(createPodcastViewRoute, podcastViewData, token);
    bool isSuccess = response!.data["success"];

    if (isSuccess) {
      updateIsLoading(false);

      Podcast viewedPodcast = Podcast.fromMap(response.data["data"]);

      //  Update View Counter
      updateViewCounter(int.parse(viewedPodcast.viewsCount!));

      //  Update the List of Podcast.
      Podcast matchedPodcast = _allPodcasts.firstWhere((eachPodcast) => eachPodcast.id == viewedPodcast.id);
      var podcastIndex = _allPodcasts.indexOf(matchedPodcast);
      _allPodcasts[podcastIndex] = viewedPodcast;
      List<Podcast> updatedUpcomingPodcasts = _allPodcasts;
      List<Podcast> updatedTopRatedPodcasts = _allPodcasts;
      update();

      //  Sort according to most recent "updatedAt".
      updatedUpcomingPodcasts.sort((a, b) {
        DateTime? aUpdatedAt = a.updatedAt;
        DateTime? bUpdatedAt = b.updatedAt;
        return aUpdatedAt!.compareTo(bUpdatedAt!);
      });
      //  Sort according to most "likesCount".
      updatedTopRatedPodcasts.sort((a, b) {
        String? aLikesCount = a.likesCount;
        String? bLikesCount = b.likesCount;
        return bLikesCount!.compareTo(aLikesCount!);
      });

      //  Update Podcast.
      updateUpcomingPodcasts(updatedUpcomingPodcasts);
      updateTopRatedPodcasts(updatedTopRatedPodcasts);

    } else {
      updateIsLoading(false);
    }
  }


  /*void initializeVideoPlayer() {
    //url to load network
    _videoPlayerController = VideoPlayerController.network("https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    _futureController = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(false);  // this will keep video looping active, means video will keep on playing
    _videoPlayerController.setVolume(25.0);  // default  volume to initially play the video
  }*/
  /*void initializeVideoPlayer(String featuredVideoFile) {
    print("VIDEO URL::: $_featuredVideoFile");
    //url to load network
    _videoPlayerController = VideoPlayerController.network(featuredVideoFile)
    ..initialize().then((_) {
      _videoPlayerController.setLooping(false);  // this will keep video looping active, means video will keep on playing
      _videoPlayerController.setVolume(25.0);  // default  volume to initially play the video
      update();
    });
    update();
  }*/
  void initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(_podcast.featuredVideoFile!);
    _videoPlayerController.initialize().then((_) {
      _videoPlayerController.setLooping(false);  // this will keep video looping active, means video will keep on playing
      _videoPlayerController.setVolume(25.0);  // default  volume to initially play the video
      update();
    });
    update();
  }

  //  Format Video Player Timer.
  String convertToMinutesSeconds(Duration duration) {
    final parsedMinutes = duration.inMinutes % 60;
    // final minutes = parsedMinutes < 10 ? '0$parsedMinutes' : parsedMinutes.toString();   //  Add "0" before the minute if only it's less than 10.

    final parsedSeconds = duration.inSeconds % 60;
    final seconds = parsedSeconds < 10 ? '0$parsedSeconds' : parsedSeconds.toString();

    // return '$minutes:$seconds';
    return '$parsedMinutes:$seconds';
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    updateIsViewed(false);
    update();
    super.dispose();
  }
}