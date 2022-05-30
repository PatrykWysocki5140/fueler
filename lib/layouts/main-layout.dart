import 'package:flutter/material.dart';
import 'package:fueler/pages/settings_page.dart';
import 'package:fueler/pages/welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/language-switcher.dart';

class MainLayout extends StatefulWidget {
  //const MainLayout({Key? key}) : super(key: key);
  //final int recordName;
  //final String recordName;
  //const MainLayout(this.recordName);

  //const MainLayout({Key? key, required this.recordName}): super(key: key); //to było ok
  //const MyRecord(this.recordName);

  final int page;

  MainLayout({required this.page});

  @override
  _MainLayout createState() => _MainLayout(page);
}

class _MainLayout extends State<MainLayout> {
  final int page;
  _MainLayout(this.page);

  final PageController _myPage = PageController(initialPage: 0); // to było ok

  // _MainLayout(${1|int,num,Object,Comparable<num>|} ${2|recordName,name,i|});

  //_MainLayout(${1|int,num,Object,Comparable<num>|} ${2|recordName,name,i|});
  //PageController(initialPage: this.recordName);
  @override
  Widget build(BuildContext context) {
    //var myPage = widget.recordName;
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
                    _myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                icon: Icon(Icons.navigation),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(2);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                icon: Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(3);
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
          Welcome(),
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
