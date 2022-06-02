import 'package:flutter/material.dart';
import 'package:fueler/layouts/main-layout.dart';
import 'package:fueler/settings/themes/styles.dart';
import 'package:fueler/widgets/basic_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/widgets/checkbox.dart';
import 'package:fueler/widgets/stationinfo.dart';
import '../widgets/log-in.dart';

class UserLess extends StatefulWidget {
  const UserLess({Key? key}) : super(key: key);

  @override
  _UserLess createState() => _UserLess();
}

class _UserLess extends State<UserLess> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool checkboxValue = true;
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10),
            const Login(),
            Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.phonenumber,
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
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.username,
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
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.password,
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
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.passwordrepeat,
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
                        const SizedBox(height: 10),
                        const RegisterWidget()
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
