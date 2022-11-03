import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fueler/settings_old/themes/styles.dart';

class LoadingScreen extends StatelessWidget {
  final Function onCompletion;

  const LoadingScreen({Key? key, required this.onCompletion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(onCompletion: onCompletion),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final Function onCompletion;

  const MyStatefulWidget({Key? key, required this.onCompletion})
      : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  final int seconds = 2;
  late final Timer timer;

  @override
  void initState() {
    timer = Timer(Duration(seconds: seconds * 2), () => widget.onCompletion());
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: seconds),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
