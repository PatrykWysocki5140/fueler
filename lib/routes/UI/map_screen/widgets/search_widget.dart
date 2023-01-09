import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fueler/model/API_Model/Coordinates.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:fueler/model/API_Model/FuelType.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/model/API_Model/SearchParams.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:fueler/routes/UI/map_screen/widgets/station_dialog.dart';

import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../model/API_Model/User.dart';
import '../../../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../../../notifiers/APINotifier.dart';
import '../../../../../settings/Get_colors.dart';
import '../../../../../settings/validator.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  //final PriceEntries pe;
  //const AddPriceEntryWidget(this.pe);

  @override
  // ignore: no_logic_in_create_state
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController fuelTypeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController burnRateController = TextEditingController();
  final TextEditingController searchTypeController = TextEditingController();

  String _fuelType = '';
  late String _searchType;
  double _distance = 20;
  addPriceEntry() {
    Navigator.of(context).pushNamed("/map/add/addpriceentry");
  }

  void addFuelStation() {
    Navigator.of(context).pushNamed("/map/add/addstation");
  }

  Future<void> searchStation() async {
    burnRateController.text = burnRateController.text
        .replaceAll(',', ".")
        .replaceAll('-', ".")
        .replaceAll(' ', "");
    amountController.text = amountController.text
        .replaceAll(',', ".")
        .replaceAll('-', ".")
        .replaceAll(' ', "");
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.warning, //Colors.green.shade300,
      ));

      PriceEntries _p = PriceEntries();
      FuelType _ft = _p.returnfuelType(_fuelType.toString());

      fuelTypeController.text = _ft.name.toString();
      searchTypeController.text = returnSearchType(_searchType);
      Coordinates _c = Coordinates(
          longitude: double.parse(longitudeController.text),
          latitude: double.parse(latitudeController.text));
      SearchParams _sP = SearchParams(
          coordinates: _c,
          fuelType: fuelTypeController.text,
          amount: int.parse(amountController.text),
          burnRate: double.parse(burnRateController.text),
          searchType: searchTypeController.text,
          distance: double.parse(distanceController.text));

      Response? _response =
          await Provider.of<GoogleMaps>(context, listen: false)
              .getBestFuelStation(_sP);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_response?.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.success),
          backgroundColor: GetColors.success,
        ));
        FuelStation _fs =
            FuelStation.fromJsonNotMapString(await _response!.data.toString());
        await _fs.setAddress(
            _fs.coordinates.latitude, _fs.coordinates.longitude);
        showDialog<bool>(
            context: context,
            builder: (BuildContext context) => StationDialog(fuelstation: _fs));
      } else if (_response?.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.errorsearchbeststation),
          backgroundColor: GetColors.warning,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.error),
          backgroundColor: GetColors.error,
        ));
      }
    }
  }

  setSearchType(String value) {
    if (value == AppLocalizations.of(context)!.closest) {
      //_searchType = "CLOSEST";
      _searchType = AppLocalizations.of(context)!.closest.toUpperCase();
    } else if (value == AppLocalizations.of(context)!.cheapest) {
      //_searchType = "CHEAPEST";
      _searchType = AppLocalizations.of(context)!.cheapest.toUpperCase();
    } else if (value == AppLocalizations.of(context)!.optimal) {
      //_searchType = "OPTIMAL";
      _searchType = AppLocalizations.of(context)!.optimal.toUpperCase();
    }
  }

  returnSearchType(String value) {
    if (value == AppLocalizations.of(context)!.closest.toUpperCase()) {
      return "CLOSEST";
      //_searchType = AppLocalizations.of(context)!.closest.toUpperCase();
    } else if (value == AppLocalizations.of(context)!.cheapest.toUpperCase()) {
      return "CHEAPEST";
      //_searchType = AppLocalizations.of(context)!.cheapest.toUpperCase();
    } else if (value == AppLocalizations.of(context)!.optimal.toUpperCase()) {
      return "OPTIMAL";
      //_searchType = AppLocalizations.of(context)!.optimal.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    _fuelType = AppLocalizations.of(context)!.pb95;

    setSearchType(AppLocalizations.of(context)!.optimal);

    longitudeController.text =
        Provider.of<GoogleMaps>(context).userlng.toString();
    latitudeController.text =
        Provider.of<GoogleMaps>(context).userlat.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.searchbeststation),
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
                SizedBox(height: size.height * 0.02),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //   SizedBox(height: size.height * 0.08),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.searchparams,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),
                      Text(AppLocalizations.of(context)!.longitude),
                      TextFormField(
                        readOnly: true,
                        validator: (value) =>
                            Validator.validateName(value ?? "", context),
                        controller: longitudeController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.longitude,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(AppLocalizations.of(context)!.latitude),
                      TextFormField(
                        readOnly: true,
                        validator: (value) =>
                            Validator.validateName(value ?? "", context),
                        controller: latitudeController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.latitude,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(AppLocalizations.of(context)!.distancekm),
                      TextFormField(
                        readOnly: true,
                        validator: (value) =>
                            Validator.validateText(value ?? "", context),
                        controller: distanceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.distance,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      //Text(AppLocalizations.of(context)!.distance),
                      Slider(
                        min: 0.0,
                        max: 99.0,
                        value: _distance,
                        onChanged: (double newValue) async {
                          _distance = newValue;
                          //double.parse(newValue.toStringAsFixed(2));
                          //newValue.toStringAsFixed(2);
                          distanceController.text = newValue.toStringAsFixed(0);
                          setState(() {});
                        },
                      ),

                      SizedBox(height: size.height * 0.02),
                      Text(AppLocalizations.of(context)!.fueltype),
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
                            PriceEntries _p = PriceEntries();
                            FuelType _ft = _p.returnfuelType(value.toString());
                            _fuelType = _ft.name.toString();
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Wybierz rodzaj paliw';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(AppLocalizations.of(context)!.literstorefuel),
                      TextFormField(
                        validator: (value) =>
                            Validator.validateInt(value ?? "", context),
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.literstorefuel,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(AppLocalizations.of(context)!.burnRate),
                      TextFormField(
                        validator: (value) =>
                            Validator.validateDouble(value ?? "", context),
                        controller: burnRateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.burnRate,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(AppLocalizations.of(context)!.search),
                      DropdownButtonFormField(
                        value: _searchType,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        items: [
                          AppLocalizations.of(context)!.closest.toUpperCase(),
                          AppLocalizations.of(context)!.cheapest.toUpperCase(),
                          AppLocalizations.of(context)!.optimal.toUpperCase(),
                        ].map((fuelType) {
                          return DropdownMenuItem(
                            value: fuelType,
                            child: Row(
                              children: [
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
                            PriceEntries _p = PriceEntries();
                            FuelType _ft = _p.returnfuelType(value.toString());
                            setSearchType(value.toString());
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.06),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: searchStation,
                          child: Text(
                            AppLocalizations.of(context)!.search,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
