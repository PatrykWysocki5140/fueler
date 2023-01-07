import 'package:bart/bart.dart';
import 'package:flutter/material.dart';
import 'package:fueler/notifiers/APINotifier.dart';
import 'package:fueler/routes/UI/user_admin_screen/widgets/brands_screen.dart';
import 'package:fueler/routes/UI/user_admin_screen/widgets/fuelstations_screen.dart';
import 'package:fueler/routes/UI/user_screen/widgets/veryfication_widget.dart';
import 'package:fueler/routes/UI/widgets/add_price_entry_widget.dart';
import 'package:fueler/routes/tabs/map_page.dart';
import 'package:fueler/routes/tabs/settings_page.dart';
import 'package:provider/provider.dart';
import 'UI/login_screen/login_screen.dart';
import 'UI/map_screen/widgets/search_widget.dart';
import 'UI/register_screen/register_screen.dart';
import 'UI/splash_screen/splash_screen_page.dart';
import 'UI/user_admin_screen/widgets/create_brand_screen.dart';
import 'UI/user_admin_screen/widgets/create_user_screen.dart';
import 'UI/user_screen/user_screen.dart';
import 'UI/user_screen/widgets/price_entries_list_widget.dart';
import 'UI/widgets/add_fuel_station_widget.dart';
import 'UI/widgets/add_widget.dart';
import 'tabs/profile_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ignore: non_constant_identifier_names
late final BuildContext _Context;
void setContext(BuildContext parentContext) {
  _Context = parentContext;
}

Future appPushNamed(String route, {Object? arguments}) =>
    navigatorKey.currentState!.pushNamed(route, arguments: arguments);

List<BartMenuRoute> subRoutes() {
  return [
    // strona profil usera // bottom bar menu
    BartMenuRoute.bottomBar(
      label: "",
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
      label: "",
      icon: Icons.navigation,
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
      label: "",
      icon: Icons.settings,
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
    BartMenuRoute.innerRoute(
      path: '/splash',
      pageBuilder: (parentContext, tabContext, settings) =>
          const SplashScreen("/splash"),
    ),
    BartMenuRoute.innerRoute(
      path: '/profile/register',
      pageBuilder: (parentContext, tabContext, settings) =>
          const RegisterScreen(),
    ),
    BartMenuRoute.innerRoute(
      path: '/profile/login',
      pageBuilder: (parentContext, tabContext, settings) => const LoginScreen(),
    ),

    BartMenuRoute.innerRoute(
      path: '/profile/user',
      pageBuilder: (parentContext, tabContext, settings) => const UserScreen(),
    ),
    BartMenuRoute.innerRoute(
      path: '/profile/createnewuser',
      pageBuilder: (parentContext, tabContext, settings) =>
          const CreateUserScreen(),
    ),
    BartMenuRoute.innerRoute(
      path: '/profile/fuelstations',
      pageBuilder: (parentContext, tabContext, settings) =>
          const FuelStationsAdminScreen(),
    ),
    BartMenuRoute.innerRoute(
      path: '/profile/brands',
      pageBuilder: (parentContext, tabContext, settings) =>
          const BrandsAdminScreen(),
    ),
    BartMenuRoute.innerRoute(
      path: '/profile/brands/addnewbrand',
      pageBuilder: (parentContext, tabContext, settings) =>
          const CreateBrandScreen(),
    ),
    BartMenuRoute.innerRoute(
      path: '/profile/mypriceentries',
      pageBuilder: (parentContext, tabContext, settings) =>
          const MyPriceEntriesScreen(),
    ),
    BartMenuRoute.innerRoute(
      path: '/profile/verification',
      pageBuilder: (parentContext, tabContext, settings) =>
          const PinCodeVerificationScreen(),
    ),
    BartMenuRoute.innerRoute(
      path: '/map/add',
      pageBuilder: (parentContext, tabContext, settings) => const AddWidget(),
    ),
    BartMenuRoute.innerRoute(
      path: '/map/search',
      pageBuilder: (parentContext, tabContext, settings) =>
          const SearchWidget(),
    ),
    BartMenuRoute.innerRoute(
      path: '/map/add/addpriceentry',
      pageBuilder: (parentContext, tabContext, settings) =>
          const AddPriceEntryWidget(),
    ),
    BartMenuRoute.innerRoute(
      path: '/map/add/addstation',
      pageBuilder: (parentContext, tabContext, settings) =>
          const AddFuelStationWidget(),
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
