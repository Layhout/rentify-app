import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/features/home/ui/widgets/favorite_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/home_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/new_item_form_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/profile_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/search_tab.dart';
import 'package:rentify_app/features/home/ui/widgets/bottom_nav_bar.dart';

typedef HomeNavStack = ({NavigationDestination destination, Widget widget});

final homeNavStacks = <HomeNavStack>[
  (
    destination: NavigationDestination(label: "Home", icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home)),
    widget: HomeTab(),
  ),
  (
    destination: NavigationDestination(
      label: "Search",
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search),
    ),
    widget: SearchTab(),
  ),
  (
    destination: NavigationDestination(
      label: "New",
      icon: Icon(Icons.add_circle_outline),
      selectedIcon: Icon(Icons.add_circle),
    ),
    widget: NewItemFormTab(),
  ),
  (
    destination: NavigationDestination(
      label: "Favorite",
      icon: Icon(Icons.favorite_outline),
      selectedIcon: Icon(Icons.favorite),
    ),
    widget: FavoriteTab(),
  ),
  (
    destination: NavigationDestination(
      label: "Profile",
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
    ),
    widget: ProfileTab(),
  ),
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
      appBar: AppBar(
        title: Text(
          "Rentify",
          style: context.textTheme.labelLarge?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(icon: Icon(Icons.notifications), onPressed: () {})],
      ),
      bottomNavigationBar: BottomNavBar(
        destinations: homeNavStacks.map((stack) => stack.destination).toList(),
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      body: IndexedStack(index: _currentPageIndex, children: homeNavStacks.map((stack) => stack.widget).toList()),
    );
  }
}
