import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class AddWidget extends StatefulWidget {
  const AddWidget({Key? key}) : super(key: key);

  //final PriceEntries pe;
  //const AddPriceEntryWidget(this.pe);

  @override
  // ignore: no_logic_in_create_state
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  addPriceEntry() {
    Navigator.of(context).pushNamed("/map/add/addpriceentry");
  }

  void addFuelStation() {
    Navigator.of(context).pushNamed("/map/add/addstation");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.sendrequest),
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
                SizedBox(height: size.height * 0.01),
                if (Provider.of<GoogleMaps>(context, listen: false)
                    .searchFuelStations
                    .isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: addPriceEntry,
                      child: Text(
                        AppLocalizations.of(context)!.addprice,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: size.height * 0.01),
                if (Provider.of<Api>(context).user.isConfirmed == true)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: addFuelStation,
                      child: Text(
                        AppLocalizations.of(context)!.addstation,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}
