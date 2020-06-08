import 'package:covid19_gambia/questions.dart';
import 'package:flutter/material.dart';
import '../call_center.dart';
import 'country_list.dart';
import 'gambia_info.dart';

class HomePageMaster extends StatefulWidget {
  @override
  _HomePageMasterState createState() => _HomePageMasterState();

}

class _HomePageMasterState extends State<HomePageMaster> {
  int _currentIndex = 0;

  List<Widget> _widgets = <Widget> [
    GambiaInfoPage(),
    CountryListPage(),
    FAQPage(),
    CallCenter(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // have bottom navbar still display image
        // after adding our fourth icon
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            title: Text('Gambia')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.public),
              title: Text('Global'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text('Coronavirus')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.call),
              title: Text('Call 1025'),
              //ontap: () {
                //          print('button 1 tapped');
                  //        Navigator.push(
                    //          context,
                      //        PageTransition(
                        //          type: PageTransitionType.rightToLeft,
                          //        child: CallCenter()));
          ),
        ],
      ),
      body: _widgets.elementAt(_currentIndex),
    );
  }
}

