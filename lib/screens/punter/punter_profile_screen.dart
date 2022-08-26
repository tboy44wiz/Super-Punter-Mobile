import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:super_punter/states/auth_state_controller.dart';
import 'package:super_punter/states/punters_state_controller.dart';

import '../../routes/app_routes/app_route_names.dart';
import '../../states/audience_state_controller.dart';
import '../../widgets/app_snackBar_widget.dart';
import '../../widgets/show_select_avatar_bottom_sheet_widget.dart';

class PunterProfileScreen extends StatelessWidget {
  PunterProfileScreen({Key? key}) : super(key: key);

  final PunterStateController _punterStateController = Get.find<PunterStateController>();
  final AuthStateController _authStateController = Get.put(AuthStateController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AppSnackBar _appSnackBar = AppSnackBar();

  @override
  Widget build(BuildContext context) {
    _punterStateController.updateAllTextEditingControllers();

    return Scaffold(
        //  App Bar
        appBar: AppBar(
          // backgroundColor: Colors.grey[100],
          backgroundColor: Colors.white10,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          flexibleSpace: Container(
            height: 100.0,
            padding: const EdgeInsets.only(top: 50.0, left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: Colors.black54,
                    icon: const Icon(Iconsax.arrow_left_2),
                    padding: const EdgeInsets.all(0.0),
                    iconSize: 24.0,
                  ),
                ),

                const Text(
                  "Profile",
                  style: TextStyle(
                    color: Color.fromRGBO(11, 64, 71, 0.8),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 40.0,
                  width: 40.0,
                ),
              ],
            ),
          ),
        ),

        //  Body.
        body: SingleChildScrollView(
          child: GetBuilder<PunterStateController>(builder: (controller) {
            return Container(
              height: Get.height - 100.0,
              width: Get.width,
              padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 20.0),
              child: (!controller.isEditUser)
                  ? Column(
                      //  Detail View
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                height: 120.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60.0),
                                    color: const Color.fromRGBO(99, 162, 166, 0.76),
                                    image: DecorationImage(
                                      image: (controller.user.picture != null)
                                          ? NetworkImage(controller.user.picture!)
                                          : const AssetImage("./assets/images/profile.png") as ImageProvider,
                                      fit: BoxFit.cover,
                                    )),
                                child: null,
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              const SizedBox(height: 20.0,),

                              Container(
                                height: 280,
                                width: Get.width,
                                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: const Color.fromRGBO(99, 162, 166, 0.16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Name:  ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(11, 64, 71, 0.8),
                                              fontSize: 16.0
                                          ),
                                        ),
                                        Text(
                                          controller.user.name!,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(11, 64, 71, 0.8),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0,),

                                    Row(
                                      children: [
                                        const Text(
                                          "Email:  ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(11, 64, 71, 0.8),
                                              fontSize: 16.0
                                          ),
                                        ),
                                        Text(
                                          controller.user.email!,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(11, 64, 71, 0.8),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0,),

                                    Row(
                                      children: [
                                        const Text(
                                          "Phone:  ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(11, 64, 71, 0.8),
                                              fontSize: 16.0
                                          ),
                                        ),
                                        Text(
                                          (controller.user.phone != null) ? controller.user.phone! : "" ,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(11, 64, 71, 0.8),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0,),

                                    Row(
                                      children: const [
                                        Text(
                                          "Password:  ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(11, 64, 71, 0.8),
                                              fontSize: 16.0
                                          ),
                                        ),
                                        Text(
                                          "**********",
                                          style: TextStyle(
                                            color: Color.fromRGBO(11, 64, 71, 0.8),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0,),

                                    const Divider(),
                                    const SizedBox(height: 10.0),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 40,
                                          // width: 100,
                                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            color: (controller.user.isVerified == true)
                                                ? const Color.fromRGBO(28, 166, 0, 0.2)
                                                : const Color.fromRGBO(250, 127, 120, 0.2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              (controller.user.isVerified == true) ? "Verified" : "Not verified",
                                              style: TextStyle(
                                                color: (controller.user.isVerified == true)
                                                    ? Colors.green[600]
                                                    : Colors.red[600],
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Visibility(
                                          visible: !_punterStateController.user.isVerified!,
                                          child: GetBuilder<AuthStateController>(builder: (controller) {
                                              return TextButton(
                                                onPressed: (){
                                                  _authStateController.sendVerificationOTP();
                                                },
                                                child: (_authStateController.isLoading)
                                                    ? (
                                                          const SizedBox(
                                                            height: 20.0,
                                                            width: 20.0,
                                                            child: CircularProgressIndicator(
                                                              color: Color.fromRGBO(11, 64, 71, 0.8),
                                                              semanticsLabel: "Please wait.",
                                                              strokeWidth: 3.0,
                                                            ),
                                                          )
                                                      )
                                                    : (
                                                          const Text(
                                                            "Verify",
                                                            style: TextStyle(
                                                                color: Color.fromRGBO(11, 64, 71, 0.8),
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          )
                                                      )
                                              );
                                            }
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : Column(
                      //  Edit View
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 120.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(99, 162, 166, 0.76),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: (controller.pickedFile != null)
                                              ? FileImage(controller.pickedFile!)
                                              : (controller.user.picture != null)
                                              ? NetworkImage(controller.user.picture!)
                                              : const AssetImage("./assets/images/profile.png") as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                    ),
                                    child: null,
                                  ),

                                  Positioned(
                                    bottom: 10.0,
                                    right: 0.0,
                                    child: Container(
                                      height: 30.0,
                                      width: 30.0,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(11, 64, 71, 1.0),
                                        shape: BoxShape.circle
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          ShowSelectAvatarBottomSheetWidget.showSelectAvatarBottomSheet("Punter");
                                        },
                                        icon: const Icon(
                                          Iconsax.image,
                                          color: Colors.white,
                                          size: 15.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 6,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 20.0,),

                                TextFormField(
                                  controller: controller.nameTextEditingController,
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: 'Name is required.'),
                                  ]),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: const TextStyle(
                                      color: Color.fromRGBO(11, 64, 71, 0.5),
                                      fontSize: 14.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(11, 64, 71, 0.3),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(11, 64, 71, 0.5),
                                          width: 2.0
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0.0,
                                      horizontal: 20.0,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Color.fromRGBO(11, 64, 71, 0.8),
                                  ),
                                  textCapitalization: TextCapitalization.words,
                                ),
                                const SizedBox(height: 20.0,),

                                Container(
                                  height: 50,
                                  width: Get.width,
                                  padding: const EdgeInsets.only(left: 18.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(11, 64, 71, 0.3),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.user.email!,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(75, 75, 75, 0.5),
                                          fontSize: 16.0,
                                        ),
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(Get.context!).showSnackBar(
                                              _appSnackBar.snackBar("Sorry you can't change your email, kindly contact us at help@superpunter.com.", "Info"),
                                          );
                                        },
                                        icon: const Icon(
                                          Iconsax.info_circle,
                                          color: Color.fromRGBO(11, 64, 71, 0.5),
                                          size: 20.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20.0,),

                                TextFormField(
                                  controller: controller.phoneTextEditingController,
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: 'Phone is required.'),
                                  ]),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Phone',
                                    hintStyle: const TextStyle(
                                      color: Color.fromRGBO(11, 64, 71, 0.5),
                                      fontSize: 14.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(11, 64, 71, 0.3),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(11, 64, 71, 0.5),
                                          width: 2.0
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0.0,
                                      horizontal: 20.0,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Color.fromRGBO(11, 64, 71, 0.8),
                                  ),
                                ),
                                const SizedBox(height: 20.0,),

                                TextFormField(
                                  controller: controller.passwordTextEditingController,
                                  /*validator: MultiValidator([
                                    RequiredValidator(errorText: 'Password is required'),
                                    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
                                    PatternValidator(r'^[a-zA-Z0-9]{6,30}$', errorText: 'Passwords must have at least one special character')
                                  ]),*/
                                  obscureText: controller.hidePassword,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                      color: Color.fromRGBO(11, 64, 71, 0.5),
                                      fontSize: 14.0,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.updateHidePassword();
                                      },
                                      icon: Icon(controller.hidePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                        color: const Color.fromRGBO(11, 64, 71, 0.8),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(11, 64, 71, 0.3),
                                        ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(11, 64, 71, 0.5),
                                        width: 2.0
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                                  ),
                                  style: const TextStyle(
                                    color: Color.fromRGBO(11, 64, 71, 0.8),
                                  ),
                                ),

                                Expanded(
                                  child: Container(),
                                ),


                                //  Cancel & Submit Button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextButton(
                                        onPressed: () {
                                          controller.updateIsEditUser(false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(0.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            side: const BorderSide(
                                              color: Color.fromRGBO(11, 64, 71, 0.3),
                                            ),
                                          ),
                                        ),
                                        child: Ink(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50.0),
                                              color: Colors.white,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12.0,
                                            horizontal: 0.0,
                                          ),
                                          child: const Text(
                                            "Cancel.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xff06353C),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10.0,),

                                    Expanded(
                                      flex: 3,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          (_formKey.currentState!.validate()) ? (
                                              controller.updateUser()
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
                                            color: const Color.fromRGBO(11, 64, 71, 1.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12.0,
                                            horizontal: 0.0,
                                          ),
                                          child: Text(
                                            (!controller.isLoading) ? "Update" : "Loading...",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15.0,),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
            );
          }
          ),
        ),

      floatingActionButton: GetBuilder<PunterStateController>(builder: (controller) {
          return Visibility(
            visible: !controller.isEditUser,
            child: FloatingActionButton(
              onPressed: () {
                controller.updateIsEditUser(true);
              },
              backgroundColor: const Color.fromRGBO(11, 64, 71, 1.0),
              child: const Icon(Iconsax.user_edit),
            ),
          );
        }
      ),
    );
  }
}
