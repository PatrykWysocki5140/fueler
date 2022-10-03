import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc pattern/bloc/navbar/navigation_cubit.dart';
import 'bloc pattern/bloc/theme/theme_cubit.dart';
import 'bloc pattern/screens/root_screen.dart';

void main() {
  runApp(Root());
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flueler',
            theme: state.theme,
            home: RootScreen());
      },
    );
    /*MaterialApp(
      theme: state.theme,
      home: RootScreen(),
    );*/
  }
}
