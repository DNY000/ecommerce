import 'package:app1/common/widgets/images/t_rouded_image.dart';
import 'package:app1/common/widgets/texts/t_brand_title_with_icon.dart';
import 'package:flutter/material.dart';

import '../../../../features/shop/models/cart_item_model.dart';

class TDetailOnlyItemsCart extends StatelessWidget {
  const TDetailOnlyItemsCart({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TRounderImage(
              height: 80,
              width: 40,
              padding: EdgeInsetsDirectional.all(12),
              fit: BoxFit.cover,
              // isNetworkImage: true,
              image: cartItem.image ?? ''),
        ),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TBrandTitleWithIcon(title: cartItem.brandName ?? ''),
              Text(
                cartItem.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text.rich(TextSpan(
                  children: (cartItem.selectedAttributes ?? {})
                      .entries
                      .map((e) => TextSpan(
                            children: [
                              TextSpan(text: '${e.key}: '),
                              TextSpan(text: e.value),
                            ],
                          ))
                      .toList()))
            ],
          ),
        ),
      ],
    );
  }
}
