import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../routes/app_routes/app_route_names.dart';
import '../../states/audience_state_controller.dart';
import '../../states/auth_state_controller.dart';

class VerifyOTPScreen extends StatelessWidget {
  VerifyOTPScreen({Key? key}) : super(key: key);

  final AuthStateController _authStateController = Get.find<AuthStateController>();

  @override
  Widget build(BuildContext context) {

    //  Get User Role from the Route Parameter.
    String? responseMessage = Get.parameters['responseMessage'];

    return Scaffold(
      //  Body
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
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
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Confirm OTP",
                    style: TextStyle(
                      color: Color(0xffB3E7EB),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Text(
                    responseMessage!,
                    style: const TextStyle(
                      color: Color(0xffB3E7EB),
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [

                  const SizedBox(
                    height: 35.0,
                  ),

                  PinCodeTextField(
                    onChanged: (value) {
                      _authStateController.updateOTP(value);
                    },
                    onCompleted: (value) {
                      _authStateController.verifyOTPs();
                    },
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    textStyle: const TextStyle(
                      color: Color(0xffB3E7EB),
                    ),
                    cursorColor: const Color(0xffB3E7EB),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    pinTheme: PinTheme(
                      fieldHeight: 42.0,
                      fieldWidth: 42.0,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(6.0),
                      borderWidth: 1.0,
                      activeColor: const Color(0xEED5D5D5),
                      inactiveColor: const Color(0xEED5D5D5),
                      selectedColor: const Color(0xEED5D5D5),
                      errorBorderColor: Colors.red,
                    ),
                  ),

                  Row(
                    children: [
                      const Text(
                        "Did not get an email? ",
                        style: TextStyle(
                          color: Color(0xff63A2A6),
                          fontSize: 14.0,
                        ),
                      ),

                      TextButton(
                        onPressed: (){
                          _authStateController.sendVerificationOTP();
                        },
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(
                            color: Color(0xffB3E7EB),
                            fontSize: 14.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
