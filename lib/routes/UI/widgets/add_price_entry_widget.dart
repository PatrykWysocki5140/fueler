// ignore_for_file: prefer_const_literals_to_create_immutables

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

class AddPriceEntryWidget extends StatefulWidget {
  const AddPriceEntryWidget({Key? key}) : super(key: key);

  //final PriceEntries pe;
  //const AddPriceEntryWidget(this.pe);

  @override
  // ignore: no_logic_in_create_state
  State<AddPriceEntryWidget> createState() => _AddPriceEntryWidgetState();
}

class _AddPriceEntryWidgetState extends State<AddPriceEntryWidget> {
  //final PriceEntries pe;
  // _AddPriceEntryWidgetState(this.pe);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController priceController = TextEditingController();
  String _fuelType = '';
  double _price = 0;
  late FuelStation _selectedFuelStation;
  late List<FuelStation> _fuelStations;

  Future<void> reportPrice() async {
    priceController.text = priceController.text
        .replaceAll(',', ".")
        .replaceAll('-', ".")
        .replaceAll(' ', "");
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.warning, //Colors.green.shade300,
      ));
      PriceEntries pe = PriceEntries();

      Response? _response =
          await Provider.of<GoogleMaps>(context, listen: false).addPriceEntry(
              _selectedFuelStation,
              pe.getFuelType(_fuelType).name,
              priceController.text);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_response?.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.success}'),
          backgroundColor: GetColors.success,
        ));
        Navigator.of(context).pushNamed("/map");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.error}'),
          backgroundColor: GetColors.error,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _fuelType = AppLocalizations.of(context)!.pb95;

    _fuelStations =
        Provider.of<GoogleMaps>(context, listen: false).searchFuelStations;
    _selectedFuelStation = _fuelStations[0];
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
                SizedBox(height: size.height * 0.03),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.fuelstation,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButtonFormField(
                          value: _selectedFuelStation,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 42,
                          items: _fuelStations.map((fuelStation) {
                            return DropdownMenuItem(
                              value: fuelStation,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      fuelStation.brand,
                                      width: 60,
                                    ),
                                    SizedBox(width: size.height * 0.03),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        fuelStation.address.toString(),
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFuelStation = value as FuelStation;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Wybierz stację paliw';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          AppLocalizations.of(context)!.fueltype,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButtonFormField(
                          value: _fuelType,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 42,
                          items: [
                            AppLocalizations.of(context)!.cng,
                            AppLocalizations.of(context)!.on,
                            AppLocalizations.of(context)!.onpremium,
                            AppLocalizations.of(context)!.pb95,
                            AppLocalizations.of(context)!.pb98,
                            AppLocalizations.of(context)!.pbpremium,
                            AppLocalizations.of(context)!.lpg
                          ].map((fuelType) {
                            String icon;
                            if (fuelType == AppLocalizations.of(context)!.cng) {
                              icon = 'assets/fueltypes/cng.png';
                            } else if (fuelType ==
                                AppLocalizations.of(context)!.on) {
                              icon = 'assets/fueltypes/on.png';
                            } else if (fuelType ==
                                AppLocalizations.of(context)!.onpremium) {
                              icon = 'assets/fueltypes/premiumon.png';
                            } else if (fuelType ==
                                AppLocalizations.of(context)!.pb95) {
                              icon = 'assets/fueltypes/pb95.png';
                            } else if (fuelType ==
                                AppLocalizations.of(context)!.pb98) {
                              icon = 'assets/fueltypes/pb98.png';
                            } else if (fuelType ==
                                AppLocalizations.of(context)!.pbpremium) {
                              icon = 'assets/fueltypes/premiumpb.png';
                            } else if (fuelType ==
                                AppLocalizations.of(context)!.lpg) {
                              icon = 'assets/fueltypes/lpg.png';
                            } else {
                              icon = 'assets/stationslogo/default.png';
                            }
                            //icon = 'assets/stationslogo/default.png';
                            return DropdownMenuItem(
                              value: fuelType,
                              child: Row(
                                children: [
                                  Image.asset(
                                    icon,
                                    width: 60,
                                  ),
                                  SizedBox(width: size.height * 0.03),
                                  Text(
                                    fuelType,
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
                              _fuelType = value.toString();
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
                        TextFormField(
                          validator: (value) =>
                              Validator.validatePrice(value ?? "", context),
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.price,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: reportPrice,
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
