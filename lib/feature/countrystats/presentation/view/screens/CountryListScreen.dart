import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/CountryListCubit.dart';
import 'package:country_stats_flutter/feature/countrystats/domain/i_network_country_repository.dart';
import 'package:country_stats_flutter/common/widgets/AppScaffold.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/list/CountryListState.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/widgets/CountryList.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';

class CountryListScreen extends StatelessWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CountryListCubit(context.read<INetworkCountryRepository>()),
      child: const _CountryListView(),
    );
  }
}

class _CountryListView extends StatefulWidget {
  const _CountryListView();

  @override
  State<_CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<_CountryListView> {
  static const double _loadMoreThreshold = 320.0;

  final ScrollController _scrollController = ScrollController();
  String? _renderedQuery;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _loadMoreThreshold) {
      context.read<CountryListCubit>().loadMore();
    }
  }

  void _loadMoreIfViewportNotFilled() {
    if (!mounted || !_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (position.hasContentDimensions && position.maxScrollExtent <= 0) {
      context.read<CountryListCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = context.watch<CountryListCubit>().state;
    final loaded = state is CountryListLoaded ? state : null;

    if (loaded != null && loaded.query != _renderedQuery) {
      _renderedQuery = loaded.query;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) _scrollController.jumpTo(0);
      });
    }

    if (loaded != null &&
        loaded.hasMore &&
        !loaded.isLoadingMore &&
        !loaded.isGdpLoading) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _loadMoreIfViewportNotFilled(),
      );
    }

    return AppScaffold(
      showBackButton: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.search,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onChanged: (value) {
                context.read<CountryListCubit>().search(value);
              },
            ),
          ),

          if (loaded?.isGdpLoading ?? false)
            const LinearProgressIndicator(minHeight: 2.0)
          else
            const SizedBox(height: 2.0),

          if (loaded?.gdpFailed ?? false)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.errorLoad,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        context.read<CountryListCubit>().retryGdp(),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            ),

          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: switch (state) {
                    CountryListLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    CountryListLoaded(:final items) => CountryList(
                      countries: items,
                      onCountryClick: (id) => context.push('/country/$id'),
                      isScrollable: true,
                      controller: _scrollController,
                    ),
                    CountryListError() => Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(l10n.errorLoad),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<CountryListCubit>().load(),
                            child: Text(l10n.retry),
                          ),
                        ],
                      ),
                    ),
                  },
                ),
                if (loaded?.isLoadingMore ?? false)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 16.0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const SizedBox(
                          width: 22.0,
                          height: 22.0,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
