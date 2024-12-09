import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/texts/t_brand_title_with_icon.dart';
import 'package:app1/features/shop/models/brand_model.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';

class TBandCart extends StatelessWidget {
  const TBandCart({
    super.key,
    this.showBorder = false,
    this.onPressed,
    required this.brandModel,
  });
  final BrandModel brandModel;
  final bool showBorder;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: TCircularContainer(
        padding: 12,
        isShowBorder: showBorder ? true : false,
        radius: 20,
        background: Colors.transparent,
        height: 70,
        margin: 0,
        child: Row(
          children: [
            Flexible(
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: TheplerFunction.isDarkMode(context)
                      ? Colors.black
                      : Colors.white,
                  borderRadius: showBorder
                      ? BorderRadius.circular(20)
                      : BorderRadius.zero,
                ),
                child: Image(
                  image: AssetImage(brandModel.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: TSizes.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TBrandTitleWithIcon(
                    title: brandModel.name,
                  ),
                  Text(
                    '${brandModel.productsCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
