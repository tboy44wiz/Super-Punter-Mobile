import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_punter/routes/app_routes/app_route_names.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late double _xAlign;
  late Color _loginColor;
  late Color _registerColor;
  final Color _selectedColor = const Color(0xff06353C);
  final Color _unSelectedColor = Colors.white70;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _xAlign = -1;
    _loginColor = _selectedColor;
    _registerColor = _unSelectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //  Body.
      body: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0,),
          decoration: const BoxDecoration(
            gradient : LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromRGBO(1, 31, 44, 1),Color.fromRGBO(5, 50, 59, 1)]
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/app_logo.png",
                      height: 150.0,
                    ),
                    const SizedBox(height: 60.0,),

                    const Text(
                      "Watch and listen to professional punters\nas they analyze your favorite sports for\npossible predictions",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17.0
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    height: 45.0,
                    width: Get.width * 0.85,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(99, 162, 166, 0.31),
                      borderRadius: BorderRadius.circular(50.0)
                    ),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          alignment: Alignment(_xAlign, 0),
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            height: 45.0,
                            width: Get.width * 0.43,
                            decoration: const BoxDecoration(
                              color: Color(0xff90CED2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _xAlign = -1;
                              _loginColor = _selectedColor;
                              _registerColor = _unSelectedColor;
                            });
                            Get.offAndToNamed(loginScreen);
                          },
                          child: Align(
                            alignment: const Alignment(-1, 0),
                            child: Container(
                              height: 45.0,
                              width: Get.width * 0.43,
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: _loginColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _xAlign = 1;
                              _loginColor = _unSelectedColor;
                              _registerColor = _selectedColor;
                            });
                            Get.offAndToNamed(registerScreen);
                          },
                          child: Align(
                            alignment: const Alignment(1, 0),
                            child: Container(
                              height: 45.0,
                              width: Get.width * 0.43,
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: _registerColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}