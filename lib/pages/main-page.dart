import 'package:flutter/material.dart';
import 'package:fueler/widgets/theme_mode.dart';

import '../widgets/language-switcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  PageController _myPage = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(""),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(Icons.search),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.refresh),
              )),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                icon: Icon(Icons.person),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(0);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                icon: Icon(Icons.navigation),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                icon: Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(2);
                  });
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
          Center(
            child: Container(
              child: Text('Empty Body 0test'),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 1test'),
            ),
          ),
          Center(
            child: Container(
              child: Settings(),
            ),
          ),
        ],
        physics:
            NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
    );
  }
}