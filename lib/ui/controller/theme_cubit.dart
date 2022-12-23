import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/services/local_services/cache_helper.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  bool _isDark = false;

  static ThemeCubit get(context) => BlocProvider.of<ThemeCubit>(context);

  void switchTheme() async {
    _isDark = !_isDark;
    await CacheHelper.setTheme(isDark: _isDark);
    emit(SwitchAppTheme());
  }

  ThemeMode get getTheme {
    bool themeIsDark = CacheHelper.getThemeIsDark ?? false;
    _isDark=themeIsDark;

    if (themeIsDark) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }
}
