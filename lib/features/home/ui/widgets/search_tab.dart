import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/features/home/ui/widgets/search_field.dart';
import 'package:rentify_app/features/home/ui/widgets/search_result.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchField(onSearch: (value) {}).paddingSymmetric(horizontal: AppConstants.spacingMD),
        context.gapMD,
        SearchResult().expanded(),
      ],
    ).safeArea(bottom: false);
  }
}
