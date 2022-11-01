import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/enums/nav_bar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.profile, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.profile:
        emit(NavigationState(NavbarItem.profile, 0));
        break;
      case NavbarItem.map:
        emit(NavigationState(NavbarItem.map, 1));
        break;
      case NavbarItem.settings:
        emit(NavigationState(NavbarItem.settings, 2));
        break;
      case NavbarItem.refresh:
        emit(NavigationState(NavbarItem.refresh, 3));
        break;
    }
  }
}
