import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/menu_chip.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: "Best Match"),
              Tab(text: "Items"),
              Tab(text: "Services"),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMD,
              vertical: AppConstants.spacingSM,
            ),
            child: Row(
              spacing: AppConstants.spacingSM,
              children: [
                MenuChip(
                  label: "Price",
                  options: ["High to Low", "Low to High"],
                  onSelected: (value) {},
                ),
                MenuChip(label: "Date", options: ["Newest", "Oldest"], onSelected: (value) {}),
                MenuChip(
                  label: "Rating",
                  options: ["5 Star", "4 Star", "3 Star", "2 Star", "1 Star"],
                  onSelected: (value) {},
                ),
              ],
            ),
          ),
          TabBarView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppConstants.spacingSM,
                children: [
                  Text(
                    "10 RESULTS FOUND",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ).paddingSymmetric(horizontal: AppConstants.spacingMD),
                  RefreshIndicator.adaptive(
                    onRefresh: () async {},
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        bottom: AppConstants.spacingMD,
                        left: AppConstants.spacingMD,
                        right: AppConstants.spacingMD,
                      ),
                      itemBuilder: (_, i) {
                        return ResultItem(i: i);
                      },
                      separatorBuilder: (_, _) => context.gapMD,
                      itemCount: 10,
                    ),
                  ).expanded(),
                ],
              ),
              Text("Items"),
              Text("Services"),
            ],
          ).expanded(),
        ],
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  const ResultItem({super.key, required this.i});

  final int i;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Row(
        spacing: AppConstants.spacingMD,
        children: [
          CachedNetworkImage(
            imageUrl: "https://picsum.photos/400/400?random=$i",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Column(
            spacing: AppConstants.spacingXS,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lorem ipsum $i",
                style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                spacing: AppConstants.spacingXS,
                children: [
                  Text(
                    "John Doe",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    size: AppConstants.spacingMD,
                    color: context.colorScheme.primary,
                  ),
                ],
              ),
              Row(
                spacing: AppConstants.spacingXS,
                children: [
                  Icon(
                    Icons.star,
                    size: AppConstants.spacingMD,
                    color: context.colorScheme.primary,
                  ),
                  Text(
                    "4.5 (100)",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ),
                  Text(
                    "·",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ),
                  Text(
                    "5 km away",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ),
                ],
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "\$38",
                      style: context.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    TextSpan(
                      text: "/day",
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
