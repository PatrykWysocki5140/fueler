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

class PriceEntryWidget extends StatefulWidget {
  final PriceEntries pe;
  const PriceEntryWidget(this.pe);

  @override
  // ignore: no_logic_in_create_state
  State<PriceEntryWidget> createState() => _PriceEntryWidgetState(pe);
}

class _PriceEntryWidgetState extends State<PriceEntryWidget> {
  final bool _showPassword = true;

  final TextEditingController _searchString = TextEditingController();
  List<PriceEntries> objects = List.empty(growable: true);

  final PriceEntries pe;
  _PriceEntryWidgetState(this.pe);
  User _user = User();
  late FuelStation _station;
  //FuelStation.fromJsonMap("{id: a41b9a8f-c23a-413d-bff1-0ff73c2123e4, coordinates: 52.396629821084595,16.948683340512122, name: BP, brand: 948ad547-7a66-4050-96df-5c4e4c03356e, priceEntries: [{id: c6dec0e7-6042-43b5-a6cd-113a41a92f3a, price: 8.5, fuelType: DIESEL, addedBy: b8424a07-bfa5-4104-beaf-ed7c0e1f6237, fuelStation: a41b9a8f-c23a-413d-bff1-0ff73c2123e4}, {id: 0baf96ae-2e36-48ac-b063-2e207dcfd4bc, price: 12, fuelType: GASOLINE95, addedBy: 1b5770ba-437a-46b1-9ad3-e0955198813a, fuelStation: a41b9a8f-c23a-413d-bff1-0ff73c2123e4}]}");

  String assets = "";

  Future<bool> findUserById(String _uId) async {
    //User? _u = await Provider.of<Api>(context).getUserById(_uId);
    /// nie działą ???
    List<User> _users = Provider.of<Api>(context).users;
    for (User obj in _users) {
      if (obj.id == _uId) {
        _user = obj;
      }
    }
    return true;
  }

  Future<bool> findStationById(String _uId) async {
    //User? _u = await Provider.of<Api>(context).getUserById(_uId);
    /// nie działą ???
    // FuelStation? _station;
    List<FuelStation> _stations =
        Provider.of<GoogleMaps>(context, listen: false).allFuelStations;
    for (FuelStation obj in _stations) {
      if (obj.id == _uId) {
        _station = obj;
      }
    }
    _station = (await Provider.of<GoogleMaps>(context, listen: false)
        .getFuelStationById(_uId))!;
    return true;
  }

  @override
  void initState() {
    findStationById(pe.fuelStation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<Api>(context).searchpriceEntrie = List.empty();
    var size = MediaQuery.of(context).size;
    if (Provider.of<Api>(context).user.userPrivilegeLevel ==
        UserPrivilegeLevel.ADMINISTRATOR) {
      findUserById(pe.addedBy.toString());
    } else {
      _user = Provider.of<Api>(context).user;
    }
    assets = pe.icon;
    log("station PriceEntryWidget " + _station.name);
    /*
    if (pe.fuelType == FuelType.CNG) {
      assets = 'assets/cng.png';
    } else if (pe.fuelType == FuelType.DIESEL) {
      assets = 'assets/on.png';
    } else if (pe.fuelType == FuelType.DIESEL_PREMIUM) {
      assets = 'assets/premiumon.png';
    } else if (pe.fuelType == FuelType.GASOLINE95) {
      assets = 'assets/pb95.png';
    } else if (pe.fuelType == FuelType.GASOLINE98) {
      assets = 'assets/pb98.png';
    } else if (pe.fuelType == FuelType.GASOLINE_PREMIUM) {
      assets = 'assets/premiumpb.png';
    } else if (pe.fuelType == FuelType.LPG) {
      assets = 'assets/lpg.png';
    }*/

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        //color: GetColors.mainColorLight,
        decoration: BoxDecoration(
            color: GetColors.mainColorLight,
            border: Border.all(
              color: GetColors.black,
              width: 5,
            )),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.price,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Text(
                  pe.price.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.type,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Text(
                  pe.getFuelType(pe.fuelType.toString()).name.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      assets,
                      width: 60,
                    ), /*
                    CircleAvatar(
                      radius: 18,
                      child: ClipOval(
                        child: Image.asset(
                          assets,
                          width: 250,
                          height: 250,
                        ),
                      ),
                    ),*/
                  ],
                ),
              ],
            ),
            if (Provider.of<Api>(context).user.userPrivilegeLevel ==
                UserPrivilegeLevel.ADMINISTRATOR)
              Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.addedby,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Text(
                        _user.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            // ignore: unnecessary_null_comparison
            if (_station != null)
              Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.fuelstation,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Text(
                        _station.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.address,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Text(
                        _station.address ?? "...",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.latitude,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Text(
                        _station.coordinates.latitude.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.longitude,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Text(
                        _station.coordinates.longitude.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.fuelstation,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Text(
                        pe.fuelStation.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: size.height * 0.02),

/*
            Container(
              height: 120.0,
              width: 120.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/on.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            )*/
          ],
        ),
      ),
    );

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

/*
_up 
_isConfirmed
_isBanned
idController 
phoneNumberController 
 nameController
 firstpasswordController 
emailController 
*/
