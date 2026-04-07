import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';

class PopularServices extends StatelessWidget {
  const PopularServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular Services",
          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ).paddingAll(AppConstants.spacingMD),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: AppConstants.spacingMD),
          itemBuilder: (_, i) {
            return Card(
              clipBehavior: Clip.hardEdge,
              child: Row(
                children: [
                  CachedNetworkImage(imageUrl: "https://picsum.photos/400/400?random=$i", width: 100, height: 100),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Lorem ipsum $i",
                            style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ).expanded(),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "\$$i",
                                  style: context.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                                TextSpan(
                                  text: "/day",
                                  style: context.textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      context.gapXS,
                      Row(
                        children: [
                          Text(
                            "Services Description $i",
                            style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.outline),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).expanded(),
                          Row(
                            children: [
                              Icon(Icons.star, color: context.colorScheme.primary, size: AppConstants.spacingMD),
                              context.gapXS,
                              Text("4.5", style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ).paddingAll(AppConstants.spacingMD).expanded(),
                ],
              ),
            );
          },
          separatorBuilder: (_, _) => context.gapMD,
          itemCount: 5,
        ),
      ],
    );
  }
}
