import 'package:app1/common/widgets/shimmers/shimmer.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:app1/ultis/constants/tcolor.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.title,
    required this.image,
    this.backgroundColor = Colors.white,
    required this.onTap,
    this.isNetworkImage = false,
    this.textColor = Colors.white,
  });
  final String title, image;
  final Color? backgroundColor;
  final void Function()? onTap;
  final Color textColor;
  final bool isNetworkImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.defaulBtwItem),
        child: Column(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                  //kiem tra backgounfcolor co null hay khong
                  color: backgroundColor ??
                      (TheplerFunction.isDarkMode(context)
                          ? TColor.black
                          : Colors.white),
                  borderRadius: BorderRadius.circular(TSizes.productImageSize)),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: isNetworkImage
                      ? CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                          progressIndicatorBuilder: (context, url, progress) =>
                              const TShimmerEffect(width: 55, height: 55),
                        )
                      : Image(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                          color: Colors.black,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.defaulBtwItem / 2,
            ),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
