import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/features/home/ui/widgets/favorite_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/home_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/new_item_form_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/profile_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/search_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/bottom_nav_bar.dart';

final homeNavStacks = <NavigationDestination>[
  NavigationDestination(label: "Home", icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home)),
  NavigationDestination(label: "Search", icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search)),
  NavigationDestination(label: "New", icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle)),
  NavigationDestination(label: "Favorite", icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite)),
  NavigationDestination(label: "Profile", icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person)),
];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentPageIndex == 0
          ? AppBar(
              title: Text(
                "Rentify",
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [IconButton(icon: Icon(Icons.notifications), onPressed: () {})],
            )
          : null,
      bottomNavigationBar: BottomNavBar(
        destinations: homeNavStacks,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: homeNavStacks
            .map(
              (stack) => switch (stack.label) {
                'Home' => HomeTab(
                  onSearchTap: () {
                    setState(() {
                      _currentPageIndex = 1;
                    });
                  },
                ),
                'Search' => SearchTab(),
                'New' => NewItemFormTab(),
                'Favorite' => FavoriteTab(),
                'Profile' => ProfileTab(),
                _ => const SizedBox.shrink(),
              },
            )
            .toList(),
      ),
    );
  }
}
