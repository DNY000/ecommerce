import 'package:app1/data/repositories/authentication/authentication_repository.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:app1/ultis/device/device.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/signup/very_email_controller.dart';

class VeryEmailScreen extends StatelessWidget {
  const VeryEmailScreen({super.key, this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VeryEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage(TImages.adidas2),
                height: TDevice.getScreenHeight(context) / 3,
                width: TDevice.getScreenWidth(context) * 0.6,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Verify email',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'We have sent you an email with a link to verify your account. Please check your email and click the link to verify your account.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.checkEmailVerificationStatus();
                    },
                    child: const Text('Verify email')),
              ),
              TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: const Text('Resend email'))
            ],
          ),
        ),
      ),
    );
  }
}
