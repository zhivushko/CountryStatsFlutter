import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleProvider extends Cubit<Locale> {
  LocaleProvider() : super(const Locale('en'));

  void toggleLocale() {
    if (state.languageCode == 'en') {
      emit(const Locale('ru'));
    } else {
      emit(const Locale('en'));
    }
  }
}