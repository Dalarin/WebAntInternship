import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webant_internship/models/media.dart';
import 'package:webant_internship/screens/home_screen.dart';
import 'package:webant_internship/screens/image_screen.dart';
import 'package:webant_internship/screens/login_screen.dart';
import 'package:webant_internship/screens/register_screen.dart';
import 'package:webant_internship/screens/splash_screen.dart';
import 'package:webant_internship/widgets/nav_bar.dart';

final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(
          location: state.location,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          parentNavigatorKey: _shellKey,
          builder: (_, __) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'image/:id',
              builder: (context, state) {
                return ImageScreen(media: state.extra as Media);
              },
            )
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
