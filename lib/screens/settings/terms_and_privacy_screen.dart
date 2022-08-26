import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:super_punter/states/settings_state_controller.dart';

class TermsAndPrivacyScreen extends StatelessWidget {
  TermsAndPrivacyScreen({Key? key}) : super(key: key);

  final SettingsStateController _settingsStateController = Get.put(SettingsStateController());

  @override
  Widget build(BuildContext context) {
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
                  icon: const Icon(Iconsax.arrow_left ),
                  padding: const EdgeInsets.all(0.0),
                  iconSize: 24.0,
                ),
              ),

              const Text(
                "Term & Conditions",
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


      //  Body
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [

            //  Terms Contents.
            Expanded(
              child:
              TabBarView(
                children: [
                  //  Terms
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Terms',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color.fromRGBO(11, 64, 71, 0.8),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),

                        Text(
                          '''These Terms of Service (“Terms”, “Terms of Service”) govern your use of our website located at www.ayambetalent.com (together or individually “Service”) operated by Ayambe pay.

Our Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages.

Your agreement with us includes these Terms and our Privacy Policy (“Agreements”). You acknowledge that you have read and understood Agreements, and agree to be bound of them.

If you do not agree with (or cannot comply with) Agreements, then you may not use the Service, but please let us know by emailing at info@ayambetalent.com so we can try to find a solution. These Terms apply to all visitors, users and others who wish to access or use Service.''',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color.fromRGBO(11, 64, 71, 0.8),
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //  Privacy
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Privacy policy',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color.fromRGBO(11, 64, 71, 0.8),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),

                        Text(
                          '''Our Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages.
                          
By using our Service, you agree to subscribe to newsletters, marketing or promotional materials and other information we may send. However, you may opt out of receiving any, or all, of these communications from us by following the unsubscribe link or by emailing at info@ayambetalent.com.
                          ''',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color.fromRGBO(11, 64, 71, 0.8),
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: Get.width,
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromRGBO(11, 64, 71, 1.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                tabs: const [
                  SizedBox(
                    height: 40.0,
                    child: Tab(
                      child: Text(
                        'Terms',
                        style: TextStyle(
                          color: Color.fromRGBO(99, 162, 166, 1.0),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                    child: Tab(
                      child: Text(
                        'Privacy',
                        style: TextStyle(
                          color: Color.fromRGBO(99, 162, 166, 1.0),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
