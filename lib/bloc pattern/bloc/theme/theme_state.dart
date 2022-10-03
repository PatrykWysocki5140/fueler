part of 'theme_cubit.dart';

class ThemeState {
  final bool isDarkThemeOn;
  ThemeData? theme;
  ThemeState({required this.isDarkThemeOn}) {
    theme = Styles.themeData(isDarkThemeOn);
  }

  ThemeState copyWith({bool? changeState}) {
    return ThemeState(isDarkThemeOn: changeState ?? isDarkThemeOn);
  }
}
