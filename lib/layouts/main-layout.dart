import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fueler/pages/search_page.dart';
import 'package:fueler/pages/settings_page.dart';
import 'package:fueler/pages/user_less_page.dart';
import 'package:fueler/pages/welcome_page.dart';
import 'package:fueler/widgets/loading_screen.dart';

import '../pages/map-page.dart';

class MainLayout extends StatelessWidget {
  late final PageController _myPage;

  MainLayout({Key? key, required int page}) : super(key: key) {
    _myPage = PageController(initialPage: page);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _myPage.jumpToPage(0);
        return Future.value(false);
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          title: const Text(""),
          leading: GestureDetector(
              onTap: () {},
              child: IconButton(
                onPressed: () {
                  _myPage.jumpToPage(4);
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
                        _myPage.jumpToPage(3);
                      },
                      icon: const Icon(Icons.refresh),
                    ))),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
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
                    _myPage.jumpToPage(5);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    _myPage.jumpToPage(2);
                  },
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _myPage,
          onPageChanged: (pageID) {
            if (kDebugMode) {
              print('Page Changes to index $pageID');
            }
          },
          children: <Widget>[
            const Welcome(),
            UserLess(),
            const Settings(),
            LoadingScreen(onCompletion: () => _myPage.jumpToPage(0)),
            const Search(),
            MapPage(),
          ],
          physics:
              const NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
        ),
      ),
    );
  }
}
