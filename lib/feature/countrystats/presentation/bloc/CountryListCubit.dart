import 'dart:async';

import 'package:country_stats_flutter/common/network/load_exception.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/feature/countrystats/domain/i_network_country_repository.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/list/CountryListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryListCubit extends Cubit<CountryListState> {
  static const int pageSize = 20;
  static const Duration debounceDelay = Duration(milliseconds: 350);

  final INetworkCountryRepository repository;

  Timer? _debounce;

  int _requestId = 0;
  int _page = 1;
  String _query = '';
  List<Country> _items = const [];
  int _total = 0;
  bool _gdpLoaded = false;
  bool _loadingMore = false;

  CountryListCubit(this.repository) : super(const CountryListLoading()) {
    load();
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  Future<void> load() => _loadFirstPage();

  void search(String? query) {
    final next = (query ?? '').trim();
    if (next == _query) return;

    _query = next;
    _debounce?.cancel();
    _debounce = Timer(debounceDelay, () {
      if (!isClosed) _loadFirstPage();
    });
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! CountryListLoaded ||
        !current.hasMore ||
        _loadingMore ||
        current.isLoadingMore ||
        current.gdpStatus == GdpStatus.loading ||
        current.query != _query ||
        (_debounce?.isActive ?? false)) {
      return;
    }

    _loadingMore = true;
    emit(current.copyWith(isLoadingMore: true));

    final requestId = _requestId;

    try {
      final next = await repository.getCountries(
        page: _page + 1,
        perPage: pageSize,
        filter: _query,
        withGdp: _gdpLoaded,
      );
      if (_isStale(requestId)) return;

      if (next.isGdpLoaded != _gdpLoaded) {
        _loadingMore = false;
        return;
      }

      _page += 1;
      _items = [..._items, ...next.items];
      _total = next.total;
      _loadingMore = false;

      emit(
        CountryListLoaded(
          query: _query,
          items: _items,
          total: _total,
          hasMore: next.hasMore,
          gdpStatus: _gdpLoaded ? GdpStatus.loaded : current.gdpStatus,
        ),
      );
    } on LoadException {
      _loadingMore = false;
      if (_isStale(requestId)) return;

      final stateNow = state;
      if (stateNow is CountryListLoaded) {
        emit(stateNow.copyWith(isLoadingMore: false));
      }
    }
  }

  Future<void> retryGdp() async {
    final current = state;
    if (current is! CountryListLoaded ||
        current.gdpStatus != GdpStatus.failed) {
      return;
    }

    emit(current.copyWith(gdpStatus: GdpStatus.loading));
    await _loadGdp(_requestId);
  }

  Future<void> _loadFirstPage() async {
    final requestId = ++_requestId;
    final query = _query;

    _gdpLoaded = false;
    _loadingMore = false;
    _page = 1;

    emit(CountryListLoading(query: query));

    try {
      final first = await repository.getCountries(
        page: 1,
        perPage: pageSize,
        filter: query,
      );
      if (_isStale(requestId)) return;

      _items = first.items;
      _total = first.total;
      _gdpLoaded = first.isGdpLoaded;

      emit(
        CountryListLoaded(
          query: query,
          items: _items,
          total: _total,
          hasMore: first.hasMore,
          gdpStatus: _gdpLoaded ? GdpStatus.loaded : GdpStatus.loading,
        ),
      );

      if (_gdpLoaded) return;

      await _loadGdp(requestId, query: query);
    } on LoadException {
      if (_isStale(requestId)) return;
      emit(CountryListError(query: query));
    }
  }

  Future<void> _loadGdp(int requestId, {String? query}) async {
    final actualQuery = query ?? _query;
    try {
      final enriched = await repository.getCountries(
        page: 1,
        perPage: _page * pageSize,
        filter: actualQuery,
        withGdp: true,
      );
      if (_isStale(requestId)) return;

      _gdpLoaded = true;
      _items = enriched.items;
      _total = enriched.total;

      emit(
        CountryListLoaded(
          query: actualQuery,
          items: _items,
          total: _total,
          hasMore: enriched.hasMore,
          gdpStatus: GdpStatus.loaded,
        ),
      );
    } on LoadException {
      if (_isStale(requestId)) return;

      final stateNow = state;
      if (stateNow is CountryListLoaded) {
        emit(stateNow.copyWith(gdpStatus: GdpStatus.failed));
      }
    }
  }

  // защита от эмита после закрытия
  bool _isStale(int requestId) => isClosed || requestId != _requestId;
}
