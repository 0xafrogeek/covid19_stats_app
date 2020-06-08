import 'package:covid19_gambia/ConnectivityCheck.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_widgets/theme_switch.dart';

class CallCenter extends StatefulWidget {
  @override
  _CallCenterState createState() => _CallCenterState();
}

class _CallCenterState extends State<CallCenter> {
  @override
  void initState() {
    super.initState();
    CheckConnectivity.isConnected().then((isConnected) {
      if (!isConnected) {
        CheckConnectivity.showInternetDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Toll-Free Helplines",
            // remove italic
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          // added call icon
          leading: Icon(
            Icons.call,
            color: Theme.of(context).accentColor,
          ),
          actions: <Widget>[ThemeSwitch()]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance
                .collection('tollFree')
                .orderBy("line")
                .snapshots(), //
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
                );

              return Expanded(
                  child: ListView(
                children: snapshot.data.documents.map((document) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          launchCaller(document['number'].toString());
                        },
                        title: Row(
                          children: <Widget>[
                            Text(
                              document['line'].toString(),
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    OMIcons.call,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    document['number'].toString(),
                                    style: TextStyle(
                                        color: Colors.blueAccent[200]),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  );
                }).toList(),
              ));
            },
          )
        ],
      ),
    );
  }

  launchCaller(String number) async {
    var url = "tel:" + number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
