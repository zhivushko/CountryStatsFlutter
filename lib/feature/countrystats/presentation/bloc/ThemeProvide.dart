import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends Cubit<ThemeMode>
{
  ThemeProvider() : super(ThemeMode.system);

  void toggleTheme()
  {
    if (state == ThemeMode.dark)
    {
      emit(ThemeMode.light);
    }
    else {
      emit(ThemeMode.dark);
    }
  }
}