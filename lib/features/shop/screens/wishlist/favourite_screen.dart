import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/icons/t_circular_icon.dart';
import 'package:app1/common/widgets/layout/t_gird_product.dart';
import 'package:app1/common/widgets/products/product_cart/custom_list_cart.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:app1/ultis/navigator_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/favorites/favorites_controller.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Yêu thích',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        action: [
          TCircularIcon(
            icon: const Icon(FontAwesomeIcons.plus),
            iconColor: Colors.black,
            onPressed: () {
              Get.to((const NavigatorMenu()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              future: controller.getFavouritesProduct(),
              builder: (context, snapshot) {
                // final empty = TAnimationLoader(
                //   animation: TImages.animationLoader,
                //   showAnimation: true,
                //   text: 'Loading...',
                //   onActionPressed: () => Get.off(() => const NavigatorMenu()),
                // );
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('Không có dữ liệu'),
                  );
                }

                final products = snapshot.data!;
                return Column(
                  children: [
                    TGirdProduct(
                      mainAxisExtent: 270,
                      itemCount: products.length,
                      itemBuilder: (_, index) => CustomListCart(
                        products: products[index],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
