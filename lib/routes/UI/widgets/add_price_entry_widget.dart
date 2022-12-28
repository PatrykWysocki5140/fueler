import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fueler/model/API_Model/FuelType.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';

import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/API_Model/User.dart';
import '../../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../../notifiers/APINotifier.dart';
import '../../../../settings/Get_colors.dart';
import '../../../../settings/validator.dart';

class AddPriceEntryWidget extends StatefulWidget {
  const AddPriceEntryWidget({Key? key}) : super(key: key);

  //final PriceEntries pe;
  //const AddPriceEntryWidget(this.pe);

  @override
  // ignore: no_logic_in_create_state
  State<AddPriceEntryWidget> createState() => _AddPriceEntryWidgetState();
}

class _AddPriceEntryWidgetState extends State<AddPriceEntryWidget> {
  //final PriceEntries pe;
  // _AddPriceEntryWidgetState(this.pe);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
      body: SingleChildScrollView(
        child: Container(
            //width: size.width * 0.85,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
            ),
            child: Column(
              children: [Text("test")],
            )),
      ),
    );
  }
}
