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

class BrandsListScreen extends StatefulWidget {
  static String id = "user_screen";
  const BrandsListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BrandsListScreen> createState() => _BrandsListScreenState();
}

class _BrandsListScreenState extends State<BrandsListScreen> {
  bool firstload = true;
  //String _searchString = "";
  final TextEditingController _searchString = TextEditingController();
  List<Brand> objects = List.empty(growable: true);

  Future<Brand?> updateBrandListObject(String _uId, int _i) async {
    Brand? _b = await Provider.of<GoogleMaps>(context, listen: false)
        .getBrandById(_uId);

    objects[_i].name = _b.name.toString();
    objects[_i].image = _b.image;

    return _b;
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

  Future<bool?> deleteBrand(String _uId) async {
    bool? _response = await Provider.of<GoogleMaps>(context, listen: false)
        .deleteBrandById(_uId);
    return _response;
  }

  Future<bool?> updateBrand(
    String _uId,
    String _name,
    String _image,
  ) async {
    Response? _response = await Provider.of<GoogleMaps>(context, listen: false)
        .updateBrandById(_uId, _name, _image);
    return showResponse(_response!);
  }

  loadData() async {
    await Provider.of<GoogleMaps>(context, listen: false).getAllBrands();
    // Brand _b = Brand(id:"0",name:"",image:"");
    // _b.setValues("0", "", "");
    // _brands.add(_b);
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    List<Brand> _BrandToSearch = Provider.of<GoogleMaps>(context).brands;
    /*
    for (Brand obj in _BrandToSearch) {
      if (obj.brandId != null) {
        obj.setBrandObj(obj.brandId!);
      }
      log('StationsListScreen: ' + obj.toJsonAll().toString());
    }*/
    _searchString.text = _searchString.text.replaceAll(" ", "");
    log("_searchString: '" + _searchString.text + "'");
    if (_searchString.text == "") {
      objects = Provider.of<GoogleMaps>(context).brands;
    } else {
      Iterable<Brand> _Brand = _BrandToSearch.where((element) =>
          element.name
              .toLowerCase()
              .contains(_searchString.text.toLowerCase()) ||
          element.name
              .toLowerCase()
              .contains(_searchString.text.toLowerCase()));
      objects = List.empty(growable: true);

      for (Brand obj in _Brand) {
        log("find _Brand: " + obj.name.toString());
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
                        final TextEditingController imageControllerController =
                            TextEditingController();

                        Future<Brand?> _b;
                        _b = updateBrandListObject(
                            objects[index].id.toString(), index);
                        if (firstload == false) {}
                        nameController.text = objects[index].name.toString();
                        imageControllerController.text = objects[index].image;

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
                                              await updateBrand(
                                                  objects[index].id.toString(),
                                                  nameController.text,
                                                  imageControllerController
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
                                              await deleteBrand(
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
                                            .image),
                                        TextFormField(
                                          validator: (value) =>
                                              Validator.validateName(
                                                  value ?? "", context),
                                          controller: imageControllerController,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .image,
                                            isDense: true,
                                          ),
                                          onTap: () {},
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
                          "${AppLocalizations.of(context)!.name}: ${objects[index].name.toString()}\n${AppLocalizations.of(context)!.image}: ${objects[index].image.toString()}"),
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
