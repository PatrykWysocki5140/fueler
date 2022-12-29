import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/notifiers/MapNotifier.dart';

import 'package:fueler/routes/UI/map_screen/widgets/station_dialog.dart';

import 'package:fueler/settings/Get_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import '../../../notifiers/APINotifier.dart';

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
      /*
      final coordinates = Coordinates(value.latitude, value.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      log("${first.featureName} : ${first.addressLine}");
*/
      LatLng location = LatLng(value.latitude, value.longitude);

////// nie działa
      String? _formattedAddress =
          await Provider.of<GoogleMaps>(context, listen: false)
              .getAddressFromLatLng(value.latitude, value.longitude);

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
          snippet: AppLocalizations.of(context)!.melocation +
              ": " +
              _formattedAddress!,
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

  loadLocations() async {
    _locations.clear;

    for (PriceEntries obj
        in Provider.of<Api>(context, listen: false).mePriceEntries) {
      _locations[0].addPrice(obj);
      _locations[1].addPrice(obj);
      _locations[2].addPrice(obj);
    }
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

/*
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
*/
    getCurrentPosition();
    loadLocations();
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
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                //heroTag: "/settingsss",
                child: Row(
                  children: [
                    const Icon(Icons.addchart_rounded),
                    Text(
                      AppLocalizations.of(context)!.add,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/map/addpriceentry");
                },
              )),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kInitialPosition,
            onMapCreated: onMapCreated,
            // trafficEnabled: true,
            //myLocationEnabled: true,
            compassEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: true,
            buildingsEnabled: true,
            indoorViewEnabled: true,
            markers: markers,
            onCameraMove: (position) {},
            onLongPress: (argument) {
              // _controller.showMarkerInfoWindow(const MarkerId("me"));
            },
            onTap: (val) {
              // _controller.showMarkerInfoWindow(MarkerId("me"));
            },
          ),
          if (_locations.isNotEmpty)
            Positioned(
              bottom: 85,
              left: 20,
              right: 20,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  decoration: BoxDecoration(
                    color:
                        // ignore: unrelated_type_equality_checks
                        _darkmode == true
                            ? GetColors.darkAccent
                            : GetColors.lightAccent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.station,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
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
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color:
                                      // ignore: unrelated_type_equality_checks
                                      _darkmode == true
                                          ? GetColors.darkShades
                                          : GetColors.lightShades,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(),
                                ),
                                //color: GetColors.black,
                                //width: 100,
                                //height: 100,
                                margin:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //SizedBox(height: size.height * 0.01),
                                    Image.asset(
                                      _locations[index].brand,
                                      width: 60,
                                    ),
                                    Text(
                                      _locations[index].name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          // color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Text(
                                      _locations[index].address == null
                                          ? ""
                                          : _locations[index]
                                              .address
                                              .toString(),
                                      style: const TextStyle(
                                          //color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
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
    _locations.forEach((loaction) async {
      String _snippet = "";
      if (loaction.prices != null) {
        for (PriceEntries obj in loaction.prices!.toList()) {
          _snippet += obj.getFuelType(obj.fuelType.toString()).name +
              ": " +
              obj.price.toString() +
              "\n";
        }
      }
      marker = Marker(
        markerId: MarkerId(loaction.coordinates.toString()),
        position: loaction.coordinates,
        icon: await _getAssetIcon(context, loaction.marker)
            .then((value) => value),
        infoWindow: InfoWindow(
          title: loaction.name,
          snippet: (_snippet),
        ),
        onTap: (() async {
          bool? val = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) =>
                  StationDialog(fuelstation: loaction));

          if (val == true) {
            setState(() {});
          }
        }),
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
