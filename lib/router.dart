import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'screens/splash_screen.dart';
import 'screens/language_selection.dart';
import 'screens/level_test.dart';
import 'screens/goal_setting.dart';
import 'screens/main_layout.dart';
import 'screens/home_tab.dart';
import 'screens/learn_tab.dart';
import 'screens/profile_tab.dart';
import 'screens/favorites_page.dart';
import 'screens/review_page.dart';
import 'screens/practice_page.dart';
import 'screens/listening_practice.dart';
import 'screens/advanced_practice.dart';
import 'screens/empty_page.dart';

GoRouter buildRouter(BuildContext context) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (ctx, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/language',
        builder: (ctx, state) => const LanguageSelection(),
      ),
      GoRoute(
        path: '/level',
        builder: (ctx, state) => const LevelTest(),
      ),
      GoRoute(
        path: '/goal',
        builder: (ctx, state) => const GoalSetting(),
      ),
      ShellRoute(
        builder: (ctx, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: '/app',
            builder: (ctx, state) => const HomeTab(),
          ),
          GoRoute(
            path: '/app/learn',
            builder: (ctx, state) => const LearnTab(),
          ),
          GoRoute(
            path: '/app/profile',
            builder: (ctx, state) => const ProfileTab(),
          ),
        ],
      ),
      GoRoute(
        path: '/favorites',
        builder: (ctx, state) => const FavoritesPage(),
      ),
      GoRoute(
        path: '/review',
        builder: (ctx, state) => const ReviewPage(),
      ),
      GoRoute(
        path: '/practice/:type',
        builder: (ctx, state) {
          final type = state.pathParameters['type'] ?? 'words';
          return PracticePage(type: type);
        },
      ),
      GoRoute(
        path: '/listening',
        builder: (ctx, state) => const ListeningPractice(),
      ),
      GoRoute(
        path: '/advanced/:type',
        builder: (ctx, state) {
          final type = state.pathParameters['type'] ?? 'idioms';
          return AdvancedPractice(type: type);
        },
      ),
      GoRoute(
        path: '/empty',
        builder: (ctx, state) => const EmptyPage(),
      ),
    ],
  );
}
