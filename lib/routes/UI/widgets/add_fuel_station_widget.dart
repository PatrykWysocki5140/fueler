import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:fueler/model/API_Model/FuelType.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/notifiers/MapNotifier.dart';

import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/API_Model/User.dart';
import '../../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../../notifiers/APINotifier.dart';
import '../../../../settings/Get_colors.dart';
import '../../../../settings/validator.dart';

class AddFuelStationWidget extends StatefulWidget {
  const AddFuelStationWidget({Key? key}) : super(key: key);

  //final PriceEntries pe;
  //const AddPriceEntryWidget(this.pe);

  @override
  // ignore: no_logic_in_create_state
  State<AddFuelStationWidget> createState() => _AddFuelStationWidgetState();
}

class _AddFuelStationWidgetState extends State<AddFuelStationWidget> {
  //final PriceEntries pe;
  // _AddPriceEntryWidgetState(this.pe);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  String _fuelStation = "Orlen";

  Future<void> addStation() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.warning, //Colors.green.shade300,
      ));
      Response? _response =
          await Provider.of<GoogleMaps>(context, listen: false).addFuelStation(
              longitudeController.text,
              latitudeController.text,
              nameController.text,
              brandController.text);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_response?.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.success),
          backgroundColor: GetColors.success, //Colors.red.shade300,
        ));
        Navigator.of(context).pushNamed("/map");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.error),
          backgroundColor: GetColors.error, //Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    longitudeController.text =
        Provider.of<GoogleMaps>(context).userlng.toString();
    latitudeController.text =
        Provider.of<GoogleMaps>(context).userlat.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notificationfuelprice),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => {
            Navigator.of(context).pop(),
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            //width: size.width * 0.85,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
            ),
            child: Column(
              children: [
                //SizedBox(height: size.height * 0.03),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.03),
                        Text(
                          AppLocalizations.of(context)!.latitude,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              Validator.validateCoordinatesLatitude(
                                  value ?? "", context),
                          controller: latitudeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.latitude,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          AppLocalizations.of(context)!.longitude,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              Validator.validateCoordinatesLongitude(
                                  value ?? "", context),
                          controller: longitudeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.longitude,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          AppLocalizations.of(context)!.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              Validator.validateName(value ?? "", context),
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.name,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          AppLocalizations.of(context)!.brand,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButtonFormField(
                          value: _fuelStation,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 42,
                          items: [
                            "Orlen",
                            "Lotos",
                            "Shell",
                            "BP",
                            "InterMarche",
                            "CircleK",
                            "Auchan",
                            "Amic",
                            "Huzar",
                            "Moya",
                            "Statoil"
                          ].map((_fuelStation) {
                            String icon;
                            FuelStation _fs = FuelStation();
                            icon = _fs.getBrand(_fuelStation);

                            return DropdownMenuItem(
                              value: _fuelStation,
                              child: Row(
                                children: [
                                  Image.asset(
                                    icon,
                                    width: 60,
                                  ),
                                  SizedBox(width: size.height * 0.03),
                                  Text(
                                    _fuelStation,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              brandController.text = _fuelStation;
                              _fuelStation = value.toString();
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Wybierz rodzaj paliw';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: addStation,
                            child: Text(
                              AppLocalizations.of(context)!.sendrequest,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
