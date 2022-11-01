import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navbar/navigation_cubit.dart';
import '../screens/root_screen.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
      ],
      child: RootScreen(),
    );
  }
}
