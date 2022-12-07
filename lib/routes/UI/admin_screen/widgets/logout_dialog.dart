import 'package:flutter/material.dart';
import 'package:fueler/notifiers/APINotifier.dart';

import '../../../../settings/Get_colors.dart';
import '../../../../settings/validator.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.alertdialogtitlewarning),
      content: Text(AppLocalizations.of(context)!.alertdialogdescriptionlogout),
      actions: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(GetColors.success)),
                    onPressed: () => Navigator.pop(
                        context, AppLocalizations.of(context)!.cancel),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(GetColors.red)),
                    onPressed: () => {
                      Provider.of<Api>(context, listen: false).LogOut(),
                      Navigator.pop(context, AppLocalizations.of(context)!.ok)
                    },
                    child: Text(AppLocalizations.of(context)!.ok),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/*
class LogOutDialog extends StatelessWidget {
  const LogOutDialog(
      {required this.height,
      required this.phoneNumberController,
      required this.textFormTitle,
      Key? key})
      : super(key: key);

  final double height;
  final TextEditingController phoneNumberController;
  final String textFormTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.03),
        Text(textFormTitle),
        TextFormField(
          validator: (value) =>
              Validator.validatePhoneNumber(value ?? "", context),
          controller: phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            isDense: true,
          ),
        ),
      ],
    );
  }
}*/
