import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//import 'package:gallery/demos/material/material_demo_types.dart';
class FloatingActionButtonDemo extends StatefulWidget {
  const FloatingActionButtonDemo({Key? key}) : super(key: key);

  @override
  _FloatingActionButtonDemo createState() => _FloatingActionButtonDemo();
}

// ignore: unused_element
class _FloatingActionButtonDemo extends State<FloatingActionButtonDemo> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: localizations.buttonClicksDescription,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 20),
          FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: Text(localizations.buttonClicksDescription),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
