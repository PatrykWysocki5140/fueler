// ignore_for_file: unnecessary_null_comparison

import "dart:convert";
import 'dart:developer';

import 'package:fueler/model/API_Model/Brand.dart';
import 'package:fueler/model/API_Model/Coordinates.dart';
import 'package:fueler/model/API_Model/FuelStationBrands.dart';
import 'package:fueler/model/API_Model/MyJson.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'FuelType.dart';
import "UserPrivilegeLevel.dart";
import 'dart:convert';

class SearchParams {
  final Coordinates coordinates;
  final double distance;
  final String fuelType;
  final int amount;
  final double burnRate;
  final String searchType;

  SearchParams({
    required this.coordinates,
    required this.distance,
    required this.fuelType,
    required this.amount,
    required this.burnRate,
    required this.searchType,
  });
}
