import 'package:app1/features/authentication/screens/signup/widgets/singup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../ultis/validators/validation.dart';
import '../../../controller/signin/login_controller.dart';
import '../../password_configuration/forgot_password.dart';

class TFormLogin extends StatelessWidget {
  const TFormLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email), labelText: 'E-Mail'),
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
              validator: (value) => TValidation.emailValidator(value ?? ''),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(() => TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.security),
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.isShowPassword.value =
                                !controller.isShowPassword.value;
                          },
                          icon: controller.isShowPassword.value
                              ? const Icon(FontAwesomeIcons.eyeSlash)
                              : const Icon(FontAwesomeIcons.eye)),
                      labelText: 'Password'),
                  obscureText: !controller.isShowPassword.value,
                  controller: controller.passwordController,
                  validator: (value) =>
                      TValidation.validatePasswordWithLogin(value ?? ''),
                )),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.rememberMe.value =
                                !controller.rememberMe.value;
                          },
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text('Remember me'),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Get.to(() => const ForgotPasswordScreen(
                            email: '',
                          ));
                    },
                    child: const Text('Forgot password?'))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                      color: Colors.transparent,
                    )),
                    onPressed: () {
                      controller.signInEmailWithPassword();
                    },
                    child: const Text('Sign In'))),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black.withOpacity(0.3)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Get.to(() => const SingupScreen());
                    },
                    child: const Text(
                      'Create account',
                      style: TextStyle(color: Colors.black),
                    ))),
          ],
        ));
  }
}
