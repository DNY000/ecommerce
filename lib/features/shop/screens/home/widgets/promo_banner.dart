import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/images/t_rouded_image.dart';
import 'package:app1/common/widgets/shimmers/shimmer.dart';
import 'package:app1/features/shop/controllers/banner/banner_controller.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BannerController controller = Get.put(BannerController());
    return Obx(
      () {
        if (controller.isLoading.value) {
          return const TShimmerEffect(width: 200, height: 180);
        }
        if (controller.banners.isEmpty) {
          return const Center(
            child: Text('no data '),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      controller.upLoadIndexPage(index);
                    },
                    autoPlay: true,
                    enlargeCenterPage: true,
                    pauseAutoPlayOnTouch: true,
                    autoPlayAnimationDuration: const Duration(seconds: 3)),
                items: controller.banners
                    .map(
                      (banner) => TRounderImage(
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: banner.imageURL,
                        isNetworkImage: true,
                        onPressed: () {
                          Get.toNamed(banner.targetScreen);
                        },
                      ),
                    )
                    .toList()),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) {
                    return TCircularContainer(
                      width: 8,
                      height: 8,
                      margin: 5,
                      border: controller.currentIndex.value == index
                          ? null
                          : Border.all(color: Colors.black),
                      background: controller.currentIndex.value == index
                          ? Colors.green
                          : Colors.grey.shade300,
                    );
                  },
                )),
          ]),
        );
      },
    );
  }
}
