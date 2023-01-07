// ignore_for_file: unnecessary_null_comparison

import "dart:convert";
import 'dart:developer';

import 'package:fueler/model/API_Model/Brand.dart';
import 'package:fueler/model/API_Model/FuelStationBrands.dart';
import 'package:fueler/model/API_Model/MyJson.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'FuelType.dart';
import "UserPrivilegeLevel.dart";
import 'dart:convert';

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({required this.longitude, required this.latitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
