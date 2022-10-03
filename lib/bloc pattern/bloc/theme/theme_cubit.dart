import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fueler/settings/themes/styles.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(isDarkThemeOn: true));

  void toggleSwitch(bool value) => emit(state.copyWith(changeState: value));
}
