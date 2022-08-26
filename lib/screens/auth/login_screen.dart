import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:super_punter/routes/app_routes/app_route_names.dart';

import '../../states/auth_state_controller.dart';
import '../../widgets/app_snackBar_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthStateController _authStateController = Get.put(AuthStateController());
  final AppSnackBar _appSnackBar = AppSnackBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //  Body.
      body: DoubleBackToCloseApp(
        snackBar: _appSnackBar.snackBar('Tap back again to exit the app.', 'Info'),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            gradient : LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromRGBO(1, 31, 44, 1),Color.fromRGBO(5, 50, 59, 1)]
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -5.0,
                left: -50.0,
                child: Image.asset(
                  "assets/images/ellipse_big.png",
                  height: 240.0,
                  width: 300.0,
                ),
              ),
              Positioned(
                bottom: 50.0,
                right: -10.0,
                child: Image.asset(
                  "assets/images/ellipse_small.png",
                  height: 173.0,
                  width: 202.0,
                ),
              ),
              GetBuilder<AuthStateController>(
                  builder: (controller) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/super_punter.png",),
                                const SizedBox(height: 80.0,),

                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (value) {
                                          controller.updateEmail(value);
                                        },
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: 'Email can not be empty.'),
                                        ]),
                                        autofocus: true,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle: const TextStyle(
                                            color: Color(0xffB3E7EB),
                                            fontSize: 14.0,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: const BorderSide(
                                                color: Color.fromRGBO(99, 162, 166, 0.76)
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: const BorderSide(
                                                color: Color.fromRGBO(99, 162, 166, 0.76),
                                                width: 2.0
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            vertical: 0.0,
                                            horizontal: 20.0,
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Color(0xffB3E7EB),
                                          // color: Color.fromRGBO(11, 64, 71, 0.8),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0,),

                                      TextFormField(
                                        onChanged: (value) {
                                          controller.updatePassword(value);
                                        },
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: 'Password can not be empty.'),
                                        ]),
                                        obscureText: controller.hidePassword,
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                            color: Color(0xffB3E7EB),
                                            fontSize: 14.0,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              controller.updateHidePassword();
                                            },
                                            icon: Icon(controller.hidePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                              color: const Color(0xffB3E7EB),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
                                                  color: Color.fromRGBO(99, 162, 166, 0.76)
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: const BorderSide(
                                                color: Color.fromRGBO(99, 162, 166, 0.76),
                                                width: 2.0
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                                        ),
                                        style: const TextStyle(
                                          color: Color(0xffB3E7EB),
                                          // color: Color.fromRGBO(11, 64, 71, 0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          //  Login Button.
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    (_formKey.currentState!.validate()) ? (
                                        controller.loginUser()
                                    ) : ({
                                      controller.updateAutoValidateMode(),
                                      _appSnackBar.snackBar('Please fill all the required fields.', 'Error'),
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5.0,
                                    padding: const EdgeInsets.all(0.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  child: Ink(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: const Color(0xff90CED2)
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 0.0,
                                    ),
                                    child: const Text(
                                      "Login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xff06353C),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 35.0,),

                                //  Don't have an Account.
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Don’t have an account?',
                                      style: TextStyle(
                                        color: Color(0xff63A2A6),
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.all(5.0)),
                                    InkWell(
                                      onTap: () {
                                        Get.offAndToNamed(registerScreen);
                                      },
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                          color: Color(0xffB3E7EB),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25.0,),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
