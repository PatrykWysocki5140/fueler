import 'package:bart/bart.dart';
import 'package:flutter/material.dart';
import 'package:fueler/bloc%20pattern/routes/tabs/map_page.dart';
import 'package:fueler/bloc%20pattern/routes/tabs/settings_page.dart';
import 'tabs/profile_page.dart';
import 'package:animations/animations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future appPushNamed(String route, {Object? arguments}) =>
    navigatorKey.currentState!.pushNamed(route, arguments: arguments);

List<BartMenuRoute> subRoutes() {
  return [
    // strona profil usera // bottom bar menu
    BartMenuRoute.bottomBar(
      label: "Profile",
      icon: Icons.person,
      path: '/profile',
      pageBuilder: (parentContext, tabContext, settings) => ProfilePage(
        key: const PageStorageKey<String>("profile"),
        parentContext: parentContext,
      ),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    // strona mapa // bottom bar menu
    BartMenuRoute.bottomBar(
      label: "Map",
      icon: Icons.person,
      path: '/map',
      pageBuilder: (parentContext, tabContext, settings) => MapPage(
        key: const PageStorageKey<String>("map"),
        parentContext: parentContext,
      ),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    // strona ustawienia // bottom bar menu
    BartMenuRoute.bottomBar(
      label: "Settings",
      icon: Icons.person,
      path: '/settings',
      pageBuilder: (parentContext, tabContext, settings) => SettingsPage(
        key: const PageStorageKey<String>("settings"),
        parentContext: parentContext,
      ),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    BartMenuRoute.innerRoute(
      path: '/profile/inner',
      pageBuilder: (parentContext, tabContext, settings) =>
          const Center(child: Text("Inner route")),
    ),
  ];
}

Widget bottomBarTransition(
  BuildContext c,
  Animation<double> a1,
  Animation<double> a2,
  Widget child,
) =>
    FadeThroughTransition(
      animation: a1,
      secondaryAnimation: a2,
      fillColor: Colors.white,
      child: child,
    );

const bottomBarTransitionDuration = Duration(milliseconds: 700);
