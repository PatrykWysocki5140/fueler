import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';
import 'package:fueler/settings/Get_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/API_Model/User.dart';
import '../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../notifiers/APINotifier.dart';
import '../../../settings/validator.dart';

class MapScreen extends StatefulWidget {
  static String id = "login_screen";
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static final LatLng _kMapCenter =
      LatLng(19.018255973653343, 72.84793849278007);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  late GoogleMapController _controller;

  onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value;
    await Provider.of<GoogleMaps>(context, listen: false).setMapTheme();
    // ignore: unrelated_type_equality_checks
    value = await DefaultAssetBundle.of(context)
        .loadString(Provider.of<GoogleMaps>(context, listen: false).mapTheme);

    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    //loginController.text = "Adam";
    //passwordController.text = "TEST";
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
        onMapCreated: onMapCreated,
      ),
    );
  }
}
