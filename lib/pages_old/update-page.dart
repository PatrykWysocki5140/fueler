import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../layouts_old/main-layout.dart';
import '../settings_old/themes/styles.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  int currentlyOpenedFuels = 3;
  final List<String> possibleFuels = const ["PB", "ON", "LPG"];
  String fuelUsedByFirst = "ON";
  String fuelUsedBySecond = "PB";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          title: Text(AppLocalizations.of(context)!.updateStation),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  ...List<Widget>.generate(
                      currentlyOpenedFuels,
                      (index) => Row(
                            key: Key(index.toString()),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: DropdownButton(
                                    value: possibleFuels
                                        .where((element) =>
                                            (index == 0 &&
                                                element == fuelUsedByFirst) ||
                                            (index == 1 &&
                                                ((fuelUsedByFirst ==
                                                        fuelUsedBySecond)
                                                    ? element != fuelUsedByFirst
                                                    : element ==
                                                        fuelUsedBySecond)) ||
                                            (index == 2 &&
                                                element != fuelUsedByFirst &&
                                                element != fuelUsedBySecond))
                                        .first,
                                    items: possibleFuels
                                        .where((element) =>
                                            index == 0 ||
                                            (index == 1 &&
                                                element != fuelUsedByFirst) ||
                                            (index == 2 &&
                                                element != fuelUsedByFirst &&
                                                element != fuelUsedBySecond))
                                        .map((element) => DropdownMenuItem(
                                              child: Text(element),
                                              value: element,
                                            ))
                                        .toList(),
                                    onChanged: (String? value) => {
                                          if (index == 0)
                                            {
                                              setState(() => fuelUsedByFirst =
                                                  value ?? fuelUsedByFirst)
                                            }
                                          else if (index == 1)
                                            {
                                              setState(() => fuelUsedBySecond =
                                                  value ?? fuelUsedBySecond)
                                            }
                                        }),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText:
                                          AppLocalizations.of(context)!.price,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(),
                                      )),
                                  validator: (value) {
                                    if (value == null) {
                                      return AppLocalizations.of(context)!
                                          .nullValidator;
                                    } else if (value.length.isInfinite) {
                                    } else if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .plainNumberValidator;
                                    } else if (!RegExp(r'^[0-9\.]*$')
                                        .hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .plainNumberValidator;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: GetColors.red),
                                ),
                              ),
                              ...index == currentlyOpenedFuels - 1 && index != 2
                                  ? [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: FloatingActionButton(
                                          heroTag: index,
                                          onPressed: () {
                                            setState(
                                                () => currentlyOpenedFuels++);
                                          },
                                          child: Icon(Icons.add),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                        ),
                                      )
                                    ]
                                  : [SizedBox()],
                              ...index == currentlyOpenedFuels - 1 && index != 0
                                  ? [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: FloatingActionButton(
                                          heroTag: index.toString() + "qwertyy",
                                          onPressed: () {
                                            setState(
                                                () => currentlyOpenedFuels--);
                                          },
                                          child: Icon(Icons.remove),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                        ),
                                      )
                                    ]
                                  : [SizedBox()]
                            ],
                          )),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        FloatingActionButton.extended(
                          heroTag: "12345",
                          label:
                              Text(AppLocalizations.of(context)!.updateStation),
                          icon: const Icon(Icons.update),
                          onPressed: () {
                            if (_formKey.currentState!.validate() == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainLayout(page: 5)));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
