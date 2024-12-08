import 'package:app1/common/widgets/login_signup/other_login.dart';
import 'package:app1/features/authentication/screens/login/widgets/form_login.dart';
import 'package:app1/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoginHeader(),
              const SizedBox(height: 30),
              const TFormLogin(),
              const SizedBox(height: 30),
              OrtherLogin(
                  color1: Colors.black.withOpacity(0.5),
                  text: 'Or sign in with')
            ],
          ),
        ),
      ),
    );
  }
}
