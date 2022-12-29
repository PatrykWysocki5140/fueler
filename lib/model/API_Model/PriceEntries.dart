import "dart:convert";
import 'dart:developer';
import 'package:fueler/model/API_Model/MyJson.dart';

import 'FuelType.dart';
import "UserPrivilegeLevel.dart";
import 'dart:convert';

MyJson myjson = MyJson();

String priceEntriesModelToJson(List<PriceEntries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<PriceEntries> priceEntriesModelFromJson(String str) {
  String _json = myjson.JsonDecoder(str);
  _json = myjson.JsonDecoderList(_json);
  List<dynamic> parsedListJson = jsonDecode(_json) as List;
  List<PriceEntries> itemsList = List<PriceEntries>.from(parsedListJson
      .map<PriceEntries>((dynamic i) => PriceEntries.fromJsonList(i)));
  return itemsList;
}

class PriceEntries {
  PriceEntries({id, price, fuelType, addedBy, fuelStation});
  late String id;
  late String price;
  late FuelType fuelType;
  late String addedBy;
  late String fuelStation;
  late String icon;

  void setValues(String _id, String _price, FuelType _fuelType, String _addedBy,
      String _fuelStation) {
    id = _id;
    price = _price;
    fuelType = _fuelType;
    addedBy = _addedBy;
    fuelStation = _fuelStation;

    if (_fuelType == FuelType.CNG) {
      icon = 'assets/fueltypes/cng.png';
    } else if (_fuelType == FuelType.DIESEL) {
      icon = 'assets/fueltypes/on.png';
    } else if (_fuelType == FuelType.DIESEL_PREMIUM) {
      icon = 'assets/fueltypes/premiumon.png';
    } else if (_fuelType == FuelType.GASOLINE95) {
      icon = 'assets/fueltypes/pb95.png';
    } else if (_fuelType == FuelType.GASOLINE98) {
      icon = 'assets/fueltypes/pb98.png';
    } else if (_fuelType == FuelType.GASOLINE_PREMIUM) {
      icon = 'assets/fueltypes/premiumpb.png';
    } else if (_fuelType == FuelType.LPG) {
      icon = 'assets/fueltypes/lpg.png';
    }
  }

  factory PriceEntries.fromJson(dynamic myJSON) {
    PriceEntries _pe = PriceEntries();

    String result = myjson.JsonDecoder(myJSON);
    log("JsonEncoder:" + result.toString());
    final jsondecode = json.decode(result.toString());
    log("PriceEntries.fromJson:" + json.toString());
    log("json[fuelType].toString():" + jsondecode['fuelType'].toString());

    FuelType _ft = _pe.getFuelType(jsondecode['fuelType'].toString());

    _pe.setValues(
      jsondecode["id"],
      jsondecode["price"],
      _ft,
      jsondecode["addedBy"],
      jsondecode["fuelStation"],
    );

    log("PriceEntries from JSON: ${_pe.id} ${_pe.price} ${_pe.fuelType} ${_pe.addedBy}${_pe.fuelStation}");
    return _pe;
  }

  factory PriceEntries.fromJsonList(dynamic data) {
    Map<String, dynamic> json = Map<String, dynamic>.from(data);
    PriceEntries _pe = PriceEntries();

    FuelType _ft = _pe.getFuelType(json['fuelType'].toString());

    _pe.setValues(
      json["id"],
      json["price"],
      _ft,
      json["addedBy"],
      json["fuelStation"],
    );

    log("PriceEntries from JSON: ${_pe.id} ${_pe.price} ${_pe.fuelType} ${_pe.addedBy}${_pe.fuelStation}");
    return _pe;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "fuelType": fuelType,
        "addedBy": addedBy,
        "fuelStation": fuelStation,
      };

  FuelType getFuelType(String ft) {
    FuelType _ft = returnfuelType(ft);
    return _ft;
  }

  void setFuelType(String ft) {
    FuelType _ft = returnfuelType(ft);
    fuelType = _ft;
  }

  FuelType returnfuelType(String ft) {
    FuelType _ft = FuelType.UNDEFINED;
    if ((ft == "GASOLINE95") || (ft == "FuelType.GASOLINE95")) {
      _ft = FuelType.GASOLINE95;
    } else if ((ft == "GASOLINE98") || (ft == "FuelType.GASOLINE98")) {
      _ft = FuelType.GASOLINE98;
    } else if ((ft == "GASOLINE_PREMIUM") ||
        (ft == "FuelType.GASOLINE_PREMIUM")) {
      _ft = FuelType.GASOLINE_PREMIUM;
    } else if ((ft == "DIESEL") || (ft == "FuelType.DIESEL")) {
      _ft = FuelType.DIESEL;
    } else if ((ft == "DIESEL_PREMIUM") || (ft == "FuelType.DIESEL_PREMIUM")) {
      _ft = FuelType.DIESEL_PREMIUM;
    } else if ((ft == "LPG") || (ft == "FuelType.LPG")) {
      _ft = FuelType.LPG;
    } else if ((ft == "CNG") || (ft == "FuelType.CNG")) {
      _ft = FuelType.CNG;
    } else {
      _ft = FuelType.UNDEFINED;
    }
    return _ft;
  }
}
