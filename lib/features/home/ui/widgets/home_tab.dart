import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/features/home/provider/home_view_model.dart';
import 'package:rentify_app/features/home/ui/widgets/feature_card.dart';
import 'package:rentify_app/features/home/ui/widgets/greeting.dart';
import 'package:rentify_app/features/home/ui/widgets/near_you.dart';
import 'package:rentify_app/features/home/ui/widgets/popular_services.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key, required this.onSearchTap});

  final VoidCallback onSearchTap;

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
                Greeting(name: name, onSearchTap: onSearchTap),
                context.gapLG,
                FeatureCard(),
                context.gapMD,
                NearYou(),
                context.gapSM,
                PopularServices(),
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
