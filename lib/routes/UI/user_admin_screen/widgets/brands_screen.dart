import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fueler/model/API_Model/Brand.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:fueler/routes/UI/user_admin_screen/widgets/brands_list_widget.dart';
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

class BrandsAdminScreen extends StatefulWidget {
  static String id = "user_screen";
  const BrandsAdminScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BrandsAdminScreen> createState() => _BrandsAdminScreenState();
}

class _BrandsAdminScreenState extends State<BrandsAdminScreen> {
  List<Brand> _allBrands = List.empty(growable: true);
  loadData() async {
    await loadAllBrands();
  }

  Future<void> loadAllBrands() async {
    Response? _response =
        await Provider.of<GoogleMaps>(context, listen: false).getAllBrands();
    Response? _response2 =
        await Provider.of<GoogleMaps>(context, listen: false).getAllBrands();
    _allBrands = await Provider.of<GoogleMaps>(context, listen: false).brands;
  }

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<Api>(context).getAllUsers();

    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.allbrands),
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context)
                        .pushNamed("/profile/brands/addnewbrand");
                  },
                  child: Text(
                    AppLocalizations.of(context)!.addbrand,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Center(
                child: Text(
                  Provider.of<GoogleMaps>(context).brands.isEmpty == true
                      ? AppLocalizations.of(context)!.ifbrandslistisemptyerror
                      : AppLocalizations.of(context)!.searchtoeditbrand,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                child: BrandsListScreen(),
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
