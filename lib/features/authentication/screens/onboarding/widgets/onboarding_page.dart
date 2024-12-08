//import 'package:app1/ultis/device/device.dart';
import 'package:flutter/material.dart';

class OnBoadingPage extends StatelessWidget {
  const OnBoadingPage({
    super.key,
    required this.image,
    this.title,
    this.description,
  });
  final String image;
  final String? title;
  final String? description;
  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20),
    //   child: Column(
    //     children: [
    //       Image(
    //           height: TDevice.getScreenHeight(context) * 0.6,
    //           width: TDevice.getScreenWidth(context) * 0.6,
    //           image: AssetImage(
    //             image,
    //           )),
    //       Text(
    //         title??'',
    //         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Text(
    //         description??'',
    //         style: const TextStyle(fontSize: 16, color: Colors.grey),
    //       )
    //     ],
    //   ),
    // );
    return Stack(
        children: [Positioned.fill(child: Image(image: AssetImage(image)))]);
  }
}
