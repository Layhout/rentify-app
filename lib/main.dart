import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify_app/config/di.dart';
import 'package:rentify_app/config/eager_init_provider.dart';
import 'package:rentify_app/common_widgets/theme/app_theme.dart';
import 'package:rentify_app/routing/router.dart';
import 'package:rentify_app/utils/provider_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di();

  runApp(ProviderScope(observers: [AppObserver()], child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return EagerInitProvider(
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router,
      ),
    );
  }
}
