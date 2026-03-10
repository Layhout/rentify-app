import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rentify_app/routing/routes.dart';
import 'package:rentify_app/ui/joke/joke_screen.dart';

part 'router.g.dart';

@TypedGoRoute<JokeRoute>(path: Routes.joke)
class JokeRoute extends GoRouteData with $JokeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const JokeScreen();
}

final router = GoRouter(initialLocation: Routes.joke, routes: $appRoutes);
