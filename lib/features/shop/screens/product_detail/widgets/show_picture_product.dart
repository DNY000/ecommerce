import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ShowPictureProduct extends StatelessWidget {
  const ShowPictureProduct({
    super.key,
    required this.imageProduct,
    this.intitalPage = 0,
  });

  final List<String> imageProduct;
  final int intitalPage;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: intitalPage);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: controller,
            itemCount: imageProduct.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(imageProduct[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
          Positioned(
            left: 2,
            top: 5,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                FontAwesomeIcons.angleLeft,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
