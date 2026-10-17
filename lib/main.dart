import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'l10n/app_localizations.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/LocaleProvider.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/ThemeProvide.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/color_scheme.dart';
import 'package:country_stats_flutter/feature/countrystats/data/CountryRepositoryImpl.dart';
// Импортируем наш новый файл с навигацией
import 'package:country_stats_flutter/feature/countrystats/presentation/navigation/app_router.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CountryRepositoryImpl>(
          create: (context) => CountryRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeProvider()),
          BlocProvider(create: (_) => LocaleProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Слушаем изменения темы и языка
    final themeMode = context.watch<ThemeProvider>().state;
    final currentLocale = context.watch<LocaleProvider>().state;

    return MaterialApp.router(
      // Используем роутер из отдельного файла
      routerConfig: AppRouter.router,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}