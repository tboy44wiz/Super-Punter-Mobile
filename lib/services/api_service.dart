import 'package:dio/dio.dart';

import '../routes/api_routes/api_route_names.dart';

class APIService {
  static const _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // 'Authorization': _token,
  };


  /*============================================================================
  * AUTH Services
  * ==========================================================================*/
  //  SignUp User.
  static Future<Response?> signupUserService(String url, Map<String, dynamic> userSignUpData) async {
    var _fullURL = "$baseURL$url";
    print("URL::: $_fullURL \n $userSignUpData");

    try {
      return await Dio().post(
        _fullURL,
        data: userSignUpData,
        options: Options(headers: _headers),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Login User.
  static Future<Response?> loginUserService(String url, Map<String, dynamic> userLoginData) async {
    var _fullURL = "$baseURL$url";
    print("URL::: $_fullURL \n $userLoginData");

    try {
      return await Dio().post(
        _fullURL,
        data: userLoginData,
        options: Options(headers: _headers),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Send Verification OTP.
  static Future<Response?> sendVerificationOTPService(String url, Map<String, dynamic> otpData) async {
    var _fullURL = "$baseURL$url";
    // print("URL::: $_fullURL");

    try {
      return await Dio().post(
        _fullURL,
        data: otpData,
        options: Options(headers: _headers),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Verify OTP.
  static Future<Response?> verifyOTPService(String url, String userId, Map<String, dynamic> otpData,  String token) async {
    var _fullURL = "$baseURL$url/$userId";
    // print("URL::: $_fullURL, USERID::: $userId, TOKEN::: $token");

    try {
      return await Dio().post(
        _fullURL,
        data: otpData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }




  /*============================================================================
  * USER Services
  * ==========================================================================*/
  //  Update User.
  static Future<Response?> updateUserService(String url, Map<String, dynamic> userUpdateData, String userId,  String token) async {
    var _fullURL = "$baseURL$url/$userId";
    // print("URL::: $_fullURL \n DATA::: $userUpdateData \n TOKEN::: $token");

    try {
      return await Dio().put(
        _fullURL,
        data: userUpdateData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Get Single User.
  static Future<Response?> getSingleUserService(String url, String userId) async {
    var _fullURL = "$baseURL$url/$userId";
    // print("URL::: $_fullURL \n $userId");

    try {
      return await Dio().get(
        _fullURL,
        options: Options(headers: _headers),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }


  //  Update User.
  static Future<Response?> deleteUserService(String url, String userId,  String token) async {
    var _fullURL = "$baseURL$url/$userId";
    // print("URL::: $_fullURL \n TOKEN::: $token");

    try {
      return await Dio().delete(
        _fullURL,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }



  /*============================================================================
  * PODCAST Services
  * ==========================================================================*/
  //  Get All Podcasts.
  static Future<Response?> getAllPodcastsService(String url) async {
    var _fullURL = "$baseURL$url";
    // print("URL::: $_fullURL");

    try {
      return await Dio().get(
        _fullURL,
        options: Options(headers: _headers),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      return e.response;
    }
  }

  //  Get Single User.
  static Future<Response?> getSinglePodcastService(String url, String podcastId) async {
    var _fullURL = "$baseURL$url/$podcastId";
    // print("URL::: $_fullURL \n $userId");

    try {
      return await Dio().get(
        _fullURL,
        options: Options(headers: _headers),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  static Future<Response?> createOrDeletePodcastLikedService(String url, Map<String, dynamic> podcastLikeData, String token) async {
    var _fullURL = "$baseURL$url";
    print("URL::: $_fullURL \n $podcastLikeData \n $token");

    try {
      return await Dio().post(
        _fullURL,
        data: podcastLikeData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Create View Podcast.
  static Future<Response?> createViewPodcastService(String url, Map<String, dynamic> podcastViewData, String token) async {
    var _fullURL = "$baseURL$url";
    // print("URL::: $_fullURL");

    try {
      return await Dio().post(
        _fullURL,
        data: podcastViewData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      return e.response;
    }
  }

}