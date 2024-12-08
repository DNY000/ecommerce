import 'package:app1/common/widgets/texts/product_title.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/features/shop/screens/product_detail/widgets/bottom_add_cart.dart';
import 'package:app1/features/shop/screens/product_detail/widgets/produc_detail_image.dart';
import 'package:app1/features/shop/screens/product_detail/widgets/product_attributed.dart';
import 'package:app1/features/shop/screens/product_detail/widgets/product_meta_data.dart';
import 'package:app1/features/shop/screens/product_detail/widgets/rating_and_share.dart';
import 'package:app1/features/shop/screens/product_reviews/product_reviews_screen.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:app1/ultis/constants/enum.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    return Scaffold(
        bottomNavigationBar: TBottomAddCart(product: productModel),
        body: SingleChildScrollView(
            child: Column(children: [
          //header //
          ProductDetailImage(
            productModel: productModel,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const TRatingAndShare(),
                ProductMetaData(
                  productModel: productModel,
                ),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                if (productModel.productType == ProductType.variable.name)
                  TProductAttributed(
                    productModel: productModel,
                  ),
                if (productModel.productType == ProductType.variable.name)
                  const SizedBox(
                    height: 24,
                  ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                dark ? Colors.grey.shade400 : Colors.blue),
                        onPressed: () {},
                        child: const Text('Checkout'))),
                const SizedBox(
                  height: 24,
                ),
                ReadMoreText(
                  'Đây là một sản phẩm mới ra mắt đầu năm 2024 của hãng sản xuất giày hàng đầu thế giới là Nike . Nike đã có tên tuổi hàng trăm năm nay trong việc bán giày sản phẩm của Nike được phân phối trên toàn thế giới',
                  style: TextStyle(
                    color: dark ? Colors.white : Colors.black,
                  ),
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: "less",
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  lessStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ProductTitle(
                      title: "Review(199)",
                    ),
                    IconButton(
                        onPressed: () {
                          Get.to(const ProductReviewsScreen());
                        },
                        icon: const Icon(FontAwesomeIcons.angleRight))
                  ],
                )
              ],
            ),
          )
        ])));
  }
}
