import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:bart/bart.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:fueler/routes/UI/map_screen/map_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  final BuildContext parentContext;
  const MapPage({
    Key? key,
    required this.parentContext,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _MapPage createState() => _MapPage(parentContext);
}

class _MapPage extends State<MapPage> with AppBarNotifier {
  _MapPage(BuildContext parentContext);

  BuildContext get parentContext => parentContext;

  @override
  void initState() {
    super.initState();
/*
    updateAppBar(
      context,
      AppBar(
        title: const Text('Flueler'),
        leading: GestureDetector(
          //FloatingActionButton
          //heroTag: "/inner",
          child: const Icon(Icons.refresh),
          onTap: () {
            //onPressed
            // Navigator.of(parentContext).pushNamed("/parent");
            Navigator.of(context).pushNamed("/map");
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
    */

    showAppBar(context);
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<GoogleMaps>(context).
    return const MapScreen();
  }
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
  }
}
*/
