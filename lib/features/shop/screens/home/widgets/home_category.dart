import 'package:app1/common/widgets/image_text_widget/image_text_widget.dart';
import 'package:app1/common/widgets/shimmers/category_shimmer.dart';
import 'package:app1/features/shop/controllers/category/category_controller.dart';
import 'package:app1/features/shop/screens/sub_category/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeCategory extends StatelessWidget {
  const THomeCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(
      () {
        if (categoryController.isLoading.value) {
          return const TCategoryShimmers(itemCount: 3);
        }
        if (categoryController.allCategory().isEmpty) {
          return const Center(
            child: Text('Không tìm thấy dữ liệu'),
          );
        }
        return SizedBox(
            height: 80,
            child: ListView.builder(
                itemCount: categoryController.allCategory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final categories = categoryController.allCategory[index];

                  return TVerticalImageText(
                    isNetworkImage: false,
                    title: categories.name,
                    image: categories.image,
                    onTap: () {
                      Get.to(
                        SubCategoryScreen(category: categories),
                        duration: const Duration(seconds: 1),
                        //  transition: Transition.cupertino
                      );
                    },
                  );
                }));
      },
    );
  }
}
