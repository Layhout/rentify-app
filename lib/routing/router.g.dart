// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$jokeRoute];

RouteBase get $jokeRoute =>
    GoRouteData.$route(path: '/joke', factory: $JokeRoute._fromState);

mixin $JokeRoute on GoRouteData {
  static JokeRoute _fromState(GoRouterState state) => JokeRoute();

  @override
  String get location => GoRouteData.$location('/joke');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
