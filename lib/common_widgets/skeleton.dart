import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.height = double.infinity, this.width = double.infinity, this.radius});

  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
      highlightColor: context.colorScheme.outlineVariant,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: context.colorScheme.surface, borderRadius: BorderRadius.circular(radius ?? 0)),
      ),
    );
  }
}
