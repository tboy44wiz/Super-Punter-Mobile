import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../screens/audience/audience_main_screen.dart';
import '../../screens/notification/notification_list_screen.dart';
import '../../screens/podcasts/favorite_podcast_screen.dart';
import './app_route_names.dart';
import '../../screens/podcasts/podcast_list_screen.dart';
import '../../screens/punter/punter_profile_screen.dart';
import '../../screens/ads/ads_screen.dart';
import '../../screens/audience/audience_home_screen.dart';
import '../../screens/podcasts/podcast_detail_screen.dart';
import '../../screens/punter/punter_home_screen.dart';
import '../../screens/settings/about_super_punter_screen.dart';
import '../../screens/audience/audience_profile_screen.dart';
import '../../screens/auth/verify_otp_screen.dart';
import '../../screens/settings/terms_and_privacy_screen.dart';
import '../../screens/splash_and_intro/splash_screen.dart';
import '../../screens/splash_and_intro/intro_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';

List<GetPage<dynamic>> getPages = [
  /*
  * Walk-Through Screens.
  */
  GetPage(name: splashScreen, page: () => const SplashScreen()),
  GetPage(name: introScreen, page: () => const IntroScreen()),

  /*
  * Auth Screens.
  */
  GetPage(name: loginScreen, page: () => LoginScreen()),
  GetPage(name: registerScreen, page: () => RegisterScreen()),
  GetPage(name: verifyOTPScreen, page: () => VerifyOTPScreen()),

  /*
  * Ads Screens.
  */
  GetPage(name: adsScreen, page: () => AdsScreen()),

  /*
  * Punters Screens.
  */
  GetPage(name: punterHomeScreen, page: () => PunterHomeScreen()),
  GetPage(name: punterProfileScreen, page: () => PunterProfileScreen()),

  /*
  * Audience Screens.
  */
  GetPage(name: audienceMainScreen, page: () => AudienceMainScreen()),
  GetPage(name: audienceHomeScreen, page: () => AudienceHomeScreen()),
  GetPage(name: audienceProfileScreen, page: () => AudienceProfileScreen()),

  /*
  * Podcast Screens.
  */
  GetPage(name: podcastListScreen, page: () => PodcastListScreen()),
  GetPage(name: podcastDetailScreen, page: () => PodcastDetailScreen()),
  GetPage(name: favoritePodcastScreen, page: () => const FavoritePodcastScreen()),

  /*
  * About Super Punter Screens.
  */
  GetPage(name: aboutSuperPunterScreen, page: () => const AboutSuperPunterScreen()),
  GetPage(name: termsAndPrivacyScreen, page: () => TermsAndPrivacyScreen()),

  /*
  * Notification Screens.
  */
  GetPage(name: notificationScreen, page: () => NotificationListScreen()),
];