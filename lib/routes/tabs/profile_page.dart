// ignore_for_file: recursive_getters
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:bart/bart.dart';
import 'package:fueler/notifiers/APINotifier.dart';
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
        title: const Text('Flueler'),
        leading: FloatingActionButton(
          heroTag: "/inner",
          child: const Icon(Icons.refresh),
          onPressed: () {
            // Navigator.of(parentContext).pushNamed("/parent");
            Navigator.of(context).pushNamed("/profile/inner");
          },
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: FloatingActionButton(
                heroTag: "/settingsss",
                child: const Icon(Icons.refresh),
                onPressed: () {
                  Navigator.of(context).pushNamed("/profile/inner");
                },
              )),
        ],
      ),
    );
    showAppBar(context);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Api>(context).GetLocalUser();
    log("////  user password:" +
        Provider.of<Api>(context).user.password.toString());
    /*
      log("//profile_page//  user id:" + Provider.of<Api>(context).user.id.toString());
      log("////  user name:" + Provider.of<Api>(context).user.name.toString());
      log("////  user email:" + Provider.of<Api>(context).user.email.toString());
      log("////  user phoneNumber:" + Provider.of<Api>(context).user.phoneNumber.toString());
      log("////  user userPrivilegeLevel:" + Provider.of<Api>(context).user.userPrivilegeLevel.toString());*/
    if (Provider.of<Api>(context).user.id == null) {
      return const RegisterScreen();
    } else {
      return const UserScreen();
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
