import "dart:convert";
import 'dart:developer';

import 'package:fueler/model/API_Model/MyJson.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'FuelType.dart';
import "UserPrivilegeLevel.dart";
import 'dart:convert';

MyJson myjson = MyJson();

String fuelStationModelToJson(List<FuelStation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<FuelStation> fuelStationModelFromJson(String str) {
  String _json = myjson.JsonDecoder(str);
  _json = myjson.JsonDecoderList(_json);
  List<dynamic> parsedListJson = jsonDecode(_json) as List;
  List<FuelStation> itemsList = List<FuelStation>.from(parsedListJson
      .map<FuelStation>((dynamic i) => FuelStation.fromJsonList(i)));
  return itemsList;
}

class FuelStation {
  FuelStation({id, coordinates, name, brand});
  late String id;
  late LatLng coordinates;
  String? address;
  //FuelType? fuelType;
  late String name;
  late String brand;
  late String marker;
  List<PriceEntries>? prices = List.empty(growable: true);

  setValues(
      String _id, String _coordinates, String _name, String _brand) async {
    GoogleMaps mapApi = GoogleMaps();
    id = _id;
    coordinates = convertLocation(_coordinates);
    name = _name;
    brand = getBrand(_brand);
    marker = getMarker(_brand);
    address = await mapApi.getAddressFromLatLng(
        coordinates.latitude, coordinates.longitude);
  }

  LatLng convertLocation(String _coordinates) {
    List<String> latLng = _coordinates.split(",");
    double latitude = double.parse(latLng[0]);
    double longitude = double.parse(latLng[1]);
    LatLng location = LatLng(latitude, longitude);
    return location;
  }

  String getMarker(String _brand) {
    String val = "";
    if (_brand == "Orlen") {
      val = 'assets/markers/marker-Orlen.png';
    } else if (_brand == "Lotos") {
      val = 'assets/markers/marker-Lotos.png';
    } else if (_brand == "Shell") {
      val = 'assets/markers/marker-Shell.png';
    } else if (_brand == "BP") {
      val = 'assets/markers/marker-BP.png';
    } else if (_brand == "InterMarche") {
      val = 'assets/markers/marker-InterMarche.png';
    } else if (_brand == "CircleK") {
      val = 'assets/markers/marker-CircleK.png';
    } else if (_brand == "Auchan") {
      val = 'assets/markers/marker-Auchan.png';
    } else if (_brand == "Amic") {
      val = 'assets/markers/marker-Amic.png';
    } else if (_brand == "Huzar") {
      val = 'assets/markers/marker-Huzar.png';
    } else if (_brand == "Moya") {
      val = 'assets/markers/marker-Moya.png';
    } else if (_brand == "Statoil") {
      val = 'assets/markers/marker-Statoil.png';
    } else {
      val = 'assets/location_default.png';
    }
    return val;
  }

  String getBrand(String _brand) {
    String val = "";
    if (_brand == "Orlen") {
      val = 'assets/stationslogo/Orlen.png';
    } else if (_brand == "Lotos") {
      val = 'assets/stationslogo/Lotos.png';
    } else if (_brand == "Shell") {
      val = 'assets/stationslogo/Shell.png';
    } else if (_brand == "BP") {
      val = 'assets/stationslogo/BP.png';
    } else if (_brand == "InterMarche") {
      val = 'assets/stationslogo/InterMarche.png';
    } else if (_brand == "CircleK") {
      val = 'assets/stationslogo/CircleK.png';
    } else if (_brand == "Auchan") {
      val = 'assets/stationslogo/Auchan.png';
    } else if (_brand == "Amic") {
      val = 'assets/stationslogo/Amic.png';
    } else if (_brand == "Huzar") {
      val = 'assets/stationslogo/Huzar.png';
    } else if (_brand == "Moya") {
      val = 'assets/stationslogo/Moya.png';
    } else if (_brand == "Statoil") {
      val = 'assets/stationslogo/Statoil.png';
    } else {
      val = 'assets/stationslogo/default.png';
    }
    return val;
  }

  void setMarker(String _marker) {
    marker = _marker;
  }

  void addPrice(PriceEntries _price) {
    prices?.add(_price);
  }

  void addPrices(List<PriceEntries> _prices) {
    for (PriceEntries obj in _prices) {
      prices?.add(obj);
    }
  }

  factory FuelStation.fromJson(dynamic myJSON) {
    FuelStation _fs = FuelStation();

    String result = myjson.JsonDecoder(myJSON);
    log("JsonEncoder:" + result.toString());
    final jsondecode = json.decode(result.toString());
    log("FuelStation.fromJson:" + json.toString());

    _fs.setValues(
      jsondecode["id"],
      jsondecode["coordinates"],
      jsondecode["name"],
      jsondecode["brand"],
    );
    _fs.addPrices((jsondecode['priceEntries'] as List)
        .map((e) => PriceEntries.fromJson(e))
        .toList());

    return _fs;
  }

  factory FuelStation.fromJsonList(dynamic data) {
    Map<String, dynamic> json = Map<String, dynamic>.from(data);
    FuelStation _fs = FuelStation();

    _fs.setValues(
      json["id"],
      json["coordinates"],
      json["name"],
      json["brand"],
    );

    return _fs;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "coordinates": coordinates,
        "name": name,
        "brand": brand,
      };
}
