import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify_app/common_widgets/avatar.dart';
import 'package:rentify_app/common_widgets/skeleton.dart';
import 'package:rentify_app/common_widgets/tag.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/features/home/provider/home_view_model.dart';
import 'package:rentify_app/utils/extension/string.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return state.when(
      data: (data) {
        final name = data.currentUser?.userMetadata?["name"] as String? ?? "";

        return RefreshIndicator.adaptive(
          onRefresh: () async {},
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: AppConstants.spacingMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name.greeting),
                    context.gapXS,
                    Text(
                      "What do you need?",
                      style: context.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    context.gapLG,
                    Container(
                      clipBehavior: Clip.hardEdge,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.spacingMD,
                        vertical: AppConstants.spacingSM,
                      ),
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
                      child: InkWell(
                        onTap: () {},
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
                    context.gapLG,
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: "https://picsum.photos/300/200",
                                placeholder: (context, url) => Skeleton(),
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
                                    style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
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
                                        Text("4.8", style: context.textTheme.labelLarge),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                    style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.outline),
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
                    ),
                  ],
                ).paddingSymmetric(horizontal: AppConstants.spacingMD),
                context.gapMD,
                Row(
                  children: [
                    Text(
                      "Near you",
                      style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                    ).expanded(),
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
                                style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
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
                context.gapSM,
                Text(
                  "Popular Services",
                  style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
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
                          CachedNetworkImage(
                            imageUrl: "https://picsum.photos/400/400?random=$i",
                            width: 100,
                            height: 100,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Lorem ipsum $i",
                                    style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
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
                                      Icon(
                                        Icons.star,
                                        color: context.colorScheme.primary,
                                        size: AppConstants.spacingMD,
                                      ),
                                      context.gapXS,
                                      Text(
                                        "4.5",
                                        style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                                      ),
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
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const SizedBox.shrink();
      },
      loading: () {
        return const SizedBox.shrink();
      },
    );
  }
}
