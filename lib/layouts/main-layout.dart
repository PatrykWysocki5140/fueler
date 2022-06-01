import 'package:flutter/material.dart';
import 'package:fueler/pages/settings_page.dart';
import 'package:fueler/pages/welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/widgets/loading_screen.dart';

class MainLayout extends StatelessWidget {
  late final PageController _myPage;

  MainLayout({Key? key, required int page}) : super(key: key) {
    _myPage = PageController(initialPage: page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text(""),
        leading: GestureDetector(
            onTap: () {},
            child: IconButton(
              onPressed: () {
                _myPage.jumpToPage(1);
              },
              icon: const Icon(Icons.search),
            )),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {},
                  child: IconButton(
                    onPressed: () {
                      _myPage.jumpToPage(4);
                    },
                    icon: const Icon(Icons.refresh),
                  ))),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                icon: const Icon(Icons.person),
                onPressed: () {
                  _myPage.jumpToPage(1);
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                icon: const Icon(Icons.navigation),
                onPressed: () {
                  _myPage.jumpToPage(2);
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                icon: const Icon(Icons.settings),
                onPressed: () {
                  _myPage.jumpToPage(3);
                },
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _myPage,
        onPageChanged: (int) {
          print('Page Changes to index $int');
        },
        children: <Widget>[
          const Welcome(),
          Center(
            child: Container(
              child: Text(
                  AppLocalizations.of(context)!.buttonClicksDescriptionLogin),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 2test'),
            ),
          ),
          const Settings(),
          const LoadingScreen(),
        ],
        physics:
            const NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
    );
  }
}
