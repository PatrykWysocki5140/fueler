import 'package:flutter/material.dart';
import 'package:fueler/widgets/basic_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  //String tefxt = AppLocalizations.of(context)!.buttonClicksDescriptionLogin;
  // ignore: non_constant_identifier_names
//AppLocalizations.of(context)!.buttonClicksDescriptionLogin
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const <Widget>[
          /*Row(
              //children: const <Widget>[Text("Zaloguj się"), Icon(Icons.login)],
              ),*/
          IconWidget(icon: Icons.no_accounts),
          LoginWidget(
            icon: Icons.login,
            /*text: "text",*/
          ),
        ],
      ),
    );
  }
/*
  Widget rowWidget() {
    return Row(
      children: const <Widget>[Text("Zaloguj się"), Icon(Icons.login)],
    );
  }*/
}

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        //child: Center(
        child: Column(
          children: <Widget>[
            const Icon(Icons.no_accounts),
            Row(
              children: const <Widget>[Text("Zaloguj się"), Icon(Icons.login)],
            )
          ],
          // ),
        ),
      ),
    );
  }
  */
