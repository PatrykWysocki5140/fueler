import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:fueler/routes/UI/user_admin_screen/widgets/stations_list_widget.dart';

import 'package:fueler/routes/UI/user_admin_screen/widgets/users_list_widget.dart';
import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/API_Model/User.dart';
import '../../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../../notifiers/APINotifier.dart';
import '../../../../settings/Get_colors.dart';
import '../../../../settings/validator.dart';

class FuelStationsAdminScreen extends StatefulWidget {
  static String id = "user_screen";
  const FuelStationsAdminScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FuelStationsAdminScreen> createState() =>
      _FuelStationsAdminScreenState();
}

class _FuelStationsAdminScreenState extends State<FuelStationsAdminScreen> {
  List<FuelStation> _allFuelStations = List.empty(growable: true);
  loadData() async {
    await loadAllFuelStation();
  }

  Future<void> loadAllFuelStation() async {
    Response? _response = await Provider.of<GoogleMaps>(context, listen: false)
        .getAllFuelStation();
    _allFuelStations =
        await Provider.of<GoogleMaps>(context, listen: false).allFuelStations;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<Api>(context).getAllUsers();

    var size = MediaQuery.of(context).size;
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
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.03),
              Center(
                child: Text(
                  Provider.of<GoogleMaps>(context).allFuelStations.isEmpty ==
                          true
                      ? AppLocalizations.of(context)!.ifstationslistisemptyerror
                      : AppLocalizations.of(context)!.searchtoeditstation,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                child: StationsListScreen(),
              ),
            ],
          ),
        ));

    // implement the list view

/*
    return Scaffold(
      body: ListView.builder(
          itemCount: objects.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(objects[index]),
              // Po kliknięciu w element listy wyświetl szczegóły obiektu
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(objects[index]['phoneNumber']),
                    );
                  },
                );
              },
            );
          },
        ),
      );*/
  }
}