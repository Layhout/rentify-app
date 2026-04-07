import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/utils/extension/string.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key, required this.name, required this.onSearchTap});

  final String name;
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name.greeting, style: context.textTheme.titleSmall),
        context.gapXS,
        Text("What do you need?", style: context.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
        context.gapLG,
        InkWell(
          onTap: onSearchTap,
          child: Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: AppConstants.spacingMD, vertical: AppConstants.spacingSM),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius: context.radiusFull,
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withValues(alpha: 0.1),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: context.colorScheme.outline),
                context.gapSM,
                Text(
                  "Search items & services...",
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
                ),
              ],
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: AppConstants.spacingMD);
  }
}
