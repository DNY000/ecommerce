import 'package:app1/common/widgets/shimmers/shimmer.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TRounderImage extends StatelessWidget {
  const TRounderImage(
      {super.key,
      this.height,
      this.width,
      this.padding = const EdgeInsetsDirectional.all(0),
      this.border,
      this.isNetworkImage = false,
      required this.image,
      this.fit = BoxFit.cover,
      this.applyRadiusImage = true,
      this.onPressed,
      this.isColorImage = false,
      this.backgroundColor = Colors.white,
      this.borderRadius = TSizes.m});

  final double? height, width;
  final EdgeInsetsDirectional padding;
  final BoxBorder? border;
  final bool isNetworkImage;
  final String image;
  final BoxFit? fit;
  final bool applyRadiusImage;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final bool isColorImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
            borderRadius: applyRadiusImage
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero,
            child: isNetworkImage
                ? CachedNetworkImage(
                    imageUrl: image,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    progressIndicatorBuilder: (context, url, progress) =>
                        const TShimmerEffect(width: 55, height: 55),
                  )
                : Image(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  )),
      ),
    );
  }
}
