import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:super_punter/routes/app_routes/app_route_names.dart';
import 'package:super_punter/routes/app_routes/app_routes.dart';

void main() async {
  //  Call this whenever you're using "async" in the "main" method.
  WidgetsFlutterBinding.ensureInitialized();

  FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  String _loggedInUser = await _flutterSecureStorage.read(key: 'loggedInUser') ?? "";

  //  Decode _loggedInUser
  Map<String, dynamic>? _decodedLoggedInUser;
  if (_loggedInUser.isNotEmpty) {
    _decodedLoggedInUser = jsonDecode(_loggedInUser);
  }

  runApp(MyApp(
    loggedInUserData: _decodedLoggedInUser,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? loggedInUserData;

  const MyApp({Key? key, this.loggedInUserData}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    String _initialRoute = (loggedInUserData == null)
        ? splashScreen
        : audienceMainScreen;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Super Punter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Actor",
      ),

      initialRoute: _initialRoute,
      // initialRoute: introScreen,
      getPages: getPages,
    );
  }
}
