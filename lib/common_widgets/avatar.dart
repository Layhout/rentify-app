import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/utils/extension/string.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.url, this.name, this.width = 40, this.height = 40});

  final String url;
  final String? name;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorScheme.outlineVariant,
      foregroundImage: CachedNetworkImageProvider(url),
      child: Text((name ?? "").initials, style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
    ).size(width: width, height: height);
  }
}
