import 'package:flutter/material.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/notifiers/APINotifier.dart';

import '../../../../settings/Get_colors.dart';
import '../../../../settings/validator.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StationDialog extends StatelessWidget {
  final FuelStation fuelstation;

  const StationDialog({Key? key, required this.fuelstation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _snippet = "";
    if (fuelstation.prices != null) {
      for (PriceEntries obj in fuelstation.prices!) {
        _snippet += obj.getFuelType(obj.fuelType.toString()).name +
            ": " +
            obj.price.toString() +
            "\n";
      }
    }
    FuelStation _fs = fuelstation;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          //SizedBox(height: size.height * 0.03),
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
                      //style: ButtonStyle(backgroundColor:MaterialStatePropertyAll<Color>(GetColors.success)),
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(AppLocalizations.of(context)!.back),
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
                      //style: ButtonStyle(backgroundColor:MaterialStatePropertyAll<Color>(GetColors.red)),
                      onPressed: () => {
                        Navigator.pop(context, true),
                      },
                      child: Text(AppLocalizations.of(context)!.navigate),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                _fs.brand,
                // width: 60,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_fs.coordinates.latitude.toString() +
                  " " +
                  _fs.coordinates.longitude.toString())
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _fs.prices!.isEmpty
                    ? AppLocalizations.of(context)!.priceentrieshistoryempty
                    : AppLocalizations.of(context)!.priceentrieshistory,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              itemCount: _fs.prices?.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //SizedBox(width: size.height * 0.01),
                                    Image.asset(
                                      _fs.prices![index].icon,
                                      width: 60,
                                    ),
                                    SizedBox(width: size.height * 0.01),
                                    Text(
                                      fuelstation.prices![index]
                                          .getFuelType(fuelstation
                                              .prices![index].fuelType
                                              .toString())
                                          .name,
                                      style: const TextStyle(
                                          // color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //SizedBox(width: size.height * 0.03),
                                    Text(
                                      AppLocalizations.of(context)!.price,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          //color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: size.height * 0.03),
                                    Text(
                                      fuelstation.prices![index].price,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          //color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
