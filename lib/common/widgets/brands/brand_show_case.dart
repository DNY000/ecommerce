import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/brands/t_band_cart.dart';
import 'package:app1/features/shop/models/brand_model.dart';
import 'package:app1/features/shop/screens/brand/brand_product.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBandShowCase extends StatelessWidget {
  const TBandShowCase({
    super.key,
    required this.brandModel,
    required this.listImage,
  });
  final List<String> listImage;
  final BrandModel brandModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProduct(brandModel: brandModel)),
      child: TCircularContainer(
          height: 180,
          isShowBorder: true,
          background: Colors.transparent,
          margin: 10,
          radius: 20,
          child: Column(
            children: [
              TBandCart(
                showBorder: true,
                brandModel: brandModel,
              ),
              Row(
                  children: listImage
                      .map(
                        (images) => brandTopProductImageWidget(images, context),
                      )
                      .toList())
            ],
          )),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: TCircularContainer(
        height: 80,
        padding: 10,
        margin: 5,
        radius: 20,
        background:
            TheplerFunction.isDarkMode(context) ? Colors.grey : Colors.white,
        child: Image(
          image: AssetImage(brandModel.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
