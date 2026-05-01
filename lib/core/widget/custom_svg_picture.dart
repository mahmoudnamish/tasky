import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  CustomSvgPicture({
    super.key,
    required this.path,
    this.withColorFilter = true,
    this.width,
    this.height,
  });

  CustomSvgPicture.withoutColor({
    super.key,
    required this.path,
    this.width,
    this.height,
  }) : withColorFilter = false;
  final String path;
  final bool withColorFilter;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      colorFilter: withColorFilter
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
