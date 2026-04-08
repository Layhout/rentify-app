import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/avatar.dart';
import 'package:rentify_app/common_widgets/tag.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: "https://picsum.photos/300/200",
                fit: BoxFit.cover,
              ).size(height: 200, width: double.infinity),
              Positioned(
                top: AppConstants.spacingMD,
                left: AppConstants.spacingMD,
                child: Tag(
                  color: context.colorScheme.primaryContainer,
                  child: Text(
                    "FEATURED",
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Canon EOS R5 Camera Kit",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                  ).expanded(),
                  Tag(
                    color: context.colorScheme.surfaceContainerHighest,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: AppConstants.spacingMD,
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                        context.gapXS,
                        Text("4.8", style: context.textTheme.labelMedium),
                      ],
                    ),
                  ),
                ],
              ),
              context.gapXS,
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: AppConstants.spacingMD,
                    color: context.colorScheme.outline,
                  ),
                  context.gapXS,
                  Text(
                    "0.5 km away",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ),
                ],
              ),
              context.gapLG,
              Row(
                children: [
                  Avatar(
                    url: "https://picsum.photos/100/100",
                    name: "Layhout Chea",
                    width: AppConstants.spacingLG,
                    height: AppConstants.spacingLG,
                  ),
                  context.gapSM,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "John Doe • "),
                        TextSpan(
                          text: "Verified",
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.outline,
                      fontWeight: FontWeight.bold,
                    ),
                  ).expanded(),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "\$25",
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        TextSpan(text: "/day"),
                      ],
                    ),
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ).paddingAll(AppConstants.spacingMD),
        ],
      ),
    ).paddingSymmetric(horizontal: AppConstants.spacingMD);
  }
}
