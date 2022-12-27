import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:bart/bart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
/*
  GoogleMapController mapController;
  Position _currentPosition;*/
  static final LatLng _kMapCenter =
      LatLng(19.018255973653343, 72.84793849278007);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();

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
    //return Text("data");
    //_getCurrentLocation();
    //if (await Permission.location.serviceStatus.isDisabled)

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
      ), /*GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),*/
    );
  }

  void _getCurrentLocation() async {
    //Geolocator geolocator = await Geolocator();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
    //Position position = await Geolocator.
    setState(() {
      //_currentPosition = position;
    });
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
