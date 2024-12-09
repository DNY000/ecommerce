import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../ultis/validators/validation.dart';
import '../../../controller/signup/signup_controller.dart';

class FormSignUp extends StatelessWidget {
  const FormSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidation.nameValidator('First name', value),
                    decoration: const InputDecoration(
                      label: Text('Firt name'),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    decoration: const InputDecoration(
                      label: Text('Last name'),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) =>
                        TValidation.nameValidator('Last name', value),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller.userName,
              validator: (value) => TValidation.nameValidator('', value),
              decoration: const InputDecoration(
                label: Text('Username'),
                prefixIcon: Icon(Iconsax.user_edit),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidation.emailValidator(value ?? ''),
              decoration: const InputDecoration(
                label: Text('Email'),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) => TValidation.phoneValidator(value ?? ''),
              controller: controller.numberPhone,
              decoration: const InputDecoration(
                label: Text('phone'),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hintPassword.value,
                validator: (value) => TValidation.validatePassword(value ?? ''),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () => controller.hintPassword.value =
                          !controller.hintPassword.value,
                      icon: Icon(controller.hintPassword.value
                          ? Iconsax.eye
                          : Iconsax.eye_slash)),
                  label: const Text('Password'),
                  prefixIcon: const Icon(Iconsax.password_check),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Obx(() => Checkbox(
                      value: controller.privacyPolicy.value,
                      onChanged: (value) {
                        controller.privacyPolicy.value = value!;
                      })),
                ),
                const SizedBox(width: 12),
                Text.rich(TextSpan(children: [
                  const TextSpan(
                      text: 'I agree to ',
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(
                      text: 'privacy policy',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? Colors.white : Colors.grey.shade500,
                          color: dark ? Colors.white : Colors.grey.shade500)),
                  TextSpan(
                      text: ' and ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? Colors.white : Colors.grey.shade500)),
                  TextSpan(
                      text: 'terms of service',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? Colors.white : Colors.grey.shade500,
                          color: dark ? Colors.white : Colors.grey.shade500))
                ]))
              ],
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.signup();
                    },
                    child: const Text('Sign up'))),
          ],
        ));
  }
}
