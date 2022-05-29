import 'package:flutter/material.dart';
import 'package:fueler/widgets/main_button.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
              //children: const <Widget>[Text("Zaloguj się"), Icon(Icons.login)],
              ),
          const Icon(Icons.no_accounts, size: 50.0),
          const LoginWidget(
            icon: Icons.login,
            text: "zaloguj sie",
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