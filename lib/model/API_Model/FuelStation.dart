// ignore_for_file: unnecessary_null_comparison

import "dart:convert";
import 'dart:developer';

import 'package:fueler/model/API_Model/Brand.dart';
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

  List<dynamic> parsedListJson = jsonDecode(_json);
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
  late String brand = 'assets/stationslogo/default.png';
  String? brandId;
  Brand? brandObj;
  String? marker;
  List<PriceEntries>? prices = List.empty(growable: true);

  setValues(
      String _id, String _coordinates, String _name, String _brand) async {
    GoogleMaps mapApi = GoogleMaps();
    id = _id;
    coordinates = convertLocation(_coordinates);
    name = _name;
    marker = getMarker(_name);
    brandId = _brand;
    brand = await getBrand(_brand);
    if (brand == 'assets/stationslogo/default.png') {
      brand = getBrandByName(_name);
    }
    log("brand FuelStation " + brand);
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
    _brand = _brand.toLowerCase();
    String val = "";
    if (_brand == "orlen") {
      val = 'assets/markers/marker-Orlen.png';
    } else if (_brand == "lotos") {
      val = 'assets/markers/marker-Lotos.png';
    } else if (_brand == "shell") {
      val = 'assets/markers/marker-Shell.png';
    } else if (_brand == "bp") {
      val = 'assets/markers/marker-BP.png';
    } else if (_brand == "intermarche") {
      val = 'assets/markers/marker-InterMarche.png';
    } else if (_brand == "circlek") {
      val = 'assets/markers/marker-CircleK.png';
    } else if (_brand == "auchan") {
      val = 'assets/markers/marker-Auchan.png';
    } else if (_brand == "amic") {
      val = 'assets/markers/marker-Amic.png';
    } else if (_brand == "huzar") {
      val = 'assets/markers/marker-Huzar.png';
    } else if (_brand == "moya") {
      val = 'assets/markers/marker-Moya.png';
    } else if (_brand == "statoil") {
      val = 'assets/markers/marker-Statoil.png';
    } else {
      val = 'assets/location_default.png';
    }
    return val;
  }

  Future<String> getBrand(String _brand) async {
    GoogleMaps _mapApi = GoogleMaps();
    Brand _b = Brand();
    _b = (await _mapApi.getBrandById(_brand));

    if (_b.image != null) {
      _brand = _b.image;
    } else {
      _brand = _brand.toLowerCase();
    }
    //_brand = _brand.toLowerCase();
    String val = "";
    if (_brand == "orlen") {
      val = 'assets/stationslogo/Orlen.png';
    } else if (_brand == "lotos") {
      val = 'assets/stationslogo/Lotos.png';
    } else if (_brand == "shell") {
      val = 'assets/stationslogo/Shell.png';
    } else if (_brand == "bp") {
      val = 'assets/stationslogo/BP.png';
    } else if (_brand == "intermarche") {
      val = 'assets/stationslogo/InterMarche.png';
    } else if (_brand == "circlek") {
      val = 'assets/stationslogo/CircleK.png';
    } else if (_brand == "auchan") {
      val = 'assets/stationslogo/Auchan.png';
    } else if (_brand == "amic") {
      val = 'assets/stationslogo/Amic.png';
    } else if (_brand == "huzar") {
      val = 'assets/stationslogo/Huzar.png';
    } else if (_brand == "moya") {
      val = 'assets/stationslogo/Moya.png';
    } else if (_brand == "statoil") {
      val = 'assets/stationslogo/Statoil.png';
    } else {
      val = 'assets/stationslogo/default.png';
    }
    return val;
  }

  String getBrandByName(String _brand) {
    _brand = _brand.toLowerCase();
    String val = "";
    if (_brand == "orlen") {
      val = 'assets/stationslogo/Orlen.png';
    } else if (_brand == "lotos") {
      val = 'assets/stationslogo/Lotos.png';
    } else if (_brand == "shell") {
      val = 'assets/stationslogo/Shell.png';
    } else if (_brand == "bp") {
      val = 'assets/stationslogo/BP.png';
    } else if (_brand == "intermarche") {
      val = 'assets/stationslogo/InterMarche.png';
    } else if (_brand == "circlek") {
      val = 'assets/stationslogo/CircleK.png';
    } else if (_brand == "auchan") {
      val = 'assets/stationslogo/Auchan.png';
    } else if (_brand == "amic") {
      val = 'assets/stationslogo/Amic.png';
    } else if (_brand == "huzar") {
      val = 'assets/stationslogo/Huzar.png';
    } else if (_brand == "moya") {
      val = 'assets/stationslogo/Moya.png';
    } else if (_brand == "statoil") {
      val = 'assets/stationslogo/Statoil.png';
    } else {
      val = 'assets/stationslogo/default.png';
    }
    return val;
  }

  void setMarker(String _marker) {
    marker = _marker;
  }

  void setBrand(String _brand) {
    marker = _brand;
  }

  void addPrice(PriceEntries _price) {
    prices?.add(_price);
  }

  void addPrices(List<PriceEntries> _prices) {
    for (PriceEntries obj in _prices) {
      prices?.add(obj);
    }
  }

  Future<void> setBrandObj(String _brand) async {
    GoogleMaps _mapApi = GoogleMaps();
    Brand _b = Brand();
    _b = (await _mapApi.getBrandById(_brand));
    brandObj = _b;
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
    _fs.addPrices(priceEntriesModelFromJson(jsondecode['priceEntries']));
/*
    _fs.addPrices((jsondecode['priceEntries'] as List)
        .map((e) => PriceEntries.fromJson(e))
        .toList());
        */

    return _fs;
  }
  factory FuelStation.fromJsonMap(dynamic data) {
    data = myjson.JsonDecoder(data);
    data = myjson.JsonDecoderList(data);
    data = jsonDecode(data);
    Map<String, dynamic> json = Map<String, dynamic>.from(data);
    FuelStation _fs = FuelStation();
    _fs.setValues(
      json['id'],
      json['coordinates'],
      json["name"],
      json["brand"],
    );
    _fs.addPrices(priceEntriesModelFromJson(json['priceEntries'].toString()));
    return _fs;
  }
  factory FuelStation.fromJsonNotMapString(String myJSON) {
    FuelStation _fs = FuelStation();

    String result = myjson.JsonDecoder(myJSON);
    log("JsonEncoder:" + result.toString());
    result = myjson.JsonDecoderList(result);
    final jsondecode = json.decode(result.toString());
    log("FuelStation.fromJson:" + json.toString());

    _fs.setValues(
      jsondecode["id"],
      jsondecode["coordinates"],
      jsondecode["name"],
      jsondecode["brand"],
    );
    _fs.addPrices(
        priceEntriesModelFromJson(jsondecode['priceEntries'].toString()));
    return _fs;
  }

  factory FuelStation.fromJsonList(dynamic data) {
    log((data).toString());
    Map<String, dynamic> json = Map<String, dynamic>.from(data);
    FuelStation _fs = FuelStation();

    _fs.setValues(
      json["id"],
      json["coordinates"],
      json["name"],
      json["brand"],
    );
    _fs.addPrices(priceEntriesModelFromJson(json['priceEntries'].toString()));

    return _fs;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "coordinates": coordinates,
        "name": name,
        "brand": brand,
      };
  Map<String, dynamic> toJsonAll() => {
        "id": id,
        "coordinates": coordinates,
        "name": name,
        "brand": brand,
        "address": address,
        "brandId": brandId,
        "brandObj": brandObj?.toJson().toString(),
        "marker": marker,
      };
}
