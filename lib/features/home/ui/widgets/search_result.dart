import 'package:flutter/material.dart';
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
            padding: EdgeInsets.symmetric(horizontal: AppConstants.spacingMD, vertical: AppConstants.spacingSM),
            child: Row(
              children: [
                ActionChip(
                  label: Row(
                    children: [
                      Text("Price"),
                      context.gapXS,
                      Icon(Icons.keyboard_arrow_down, size: AppConstants.spacingMD),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          TabBarView(children: [Text("Best Match"), Text("Items"), Text("Services")]).expanded(),
        ],
      ),
    );
  }
}
