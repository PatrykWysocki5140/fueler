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

String brandModelToJson(List<Brand> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Brand> brandModelFromJson(String str) {
  String _json = myjson.JsonDecoder(str);
  _json = myjson.JsonDecoderList(_json);

  List<dynamic> parsedListJson = jsonDecode(_json);
  List<Brand> itemsList = List<Brand>.from(
      parsedListJson.map<Brand>((dynamic i) => Brand.fromJsonList(i)));
  return itemsList;
}

class Brand {
  Brand({id, name, image});
  late String id;
  late String name;
  late String image;
  List<PriceEntries>? brands = List.empty(growable: true);

  setValues(String _id, String _name, String _image) async {
    id = _id;
    name = _name;
    image = _image;
  }

  void setImage(String _image) {
    image = _image;
  }

  void setName(String _name) {
    name = _name;
  }

  factory Brand.fromJson(dynamic myJSON) {
    Brand _b = Brand();

    String result = myjson.JsonDecoder(myJSON);
    log("JsonEncoder:" + result.toString());
    final jsondecode = json.decode(result.toString());
    log("FuelStation.fromJson:" + json.toString());

    _b.setValues(
      jsondecode["id"],
      jsondecode["name"],
      jsondecode["image"],
    );

    return _b;
  }
  factory Brand.fromJsonNotMapString(String myJSON) {
    Brand _b = Brand();

    String result = myjson.JsonDecoder(myJSON);
    log("JsonEncoder:" + result.toString());
    result = myjson.JsonDecoderList(result);
    final jsondecode = json.decode(result.toString());
    log("FuelStation.fromJson:" + json.toString());

    _b.setValues(
      jsondecode["id"],
      jsondecode["name"],
      jsondecode["image"],
    );

    return _b;
  }

  factory Brand.fromJsonList(dynamic data) {
    Map<String, dynamic> json = Map<String, dynamic>.from(data);
    Brand _b = Brand();

    _b.setValues(
      json["id"],
      json["name"],
      json["image"],
    );

    return _b;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
