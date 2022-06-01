import 'package:flutter/material.dart';
import 'package:fueler/settings/themes/styles.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GetColors.gray,
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  'Skanowanie najtańszych cen paliw...',
                  style: TextStyle(fontSize: 20),
                ),
                Transform.scale(
                  scale: 2.0,
                  child: CircularProgressIndicator(
                    value: controller.value,
                    semanticsLabel: 'Linear progress indicator',
                    valueColor: AlwaysStoppedAnimation<Color>(GetColors.red),
                    backgroundColor: GetColors.black,
                    strokeWidth: 14.0,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
