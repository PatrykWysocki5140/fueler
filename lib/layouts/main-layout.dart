import 'package:flutter/material.dart';
import 'package:fueler/pages/settings_page.dart';
import 'package:fueler/pages/welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/widgets/basic_widgets.dart';
import 'package:fueler/widgets/loading_screen.dart';

class MainLayout extends StatefulWidget {
  //const MainLayout({Key? key}) : super(key: key);
  //final int recordName;
  //final String recordName;
  //const MainLayout(this.recordName);

  //const MainLayout({Key? key, required this.recordName}): super(key: key); //to było ok
  //const MyRecord(this.recordName);

  final int page;

  // ignore: use_key_in_widget_constructors
  const MainLayout({required this.page});

  @override
  // ignore: no_logic_in_create_state
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
        //backgroundColor: Colors.black12,
        title: const Text(""),
        leading: GestureDetector(
            onTap: () {},
            child: IconButton(
              onPressed: () {
                setState(() {
                  _myPage.jumpToPage(1);
                });
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
                      setState(() {
                        _myPage.jumpToPage(4);
                      });
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
                  setState(() {
                    _myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                icon: const Icon(Icons.navigation),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(2);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                icon: const Icon(Icons.settings),
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
          // ignore: avoid_print
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
