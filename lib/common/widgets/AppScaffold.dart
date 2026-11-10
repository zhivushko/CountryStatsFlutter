import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/LocaleProvider.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/ThemeProvide.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final bool showBackButton;
  final String? title;

  const AppScaffold({
    super.key,
    required this.body,
    this.showBackButton = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? l10n.appName),
        elevation: 4,
        leading: showBackButton
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(), // Кнопка назад работает через go_router
        )
            : null,
        actions: [
          IconButton(
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            icon: const Icon(Icons.tonality),
            tooltip: 'Theme',
          ),
          IconButton(
            onPressed: () => context.read<LocaleProvider>().toggleLocale(),
            icon: const Icon(Icons.language),
            tooltip: 'Language',
          ),
        ],
      ),
      body: body,
    );
  }
}