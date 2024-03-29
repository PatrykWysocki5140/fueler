// ignore_for_file: recursive_getters
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:bart/bart.dart';
import 'package:fueler/model/API_Model/UserPrivilegeLevel.dart';
import 'package:fueler/notifiers/APINotifier.dart';
import 'package:fueler/routes/UI/user_admin_screen/admin_screen.dart';
import 'package:provider/provider.dart';

import '../UI/login_screen/login_screen.dart';
import '../UI/register_screen/register_screen.dart';

import '../UI/user_screen/user_screen.dart';

class ProfilePage extends StatefulWidget {
  final BuildContext parentContext;
  const ProfilePage({
    Key? key,
    required this.parentContext,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ProfilePage createState() => _ProfilePage(parentContext);
}

class _ProfilePage extends State<ProfilePage> with AppBarNotifier {
  _ProfilePage(BuildContext parentContext);

  BuildContext get parentContext => parentContext;

  @override
  void initState() {
    super.initState();
    updateAppBar(
      context,
      AppBar(
        title: const Text('Fueler'),
        leading: GestureDetector(
          //FloatingActionButton
          //heroTag: "/inner",
          child: const Icon(Icons.refresh),
          onTap: () {
            //onPressed
            // Navigator.of(parentContext).pushNamed("/parent");
            Navigator.of(context).pushNamed("/");
          },
        ), /*
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                //heroTag: "/settingsss",
                child: const Icon(Icons.refresh),
                onTap: () {
                  Navigator.of(context).pushNamed("/profile/inner");
                },
              )),
        ],*/
      ),
    );
    showAppBar(context);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Api>(context).GetLocalUser();

    log("//profile_page//  user id:" +
        Provider.of<Api>(context).user.id.toString() +
        "\n////  user name:" +
        Provider.of<Api>(context).user.name.toString() +
        "\n////  user password:" +
        Provider.of<Api>(context).user.password.toString() +
        "\n////  user email:" +
        Provider.of<Api>(context).user.email.toString() +
        "\n////  user phoneNumber:" +
        Provider.of<Api>(context).user.phoneNumber.toString() +
        "\n////  user userPrivilegeLevel:" +
        Provider.of<Api>(context).user.userPrivilegeLevel.toString() +
        "\n////  user token:" +
        Provider.of<Api>(context).token);
    if (Provider.of<Api>(context).user.id == null) {
      if (Provider.of<Api>(context).userExist == true) {
        return const LoginScreen();
      } else {
        return const RegisterScreen();
      }
    } else {
      if ((Provider.of<Api>(context).user.userPrivilegeLevel ==
              UserPrivilegeLevel.VERIFIED_USER) ||
          (Provider.of<Api>(context).user.userPrivilegeLevel ==
              UserPrivilegeLevel.USER)) {
        return const UserScreen();
      } else if (Provider.of<Api>(context).user.userPrivilegeLevel ==
          UserPrivilegeLevel.ADMINISTRATOR) {
        return const AdminScreen(); /*
        return const Scaffold(
          body: Center(
            child: Text(
              'Admin',
              textAlign: TextAlign.center,
            ),
          ),);*/
      } else {
        return const Scaffold(
          body: Center(
            child: Text(
              'User error undefined',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    //return const Text("profile page");
  }

  /*
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(
                "Add AppBar",
              ),
              onPressed: () {
                updateAppBar(
                  context,
                  AppBar(
                    title: const Text("title text"),
                  ),
                );
                showAppBar(context);
              },
            ),
            TextButton(
              child: const Text(
                "Hide AppBar",
              ),
              onPressed: () => hideAppBar(context),
            ),
            const Divider(),
            TextButton(
              child: const Text(
                "Open page over tabbar",
              ),
              onPressed: () => Navigator.of(parentContext).pushNamed("/parent"),
            ),
            const Divider(),
            TextButton(
              key: const ValueKey("subpageBtn"),
              child: const Text(
                "Go to inner page",
              ),
              onPressed: () => Navigator.of(context).pushNamed("/home/inner"),
            ),
            const Divider(),
            TextButton(
              child: const Text(
                "Go to library tab",
              ),
              onPressed: () => Navigator.of(context).pushNamed("/library"),
            ),
            TextButton(
              child: const Text(
                "Go to profile tab",
              ),
              onPressed: () => Navigator.of(context).pushNamed("/profile"),
            ),
            TextButton(
              child: const Text(
                "Go to counter tab",
              ),
              onPressed: () => Navigator.of(context).pushNamed("/counter"),
            ),
          ],
        ),
      ),
    );
  }*/
}
