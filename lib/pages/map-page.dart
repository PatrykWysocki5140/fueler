import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:fueler/widgets/fuel-row.dart';
import 'package:latlong2/latlong.dart';
import 'package:tuple/tuple.dart';

class Popup extends StatelessWidget {
  final Marker marker;
  final double onPrice;
  final double pbPrice;
  final double lpgPrice;

  const Popup(
      {Key? key,
      required this.marker,
      required this.onPrice,
      required this.pbPrice,
      required this.lpgPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            prices(context),
          ],
        ),
      ),
    );
  }

  Widget prices(BuildContext context) => Container(
        color: Theme.of(context).canvasColor,
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FuelRow(fuel: FuelType.on, price: onPrice),
            FuelRow(fuel: FuelType.pb, price: pbPrice),
            FuelRow(fuel: FuelType.lpg, price: lpgPrice)
          ],
        ),
      );
}

class FuelMarker extends Marker {
  final Tuple6 data;

  FuelMarker({required this.data})
      : super(
            anchorPos: AnchorPos.align(AnchorAlign.bottom),
            width: 40,
            height: 40,
            point: LatLng(data.item1, data.item2),
            key: Key(data.item1.toString() +
                data.item2.toString() +
                data.item3.toString()),
            builder: (_) => const Icon(
                  Icons.local_gas_station,
                  size: 40,
                ));
}

class MapPage extends StatelessWidget {
  static final random = Random();

  static List<Tuple6<double, double, int, double, double, double>> markers =
      List<Tuple6<double, double, int, double, double, double>>.generate(20,
          (index) {
    return Tuple6(
        52.30 + random.nextInt(20) / 100, //LAT
        16.77 + random.nextInt(24) / 100, //LON
        index, //KEY
        7 + random.nextDouble(), //ON
        6 + random.nextDouble(), //PB
        4 + random.nextDouble()); //LPG
  });

  MapPage({Key? key}) : super(key: key);

  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(context) {
    markers.sort(((a, b) => (a.item1 * 100 - b.item1 * 100).round()));
    return FlutterMap(
      options: MapOptions(
          center: LatLng(52.409538, 16.931992),
          zoom: 13.0,
          onTap: (_, __) => _popupLayerController.hideAllPopups()),
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return const Text("© OpenStreetMap contributors");
            },
          ),
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
              markerRotateOrigin: const Offset(20, 0),
              popupController: _popupLayerController,
              popupSnap: PopupSnap.markerBottom,
              popupAnimation: const PopupAnimation.fade(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut),
              popupBuilder: (BuildContext context, Marker marker) {
                if (marker is FuelMarker) {
                  return Popup(
                      marker: marker,
                      onPrice: marker.data.item4,
                      pbPrice: marker.data.item5,
                      lpgPrice: marker.data.item6);
                }
                return const SizedBox(
                  height: 0,
                  width: 0,
                );
              },
              markers: markers.map((e) => FuelMarker(data: e)).toList()),
        )
      ],
    );
  }
}
