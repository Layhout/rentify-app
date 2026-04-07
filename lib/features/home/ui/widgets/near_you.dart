import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/skeleton.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';

class NearYou extends StatelessWidget {
  const NearYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Near you", style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)).expanded(),
            TextButton(onPressed: () {}, child: Text("See all")),
          ],
        ).paddingOnly(left: AppConstants.spacingMD),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.spacingMD),
          itemBuilder: (_, i) {
            return Card(
              margin: EdgeInsets.only(bottom: 5),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    height: 120,
                    imageUrl: "https://picsum.photos/400/300?random=$i",
                    placeholder: (_, _) => Skeleton(),
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lorem ipsum $i",
                        style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      context.gapSM,
                      Text(
                        "\$$i/day",
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ).paddingAll(AppConstants.spacingSM),
                ],
              ),
            ).size(width: 160, height: 180);
          },
          separatorBuilder: (_, _) => context.gapMD,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
        ).size(height: 185),
      ],
    );
  }
}
