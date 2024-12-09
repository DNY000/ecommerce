import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/login_signup/other_login.dart';
import 'package:app1/features/authentication/screens/signup/widgets/form_signup.dart';
import 'package:flutter/material.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Sign up')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const FormSignUp(),
              OrtherLogin(color1: Colors.black, text: 'Or sign up with')
            ],
          ),
        ),
      ),
    );
  }
}
