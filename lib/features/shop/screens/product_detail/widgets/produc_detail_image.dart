import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/images/t_rouded_image.dart';
import 'package:app1/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:app1/features/shop/controllers/products/image_product_controller.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/features/shop/screens/product_detail/widgets/show_picture_product.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/curve_edges/curve_edges_widget.dart';

class ProductDetailImage extends StatelessWidget {
  const ProductDetailImage({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final bool dark = TheplerFunction.isDarkMode(context);
    final controller = Get.put(ImageProductController());
    final images = controller.getAllImageProduct(productModel);
    return TCurveEdgesWidget(
      child: Container(
        color: dark ? Colors.grey : Colors.white,
        child: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Obx(
                  () {
                    final image = controller.getCurrentIndex.value;
                    return GestureDetector(
                      onTap: () {
                        Get.dialog(ShowPictureProduct(imageProduct: images));
                      },
                      child: Image(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        color: Colors.grey.shade50,
                        colorBlendMode: BlendMode.modulate,
                        //áp dụng bộ lọc màu
                      ),
                    );
                  },
                ))),
            Positioned(
              right: 20,
              bottom: 30,
              left: 20,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,

                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Obx(() {
                    final imageSelected =
                        controller.getCurrentIndex.value == images[index];
                    return TRounderImage(
                      // padding: const EdgeInsetsDirectional.symmetric(
                      //     horizontal: TSizes.borderRaidusM),
                      height: 80,
                      width: 90,
                      border: Border.all(
                          color: imageSelected
                              ? Colors.black.withOpacity(0.2)
                              : Colors.transparent),
                      image: images[index],
                      fit: BoxFit.cover,
                      onPressed: () {
                        controller.getCurrentIndex.value = images[index];
                      },
                    );
                  }),
                  separatorBuilder: (_, __) => const SizedBox(
                    width: TSizes.defaulBtwItem,
                  ),
                  itemCount: images.length,
                  //body
                  //footer
                ),
              ),
            ),
            //app bar
            TAppBar(
              title: Text('',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: Colors.white)),
              showBackArrow: true,
              action: [
                FavouriteIcon(productId: productModel.id),
              ],
            )
          ],
        ),
      ),
    );
  }
}
