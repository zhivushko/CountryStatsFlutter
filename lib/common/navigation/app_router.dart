import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/screens/CountryListScreen.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/screens/CountryDetailScreen.dart';
import 'package:country_stats_flutter/common/widgets/AppScaffold.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const CountryListScreen(),
      ),
      GoRoute(
        path: '/country/:id',
        pageBuilder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');

          return CustomTransitionPage(
            key: state.pageKey,
            child: CountryDetailScreen(id: id),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeInOut)),
                ),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}