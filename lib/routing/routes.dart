import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rentify_app/features/home/ui/home_screen.dart';
import 'package:rentify_app/features/authentication/ui/login_screen.dart';
import 'package:rentify_app/features/authentication/ui/onboard_screen.dart';
import 'package:rentify_app/features/authentication/ui/signup_screen.dart';
import 'package:rentify_app/features/authentication/ui/splash_screen.dart';
import 'package:rentify_app/features/joke/ui/joke_screen.dart';

part 'routes.g.dart';

abstract final class Routes {
  // TODO: remove later
  static const String joke = '/joke';

  // ----- Public Routes -----
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboard = '/onboard';

  // ----- Private Routes -----
  static const String home = '/home';
}

const List<String> publicRoutes = [Routes.login, Routes.signup, Routes.onboard, Routes.splash];

@TypedGoRoute<JokeRoute>(path: Routes.joke)
class JokeRoute extends GoRouteData with $JokeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const JokeScreen();
}

@TypedGoRoute<SplashRoute>(path: Routes.splash)
class SplashRoute extends GoRouteData with $SplashRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashScreen();
}

@TypedGoRoute<HomeRoute>(path: Routes.home)
class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@TypedGoRoute<LoginRoute>(path: Routes.login)
class LoginRoute extends GoRouteData with $LoginRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginScreen();
}

@TypedGoRoute<SignupRoute>(path: Routes.signup)
class SignupRoute extends GoRouteData with $SignupRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SignupScreen();
}

@TypedGoRoute<OnboardRoute>(path: Routes.onboard)
class OnboardRoute extends GoRouteData with $OnboardRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const OnboardScreen();
}
