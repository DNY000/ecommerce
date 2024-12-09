import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/features/authentication/controller/forgot_password/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                'Forgot password',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text(
                  "Don't worry! It occurs. Enter your email and we will send you a link to reset your password."),
              const SizedBox(
                height: 12,
              ),
              Form(
                key: controller.forgotPasswordFormKey,
                child: TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: 'email',
                    suffixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.forgotPassword();
                    },
                    child: const Text('Submit')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
