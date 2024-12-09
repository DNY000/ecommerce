// ignore: unused_import
import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/ultis/device/device.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onPressed,
      this.nameButton = 'Tiếp tục',
      this.isLottie = false});
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final String nameButton;
  final bool isLottie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLottie
                  ? Lottie.asset(image,
                      height: TDevice.getScreenHeight(context) * 0.35,
                      width: TDevice.getScreenWidth(context) * 0.8,
                      fit: BoxFit.cover,
                      repeat: true)
                  : Image(
                      image: AssetImage(image),
                      height: TDevice.getScreenHeight(context) * 0.35,
                      width: TDevice.getScreenWidth(context) * 0.8,
                    ),
              const SizedBox(
                height: 12,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: onPressed, child: Text(nameButton)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
