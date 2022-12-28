import 'dart:async';
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
import 'package:pin_code_fields/pin_code_fields.dart';

class VeryficationScreen extends StatefulWidget {
  static String id = "user_screen";
  const VeryficationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VeryficationScreen> createState() => _VeryficationScreenState();
}

class _VeryficationScreenState extends State<VeryficationScreen> {
  final bool _showPassword = true;
  //String _searchString = "";
  final TextEditingController _searchString = TextEditingController();
  List<PriceEntries> objects = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Api>(context).getMyPriceEntries();

    List<PriceEntries> _priceEntriesToSearch =
        Provider.of<Api>(context).mePriceEntries;
    _searchString.text = _searchString.text.replaceAll(" ", "");
    log("_searchString: '" + _searchString.text + "'");
    if (_searchString.text == "") {
      log("_searchString: empty");
      objects = Provider.of<Api>(context).mePriceEntries;
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
                  Provider.of<Api>(context).mePriceEntries.isEmpty == true
                      ? AppLocalizations.of(context)!.mypriceentriesempty
                      : AppLocalizations.of(context)!.mypriceentries,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              if (Provider.of<Api>(context).mePriceEntries.isEmpty == false)
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

class PinCodeVerificationScreen extends StatefulWidget {
  final String? phoneNumber;

  const PinCodeVerificationScreen({
    Key? key,
    this.phoneNumber,
  }) : super(key: key);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  resendSMS() {}

  // ignore: non_constant_identifier_names
  Future<bool?> veryfication(String _code) async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.warning,
      ));

      Response? _response =
          await Provider.of<Api>(context, listen: false).veryfication(_code);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_response?.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.success),
          backgroundColor: GetColors.success,
        ));
        Provider.of<Api>(context, listen: false).user.SetConfirm(true);
        Navigator.pop(context, true);
        //Navigator.of(context).pushNamed("/");
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.error),
          backgroundColor: GetColors.error,
        ));
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => {Navigator.pop(context, false)},
        ),
      ),
      //backgroundColor: Constants.primaryColor,
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.veryfiphonenumber,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: Text(
                  AppLocalizations.of(context)!.numbersendsms +
                      " " +
                      Provider.of<Api>(context).user.phoneNumber.toString(),
                  style: const TextStyle(
                      //color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      //backgroundColor: GetColors.green,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: GetColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      obscuringWidget: const Icon(Icons.blur_on_sharp),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (value) => Validator.validateVeryficationCode(
                          value ?? "", context),
                      pinTheme: PinTheme(
                        selectedColor: GetColors.green,
                        activeFillColor: GetColors.green,
                        activeColor: GetColors.green,
                        //selectedColor: GetColors.green,
                        inactiveColor: GetColors.black,
                        disabledColor: GetColors.warning,
                        //activeFillColor: GetColors.green,
                        selectedFillColor: GetColors.white,
                        inactiveFillColor: GetColors.warning,
                        //errorBorderColor: GetColors.green,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        //activeFillColor: Colors.black12,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          //color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.nosms,
                    style: TextStyle(
                        //color: Colors.black54,
                        fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () => resendSMS(),
                    child: Text(
                      AppLocalizations.of(context)!.resend,
                      style: TextStyle(
                          // color: Color(0xFF91D3B3),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                      // conditions for validating
                      // ignore: unrelated_type_equality_checks
                      if (currentText.length != 6 ||
                          veryfication(currentText) != true) {
                        errorController!.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() => hasError = true);
                      } else {
                        setState(
                          () {
                            hasError = false;
                          },
                        );
                      }
                    },
                    child: Center(
                        child: Text(
                      AppLocalizations.of(context)!.veryfi,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                    color: GetColors.success,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: GetColors.success,
                          offset: const Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: GetColors.success,
                          offset: const Offset(-1, 2),
                          blurRadius: 5)
                    ]),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: TextButton(
                    child: Text(AppLocalizations.of(context)!.clear),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
