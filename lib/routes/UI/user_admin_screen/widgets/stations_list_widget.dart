import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fueler/model/API_Model/Brand.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:fueler/routes/UI/user_admin_screen/widgets/price_entries_list_widget.dart';

import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../model/API_Model/User.dart';
import '../../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../../notifiers/APINotifier.dart';
import '../../../../settings/Get_colors.dart';
import '../../../../settings/validator.dart';

class StationsListScreen extends StatefulWidget {
  static String id = "user_screen";
  const StationsListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StationsListScreen> createState() => _StationsListScreenState();
}

class _StationsListScreenState extends State<StationsListScreen> {
  bool firstload = true;
  final bool _showPassword = true;
  //String _searchString = "";
  final TextEditingController _searchString = TextEditingController();
  List<FuelStation> objects = List.empty(growable: true);
  late Brand _selectedBrand;
  late List<Brand> _brands;

  Future<FuelStation?> updateStationListObject(String _uId, int _i) async {
    FuelStation? _f = await Provider.of<GoogleMaps>(context, listen: false)
        .getFuelStationById(_uId);

    objects[_i].name = _f!.name.toString();
    objects[_i].coordinates = _f.coordinates;
    objects[_i].brand = _f.brandId ?? "";
    return _f;
  }

  Future<bool> showResponse(Response _response) async {
    firstload = false;
    if (_response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.success),
        backgroundColor: GetColors.success,
      ));
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.error),
        backgroundColor: GetColors.error,
      ));
      return false;
    }
  }

  Future<bool?> deleteStation(String _uId) async {
    bool? _response = await Provider.of<GoogleMaps>(context, listen: false)
        .deleteStationById(_uId);
    return _response;
  }

  Future<bool?> updateStation(String _uId, String _longitude, String _latitude,
      String _name, String _brand) async {
    Response? _response = await Provider.of<GoogleMaps>(context, listen: false)
        .updateStationById(_uId, _longitude, _latitude, _name, _brand);
    return showResponse(_response!);
  }

  Future<bool> updateUser(
    User _u,
    String _newname,
    String _newphoneNumber,
    String _newemail,
  ) async {
    _u.SetNewName(_newname);
    _u.SetNewPhoneNumber(_newphoneNumber);
    _u.SetNewEmail(_newemail);
    Response? _response =
        await Provider.of<Api>(context, listen: false).updateUserById(_u);
    return showResponse(_response!);
  }

  loadData() async {
    await Provider.of<GoogleMaps>(context, listen: false).getAllBrands();
    loadData();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _brands = Provider.of<GoogleMaps>(context, listen: false).brands;
    _selectedBrand = _brands[0];
    List<FuelStation> _fuelStationToSearch =
        Provider.of<GoogleMaps>(context).allFuelStations;
    for (FuelStation obj in _fuelStationToSearch) {
      if (obj.brandId != null) {
        obj.setBrandObj(obj.brandId!);
      }
      log('StationsListScreen: ' + obj.toJsonAll().toString());
    }
    _searchString.text = _searchString.text.replaceAll(" ", "");
    log("_searchString: '" + _searchString.text + "'");
    if (_searchString.text == "") {
      objects = Provider.of<GoogleMaps>(context).allFuelStations;
    } else {
      Iterable<FuelStation> _fuelStation = _fuelStationToSearch.where(
          (element) =>
              element.name
                  .toLowerCase()
                  .contains(_searchString.text.toLowerCase()) ||
              element.address!
                  .toLowerCase()
                  .contains(_searchString.text.toLowerCase()) ||
              element
                  .brand
                  .toLowerCase()
                  .contains(_searchString.text.toLowerCase()) ||
              element.coordinates
                  .toString()
                  .toLowerCase()
                  .contains(_searchString.text.toLowerCase()));
      objects = List.empty(growable: true);

      for (FuelStation obj in _fuelStation) {
        log("find _fuelStation: " + obj.name.toString());
        objects.add(obj);
      }
    }
    //final List<User> objects = Provider.of<Api>(context).users;
    var size = MediaQuery.of(context).size;
    //Provider.of<Api>(context).getAllUsers();
    return Column(
      children: [
        SizedBox(height: size.height * 0.03),
        TextField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.search,
            suffixIcon: IconButton(
              onPressed: _searchString.clear,
              icon: const Icon(Icons.search),
            ),
          ),
          onChanged: (String value) {
            setState(() {
              // Aktualizacja listy po wpisaniu frazy
              log(_searchString.text);
              _searchString.text = value;
            });
          },
        ),
        Expanded(
          child: ListView.builder(
              // the number of items in the list
              itemCount: objects.length,
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              //physics: NeverScrollableScrollPhysics(),
              // display each item of the product list
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final TextEditingController nameController =
                            TextEditingController();
                        final TextEditingController
                            longitudeControllerController =
                            TextEditingController();
                        final TextEditingController
                            latitudeControllerController =
                            TextEditingController();
                        final TextEditingController brandControllerController =
                            TextEditingController();
                        final TextEditingController
                            addressControllerController =
                            TextEditingController();

                        Future<FuelStation?> _f;
                        _f = updateStationListObject(
                            objects[index].id.toString(), index);
                        if (firstload == false) {}
                        nameController.text = objects[index].name.toString();
                        brandControllerController.text =
                            objects[index].brandObj!.id;
                        longitudeControllerController.text =
                            objects[index].coordinates.longitude.toString();
                        latitudeControllerController.text =
                            objects[index].coordinates.latitude.toString();
                        addressControllerController.text =
                            objects[index].address.toString();
                        String googleMapsUrl =
                            "google.navigation:q=${latitudeControllerController.text},${longitudeControllerController.text}";
                        return Scaffold(
                          appBar: AppBar(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                              ),
                              onPressed: () => {
                                Navigator.of(context).pop(),
                              },
                            ),
                            title: Text(objects[index].id.toString()),
                            //centerTitle: true,
                          ),
                          body: SingleChildScrollView(
                            child: Container(
                                //width: size.width * 0.85,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await updateStation(
                                                  objects[index].id.toString(),
                                                  longitudeControllerController
                                                      .text,
                                                  latitudeControllerController
                                                      .text,
                                                  nameController.text,
                                                  brandControllerController
                                                      .text);
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .update,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            /*
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<Color>(
                                                            GetColors.warning)),*/
                                            onPressed: () async {
                                              await deleteStation(
                                                  objects[index].id);
                                              // ignore: list_remove_unrelated_type
                                              objects.remove(index);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .delete,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Form(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: size.height * 0.03),
                                        Text(
                                            AppLocalizations.of(context)!.name),
                                        TextFormField(
                                          validator: (value) =>
                                              Validator.validateName(
                                                  value ?? "", context),
                                          controller: nameController,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .name,
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text(AppLocalizations.of(context)!
                                            .latitude),
                                        TextFormField(
                                          validator: (value) => Validator
                                              .validateCoordinatesLatitude(
                                                  value ?? "", context),
                                          controller:
                                              latitudeControllerController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .latitude,
                                            isDense: true,
                                          ),
                                          onTap: () {},
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text(AppLocalizations.of(context)!
                                            .longitude),
                                        TextFormField(
                                          validator: (value) => Validator
                                              .validateCoordinatesLongitude(
                                                  value ?? "", context),
                                          controller:
                                              longitudeControllerController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .longitude,
                                            isDense: true,
                                          ),
                                          onTap: () {},
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text(AppLocalizations.of(context)!
                                            .brandid),
                                        TextFormField(
                                          validator: (value) =>
                                              Validator.validateName(
                                                  value ?? "", context),
                                          controller: brandControllerController,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .brand,
                                            isDense: true,
                                          ),
                                          onTap: () {},
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text(AppLocalizations.of(context)!
                                            .address),
                                        TextFormField(
                                          validator: (value) =>
                                              Validator.validateName(
                                                  value ?? "", context),
                                          controller:
                                              addressControllerController,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .address,
                                            isDense: true,
                                          ),
                                          onTap: () async => {
                                            //Navigator.pop(context, true),
                                            // ignore: deprecated_member_use
                                            await launch(googleMapsUrl),
                                          },
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text(AppLocalizations.of(context)!
                                            .searchbrand),
                                        DropdownButtonFormField(
                                          value: _selectedBrand,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 42,
                                          items: _brands.map((brand) {
                                            FuelStation _fs = FuelStation();
                                            String image =
                                                'assets/stationslogo/default.png';
                                            for (Brand obj in _brands) {
                                              if (brand.image == obj.image) {
                                                image = obj.image;
                                              }
                                            }
                                            return DropdownMenuItem(
                                              value: brand,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width:
                                                            size.height * 0.03),
                                                    SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        brand.name.toString(),
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                              _selectedBrand = value as Brand;
                                              brandControllerController.text =
                                                  _selectedBrand.id;
                                            });
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Wybierz stację paliw';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ))
                                  ],
                                )),
                          ),
                        );

                        //return Text("gggg");
                      },
                    );
                  },
                  child: Card(
                    // In many cases, the key isn't mandatory
                    key: ValueKey(objects[index]),
                    //margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                          "${AppLocalizations.of(context)!.name}: ${objects[index].name.toString()}\n${AppLocalizations.of(context)!.latitude}: ${objects[index].coordinates.latitude.toString()}\n${AppLocalizations.of(context)!.longitude}: ${objects[index].coordinates.longitude.toString()}"),
                    ),
                  ),
                );
              }),
        ),
      ],
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
