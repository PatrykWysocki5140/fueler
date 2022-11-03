import 'package:flutter/material.dart';
import 'package:fueler/settings_old/themes/styles.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const Settings());
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Settings',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(secondary: Colors.grey)),
      home: const _SettingsStat(),
    );
  }
}

class _SettingsStat extends StatefulWidget {
  const _SettingsStat({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_SettingsStat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: const Center(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            height: 60,
            width: 170,
            bottom: 300,
            left: 445,
            child: FloatingActionButton.extended(
              label: const Text("Ulubione",
                  style: TextStyle(
                      color: Color.fromARGB(255, 31, 30, 30),
                      fontSize: 15,
                      shadows: [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 2),
                            blurRadius: 4)
                      ],
                      fontWeight: FontWeight.bold)),
              tooltip: 'Grade',
              heroTag: 'Grade',
              onPressed: () {/* Do something */},
              icon: const Icon(
                Icons.grade,
                size: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 60,
            width: 170,
            bottom: 300,
            right: 445,
            child: FloatingActionButton.extended(
              label: const Text("Pobrane",
                  style: TextStyle(
                      color: Color.fromARGB(255, 31, 30, 30),
                      fontSize: 15,
                      shadows: [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 2),
                            blurRadius: 4)
                      ],
                      fontWeight: FontWeight.bold)),
              tooltip: 'Download',
              onPressed: () {/* Do something */},
              icon: const Icon(
                Icons.download,
                size: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 60,
            width: 170,
            bottom: 230,
            left: 445,
            child: FloatingActionButton.extended(
              label: const Text("Płatności",
                  style: TextStyle(
                      color: Color.fromARGB(255, 31, 30, 30),
                      fontSize: 15,
                      shadows: [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 2),
                            blurRadius: 4)
                      ],
                      fontWeight: FontWeight.bold)),
              tooltip: 'Payment',
              heroTag: 'shopping_cart_checkout',
              onPressed: () {/* Do something */},
              icon: const Icon(
                Icons.shopping_cart_checkout,
                size: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 60,
            width: 170,
            bottom: 230,
            right: 445,
            child: FloatingActionButton.extended(
              label: const Text("Logowanie",
                  style: TextStyle(
                      color: Color.fromARGB(255, 31, 30, 30),
                      fontSize: 15,
                      shadows: [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 2),
                            blurRadius: 4)
                      ],
                      fontWeight: FontWeight.bold)),
              tooltip: 'Log in',
              heroTag: 'Log in',
              onPressed: () {/* Do something */},
              icon: const Icon(
                Icons.login,
                size: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 60,
            width: 170,
            bottom: 160,
            left: 445,
            child: FloatingActionButton.extended(
              label: const Text("Język",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      shadows: [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 2),
                            blurRadius: 4)
                      ],
                      fontWeight: FontWeight.bold)),
              tooltip: 'Language',
              heroTag: 'abc',
              onPressed: () {/* Do something */},
              icon: const Icon(
                Icons.abc,
                size: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 60,
            width: 170,
            bottom: 160,
            right: 445,
            child: FloatingActionButton.extended(
              label: const Text("Terminal",
                  style: TextStyle(
                      color: Color.fromARGB(255, 31, 30, 30),
                      fontSize: 15,
                      shadows: [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 2),
                            blurRadius: 4)
                      ],
                      fontWeight: FontWeight.bold)),
              tooltip: 'Terminal',
              heroTag: 'terminal',
              onPressed: () {/* Do something */},
              icon: const Icon(
                Icons.terminal,
                size: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 60,
            width: 170,
            bottom: 90,
            left: 445,
            child: FloatingActionButton.extended(
              label: const Text("Dark Mode",
                  style: TextStyle(
                      color: Color.fromARGB(255, 31, 30, 30),
                      fontSize: 15,
                      shadows: [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 2),
                            blurRadius: 4)
                      ],
                      fontWeight: FontWeight.bold)),
              heroTag: 'darkmode',
              onPressed: () {/* Do something */},
              icon: const Icon(
                Icons.toggle_off,
                size: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 60,
            width: 170,
            bottom: 90,
            right: 445,
            child: FloatingActionButton.extended(
              label: const Text("Sortowanie",
                  style: TextStyle(
                      color: Color.fromARGB(255, 31, 30, 30),
                      fontSize: 15,
                      shadows: [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 2),
                            blurRadius: 4)
                      ],
                      fontWeight: FontWeight.bold)),
              tooltip: 'sort',
              heroTag: 'sort',
              onPressed: () {/* Do something */},
              icon: const Icon(
                Icons.sort,
                size: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 20,
            width: 70,
            bottom: 40,
            left: 490,
            child: FloatingActionButton(
              tooltip: 'exit_to_app',
              heroTag: 'exit_to_app',
              onPressed: () {/* Do something */},
              child: const Icon(
                Icons.exit_to_app,
                size: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 20,
            width: 70,
            bottom: 40,
            right: 490,
            child: FloatingActionButton(
              tooltip: 'Password',
              heroTag: 'key',
              onPressed: () {/* Do something */},
              child: const Icon(
                Icons.key,
                size: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            height: 20,
            width: 70,
            bottom: 40,
            right: 590,
            child: FloatingActionButton(
              tooltip: 'Star',
              heroTag: 'star',
              onPressed: () {/* Do something */},
              child: const Icon(
                Icons.star,
                size: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
