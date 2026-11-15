import 'package:country_stats_flutter/feature/countrystats/domain/i_network_country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_stats_flutter/common/network/dio_client.dart';
import 'package:country_stats_flutter/feature/countrystats/data/api/world_bank_api.dart';
import 'package:country_stats_flutter/feature/countrystats/data/data_sources/network_country_data_source.dart';
import 'l10n/app_localizations.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/LocaleProvider.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/ThemeProvide.dart';
import 'package:country_stats_flutter/common/theme/color_scheme.dart';
import 'package:country_stats_flutter/feature/countrystats/data/network_country_repository.dart';
import 'package:country_stats_flutter/common/navigation/app_router.dart';

void main() {
  final dio = createDio();
  final api = WorldBankApi(dio);
  final dataSource = NetworkCountryDataSource(api);
  final repository = NetworkCountryRepositoryImpl(dataSource);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<INetworkCountryRepository>.value(value: repository),
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
    final themeMode = context.watch<ThemeProvider>().state;
    final currentLocale = context.watch<LocaleProvider>().state;

    return MaterialApp.router(
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