import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:country_stats_flutter/feature/countrystats/data/CountryRepositoryImpl.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/CountryDetailCubit.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/screens/CountryListScreen.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/screens/CountryDetailScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        // ИСПОЛЬЗУЕМ pageBuilder ВМЕСТО builder
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final repo = context.read<CountryRepositoryImpl>();

          return CustomTransitionPage(
            key: state.pageKey, // Обязательно для корректной работы
            child: BlocProvider(
              create: (_) {
                final cubit = CountryDetailCubit(repo);
                cubit.loadCountry(id);
                return cubit;
              },
              child: CountryDetailScreen(id: id),
            ),

            // Вариант 2: Выезд справа налево (Slide)
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