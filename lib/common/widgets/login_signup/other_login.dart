// ignore: unused_import
import 'package:app1/data/services/firebase_service/firebase_auth_service/firebase_auth_service.dart';
import 'package:app1/features/authentication/controller/signin/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OrtherLogin extends StatelessWidget {
  Color color1;
  OrtherLogin({super.key, required this.color1, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Flexible(
                  flex: 1,
                  child: Divider(
                    thickness: 1,
                    color: color1,
                  )),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: color1),
              ),
              Flexible(
                  child: Divider(
                thickness: 1,
                color: color1,
              )),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                    onPressed: () {
                      // TFirebaseAuthService().signInWithFacebook();
                    },
                    icon: const Icon(FontAwesomeIcons.facebook)),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                    onPressed: () => controller.signInWithGoogle(),
                    icon: const Icon(FontAwesomeIcons.google,
                        color: Colors.redAccent)),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.twitter,
                        color: Colors.blueAccent)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
