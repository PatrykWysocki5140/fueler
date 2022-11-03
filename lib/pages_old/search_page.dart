import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/settings_old/themes/styles.dart';
import 'package:fueler/widgets_old/checkbox.dart';
import 'package:fueler/widgets_old/stationinfo.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool checkboxValue = true;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              Text(AppLocalizations.of(context)!.searchSearchPage),
              Wrap(
                runSpacing: 20,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          AppLocalizations.of(context)!.localizationSearchPage),
                    ],
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .textValidator;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: GetColors.red),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CheckboxFormField(
                                title: "Orlen",
                              ),
                              CheckboxFormField(
                                title: "Shell",
                              ),
                            ],
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CheckboxFormField(
                                  title: "BP",
                                ),
                                CheckboxFormField(
                                  title: "Lotos",
                                ),
                              ],
                            ),
                          ),
                          CheckboxFormField(
                            title: "Wszystkie",
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.fuelcostSearchPage),
                    ],
                  ),
                  const StationInfo(
                    stationicon: Icons.login,
                    stationaddress: "Poznań, ulica: xyz 123A",
                    pb: 314.1,
                    on: 314,
                    lpg: 314,
                    grade: 1,
                  ),
                  const StationInfo(
                    stationicon: Icons.login,
                    stationaddress: "Poznań, ulica: xyz 123A",
                    pb: 314.1,
                    on: 314,
                    lpg: 314,
                    grade: 1,
                  ),
                  const StationInfo(
                    stationicon: Icons.login,
                    stationaddress: "Poznań, ulica: xyz 123A",
                    pb: 314.1,
                    on: 314,
                    lpg: 314,
                    grade: 1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
