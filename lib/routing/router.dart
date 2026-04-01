import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rentify_app/config/providers/auth_listener/auth_listener_provider.dart';
import 'package:rentify_app/routing/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authListenerProvider, (previous, next) async {
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();
    });
  }
}

@riverpod
GoRouter router(Ref ref) {
  final notifier = RouterNotifier(ref);

  return GoRouter(
    refreshListenable: notifier,
    initialLocation: Routes.splash,
    redirect: (context, state) {
      final authState = ref.read(authListenerProvider);

      if (authState.isLoading) return Routes.splash;

      final isLoggedIn = authState.session != null;
      final isOnAuthRoute = state.matchedLocation == Routes.login;

      if (!isLoggedIn && !isOnAuthRoute) return Routes.login;
      if (isLoggedIn && isOnAuthRoute) return Routes.home;
      return null; // no redirect
    },
    routes: $appRoutes,
  );
}
