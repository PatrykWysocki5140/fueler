import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fueler/model/API_Model/FuelType.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/routes/UI/widgets/price_entry_widget.dart';

import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/API_Model/User.dart';
import '../../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../../notifiers/APINotifier.dart';
import '../../../../settings/Get_colors.dart';
import '../../../../settings/validator.dart';

class PriceEntriesScreen extends StatefulWidget {
  //static String id = "user_screen";
/*
  const PriceEntriesScreen({
    required String id,
    Key? key,
  }) : super(key: key);
*/
  final String id;
  const PriceEntriesScreen(this.id);

  @override
  // ignore: no_logic_in_create_state
  State<PriceEntriesScreen> createState() => _PriceEntriesScreenState(id);
}

class _PriceEntriesScreenState extends State<PriceEntriesScreen> {
  final bool _showPassword = true;
  //String _searchString = "";
  final TextEditingController _searchString = TextEditingController();
  List<PriceEntries> objects = List.empty(growable: true);

  final String _userId;
  _PriceEntriesScreenState(this._userId);

  @override
  void initState() {
    super.initState();
    Provider.of<Api>(context, listen: false).getPriceEntriesByUserId(_userId);
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<Api>(context, listen: false).searchpriceEntrie = List.empty();
    setState(() {
      Provider.of<Api>(context).getPriceEntriesByUserId(_userId);
    });
    //Provider.of<Api>(context).getPriceEntriesByUserId(_userId);

    List<PriceEntries> _priceEntriesToSearch =
        Provider.of<Api>(context).searchpriceEntrie;
    _searchString.text = _searchString.text.replaceAll(" ", "");
    log("_searchString: '" + _searchString.text + "'");
    if (_searchString.text == "") {
      log("_searchString: empty");
      objects = Provider.of<Api>(context).searchpriceEntrie;
    } else {
      Iterable<PriceEntries> _pe = _priceEntriesToSearch.where((element) =>
          element.id.toLowerCase().contains(_searchString.text.toLowerCase()) ||
          element.price
              .toLowerCase()
              .contains(_searchString.text.toLowerCase()) ||
          element.fuelType
              .toString()
              .toLowerCase()
              .contains(_searchString.text.toLowerCase()));
      objects = List.empty(growable: true);

      for (PriceEntries obj in _pe) {
        log("find _pe: " + obj.id.toString());
        objects.add(obj);
      }
    }
    //final List<User> objects = Provider.of<Api>(context).users;
    var size = MediaQuery.of(context).size;

    //Provider.of<Api>(context).getAllUsers();
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
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.06),
              Center(
                child: Text(
                  _priceEntriesToSearch.isEmpty == true
                      ? AppLocalizations.of(context)!.mypriceentriesempty
                      : AppLocalizations.of(context)!.mypriceentries,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              if (_priceEntriesToSearch.isEmpty == false)
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
                              FuelType _ft = FuelType.UNDEFINED;
                              final TextEditingController idController =
                                  TextEditingController();
                              final TextEditingController priceController =
                                  TextEditingController();

                              final TextEditingController addedByController =
                                  TextEditingController();
                              final TextEditingController
                                  fuelStationController =
                                  TextEditingController();

                              _ft = Provider.of<Api>(context)
                                  .priceEntry
                                  .getFuelType(
                                      objects[index].fuelType.toString());

                              idController.text = objects[index].id.toString();
                              priceController.text =
                                  objects[index].price.toString();
                              addedByController.text =
                                  objects[index].addedBy.toString();
                              fuelStationController.text =
                                  objects[index].fuelStation.toString();

                              return Scaffold(
                                appBar: AppBar(
                                  leading: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                    ),
                                    onPressed: () => {
                                      idController.clear(),
                                      priceController.clear(),
                                      addedByController.clear(),
                                      fuelStationController.clear(),
                                      Provider.of<Api>(context, listen: false)
                                          .searchpriceEntrie = List.empty(),
                                      Navigator.of(context).pop(),
                                    },
                                  ),
                                  title: Text(
                                      " ID:" + objects[index].id.toString()),
                                  centerTitle: true,
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
                                          PriceEntryWidget(objects[index])
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
                                "${AppLocalizations.of(context)!.price}: ${objects[index].price.toString()}\n${AppLocalizations.of(context)!.fueltype}: ${objects[index].getFuelType(objects[index].fuelType.toString()).name}\n${AppLocalizations.of(context)!.addedby}: ${objects[index].addedBy.toString()}\n${AppLocalizations.of(context)!.fuelstation}: ${objects[index].fuelStation.toString()}"),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
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
