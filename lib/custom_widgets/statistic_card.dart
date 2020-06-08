
import 'package:flutter/material.dart';
import '../gambia.dart';

class StatisticCard extends StatelessWidget {
  final String text;
  //final String assetName;
  final int stats;
  final String assetName;
  final Color color;
  final IconData icon;

  StatisticCard({
    @required this.text,
    @required this.color,
    //@required this.assetName,
    @required this.assetName,
    this.icon,
    @required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      stats.toString().replaceAllMapped(reg, mathFunc),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      text,

                      style: Theme.of(context).textTheme.headline6.copyWith(color: color),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(assetName, color: color,)
                  //Icon(
                    //icon,
                    //size: 50.0,
                    //color: color,
                  //)
                  )
            ],
          ),
        ),
      ),
    );
  }
}

