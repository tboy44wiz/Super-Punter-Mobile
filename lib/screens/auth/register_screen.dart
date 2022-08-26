import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:super_punter/routes/app_routes/app_route_names.dart';

import '../../states/auth_state_controller.dart';
import '../../widgets/app_snackBar_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

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
                            flex: 4,
                            child: Container(),
                          ),

                          Expanded(
                            flex: 12,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/images/super_punter.png",),
                                  const SizedBox(height: 40.0,),

                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        /*DropdownButtonFormField<String>(
                                          // value: _selectedUser,
                                          validator: (value) => (value == null)
                                              ? ('Please select a user type.')
                                              : (null),
                                          items: <String>[
                                            'Punter',
                                            'Audience',
                                          ].map((userType) {
                                            return DropdownMenuItem(
                                              value: userType,
                                              child: Text(userType),
                                            );
                                          }).toList(),
                                          decoration: InputDecoration(
                                            hintText: 'Register as',
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
                                            contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                                          ),
                                          dropdownColor: const Color.fromRGBO(5, 80, 89, 1),
                                          onChanged: (selectedValue) {
                                            controller.updateRole(selectedValue!);
                                          },
                                          style: const TextStyle(
                                            color: Color(0xffB3E7EB),
                                          ),
                                        ),
                                        const SizedBox(height: 20.0,),*/

                                        TextFormField(
                                          onChanged: (value) {
                                            controller.updateName(value);
                                          },
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: 'Name is required.'),
                                          ]),
                                          autofocus: true,
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: 'Name',
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
                                          textCapitalization: TextCapitalization.words,
                                        ),
                                        const SizedBox(height: 20.0,),

                                        TextFormField(
                                          onChanged: (value) {
                                            controller.updateEmail(value);
                                          },
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: 'Email is required.'),
                                            EmailValidator(errorText: 'Enter a valid email address')
                                          ]),
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
                                            RequiredValidator(errorText: 'Password is required'),
                                            MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
                                            PatternValidator(r'^[a-zA-Z0-9]{6,30}$', errorText: 'Passwords must have at least one special character')
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
                          ),

                          //  Register Button.
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    (_formKey.currentState!.validate()) ? (
                                    controller.signupUser()
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
                                    child: Text(
                                      (!controller.isLoading) ? "Register" : "Loading...",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xff06353C),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15.0,),

                                //  Already have an Account.
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                        color: Color(0xff63A2A6),
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.all(5.0)),
                                    InkWell(
                                      onTap: () {
                                        Get.offAndToNamed(loginScreen);
                                      },
                                      child: const Text(
                                        'Login',
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
