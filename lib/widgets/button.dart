import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//import 'package:gallery/demos/material/material_demo_types.dart';
class FloatingActionButtonDemo2 extends StatefulWidget {
  const FloatingActionButtonDemo2({Key? key}) : super(key: key);

  @override
  _FloatingActionButtonDemo createState() => _FloatingActionButtonDemo();
}

class _FloatingActionButtonDemo extends State<FloatingActionButtonDemo2> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40),
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
