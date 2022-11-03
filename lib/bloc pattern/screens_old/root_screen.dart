import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fueler/bloc%20pattern/bloc/bloc_main_old.dart';
import 'package:fueler/bloc%20pattern/screens_old/loading_screen.dart';
import 'package:fueler/pages_old/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/navbar_old/navigation_cubit.dart';
import '../bloc/theme_old/theme_cubit.dart';
import '../model/enums/nav_bar_items_old.dart';
import 'settings_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext parentcontext) {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Flueler'),
          leading: GestureDetector(
              onTap: () {},
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.settings);
                },
                icon: const Icon(Icons.search),
              )),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: FloatingActionButton(
                  heroTag: "/settingsss",
                  child: const Icon(Icons.refresh),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (parentcontext) => SettingsScreen()));
                  },
                )),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.index,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.navigation,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: ""),
          ],
          onTap: (index) {
            if (index == 0) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.profile);
            } else if (index == 1) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.map);
            } else if (index == 2) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.settings);
            }
          },
        ),
        body: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
          if (state.navbarItem == NavbarItem.profile) {
            return Text("1"); //ProfileScreen();
          } else if (state.navbarItem == NavbarItem.settings) {
            return SettingsScreen();
          } else if (state.navbarItem == NavbarItem.map) {
            return Text("3"); //MapScreen();
          } else if (state.navbarItem == NavbarItem.refresh) {
            return Text("refresh");
          }
          return Container();
        }),
      );
    });
  }
}




/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fueler/bloc%20pattern/screens/loading_screen.dart';
import 'package:fueler/pages/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/navbar/navigation_cubit.dart';
import '../bloc/theme/theme_cubit.dart';
import '../model/enums/nav_bar_items.dart';
import 'settings_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flueler'),
        leading: GestureDetector(
            onTap: () {},
            child: IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.search),
            )),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {},
                  child: IconButton(
                    onPressed: () {
                      LoadingScreen(
                          onCompletion: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Text("dddd")),
                              ));
                    },
                    icon: const Icon(Icons.refresh),
                  ))),
        ],
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.navigation,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: ""),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.profile);
              } else if (index == 1) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.map);
              } else if (index == 2) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.settings);
              }
            },
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        if (state.navbarItem == NavbarItem.profile) {
          return Text("1"); //ProfileScreen();
        } else if (state.navbarItem == NavbarItem.settings) {
          return SettingsScreen();
        } else if (state.navbarItem == NavbarItem.map) {
          return Text("3"); //MapScreen();
        }
        return Container();
      }),
    );
  }
}
*/