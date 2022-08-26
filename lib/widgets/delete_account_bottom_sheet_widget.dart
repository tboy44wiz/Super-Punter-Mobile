import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../states/audience_state_controller.dart';


class DeleteAccountBottomSheetWidget {

  static void deleteAccountBottomSheetWidget () {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
        return GetBuilder<AudienceStateController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                height: Get.height * 0.8,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    //  Title.
                    Container(
                      height: 3.0,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    Image.asset(
                      "./assets/images/delete_image.png",
                      height: 130.0,
                      width: 130.0,
                    ),
                    const SizedBox(height: 10.0),

                    const Text(
                      "Delete account?",
                      style: TextStyle(
                        color: Color.fromRGBO(11, 64, 71, 0.8),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10.0),

                    const Text(
                      "We are sorry because we are about to loose you. Please type in your email to confirm.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(11, 64, 71, 0.8),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30.0),

                    //  Password TextFormField.
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
                                color: Color(0x29165b5e),
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
                              color: Color(0xff0c5457),
                              // color: Color.fromRGBO(11, 64, 71, 0.8),
                            ),
                          ),
                          const SizedBox(height: 30.0),

                          Row(
                            children: [
                              //  Cancel Button
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 45.0,
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                    color: const Color.fromRGBO(22, 91, 94, 0.1),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      // padding: const EdgeInsets.all(0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        side: const BorderSide(
                                          color: Color.fromRGBO(22, 91, 94, 0.1),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Cancel",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color.fromRGBO(11, 64, 71, 0.8),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 10.0,
                              ),

                              //  Confirm Button
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 45.0,
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                    color: const Color.fromRGBO(250, 127, 120, 0.2),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      controller.deleteUser();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      // padding: const EdgeInsets.all(0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        side: const BorderSide(
                                          color: Color.fromRGBO(250, 127, 120, 0.1),
                                        ),
                                      ),
                                    ),
                                    child: (!controller.isLoading) ?
                                    Text(
                                      "Confirm" ,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ) :
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Bye..." ,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red[600],
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),

                                        const SizedBox(
                                          width: 10.0,
                                        ),

                                        SizedBox(
                                          height: 15.0,
                                          width: 15.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.red[600],
                                            strokeWidth: 2.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }
}