import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';
import 'package:fueler/settings/Get_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  static final LatLng _kMapCenter = LatLng(52.418542, 16.920900);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  late GoogleMapController _controller;

  Set<Marker> markers = {};
  late BitmapDescriptor customIcon;
  late bool _darkmode = false;
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      log("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  onMapCreated(GoogleMapController controller) async {
    _controller = controller;

    String value;
    await Provider.of<GoogleMaps>(context, listen: false).setMapTheme();
    // ignore: unrelated_type_equality_checks
    value = await DefaultAssetBundle.of(context)
        .loadString(Provider.of<GoogleMaps>(context, listen: false).mapTheme);
    _darkmode = Provider.of<GoogleMaps>(context, listen: false).isDarkTheme;
    _controller.setMapStyle(value);
    //_controller.showMarkerInfoWindow(MarkerId("me"));
  }

  getCurrentPosition() async {
    getUserCurrentLocation().then((value) async {
      LatLng location = LatLng(value.latitude, value.longitude);

      BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'assets/location_icon.png',
      );
      MarkerId markerId = const MarkerId("me");
      markers.add(Marker(
        markerId: markerId,
        position: location,
        infoWindow: InfoWindow(
          title: Provider.of<Api>(context, listen: false).user.name,
          snippet: AppLocalizations.of(context)!.melocation,
        ),
        icon: customIcon,
        onTap: () async {
          log("message");
          _controller.showMarkerInfoWindow(const MarkerId("me"));
        },
      ));

      updateCameraPosition(location);
    });
  }

  updateCameraPosition(LatLng value) async {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(value.latitude, value.longitude),
      zoom: 18,
    );
    LatLng location = LatLng(value.latitude, value.longitude);

    final GoogleMapController controller = _controller;

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  final List<FuelStation> _locations = [];

  @override
  void initState() {
    super.initState();

    FuelStation _fs = FuelStation();
    _fs.setValues("1", "52.370778, 16.867356", "Orlen", "Orlen");
    _locations.add(_fs);

    FuelStation _fs2 = FuelStation();
    _fs2.setValues("2", "52.442424, 16.893418", "Lotos", "Lotos");
    _locations.add(_fs2);

    FuelStation _fs3 = FuelStation();
    _fs3.setValues("3", "52.378720, 16.975102", "Shell", "Shell");
    _locations.add(_fs3);

    FuelStation _fs4 = FuelStation();
    _fs4.setValues("4", "52.415611, 16.907161", "Auchan", "Auchan");
    _locations.add(_fs4);

    FuelStation _fs5 = FuelStation();
    _fs5.setValues("5", "52.358212, 16.926362", "CircleK", "CircleK");
    _locations.add(_fs5);

    FuelStation _fs6 = FuelStation();
    _fs6.setValues("6", "52.335164, 16.861898", "InterMarche", "InterMarche");
    _locations.add(_fs6);

    FuelStation _fs7 = FuelStation();
    _fs7.setValues("7", "52.411805, 16.810317", "BP", "BP");
    _locations.add(_fs7);

    FuelStation _fs8 = FuelStation();
    _fs8.setValues("7", "52.381497, 17.106219", "Amic", "Amic");
    _locations.add(_fs8);

    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    //loginController.text = "Adam";
    //passwordController.text = "TEST";
    //_darkmode = Provider.of<GoogleMaps>(context).isDarkTheme;
    var size = MediaQuery.of(context).size;
    createMarkers(context);
    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kInitialPosition,
            onMapCreated: onMapCreated,
            trafficEnabled: true,
            //myLocationEnabled: true,
            compassEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            markers: markers,
            onLongPress: (argument) {
              // _controller.showMarkerInfoWindow(const MarkerId("me"));
            },
            onTap: (val) {
              // _controller.showMarkerInfoWindow(MarkerId("me"));
            },
          ),
          if (_locations.isNotEmpty)
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  decoration: BoxDecoration(
                      color:
                          // ignore: unrelated_type_equality_checks
                          _darkmode == true
                              ? GetColors.darkAccent
                              : GetColors.lightAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.account,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _locations.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                updateCameraPosition(
                                    _locations[index].coordinates);

                                //_controller.moveCamera(CameraUpdate.newLatLng(_locations[index].coordinates));
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: const EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      _locations[index].brand,
                                      width: 60,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      _locations[index].name,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getCurrentPosition();
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }

  createMarkers(BuildContext context) {
    Marker marker;

    _locations.forEach((contact) async {
      marker = Marker(
        markerId: MarkerId(contact.coordinates.toString()),
        position: contact.coordinates,
        icon:
            await _getAssetIcon(context, contact.marker).then((value) => value),
        infoWindow: InfoWindow(
          title: contact.name,
        ),
      );

      setState(() {
        markers.add(marker);
      });
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(
      BuildContext context, String icon) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config =
        createLocalImageConfiguration(context, size: Size(5, 5));

    AssetImage(icon)
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final ByteData? bytes =
          await image.image.toByteData(format: ImageByteFormat.png);
      final BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }
}
