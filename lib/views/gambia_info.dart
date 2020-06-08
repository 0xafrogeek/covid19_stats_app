import 'package:flutter/material.dart';
import 'package:covid19_gambia/controllers/covid_api.dart';
import 'package:covid19_gambia/custom_widgets/statistic_card.dart';
import 'package:covid19_gambia/custom_widgets/theme_switch.dart';
import 'package:covid19_gambia/custom_widgets/virus_loader.dart';
import 'package:covid19_gambia/gambia.dart';
import 'package:covid19_gambia/models/country_model.dart';
import 'package:covid19_gambia/models/gambia_info_model.dart';
import 'package:covid19_gambia/views/country_detail.dart';

class GambiaInfoPage extends StatefulWidget {
  @override
  _GambiaInfoPageState createState() => _GambiaInfoPageState();
}

class _GambiaInfoPageState extends State<GambiaInfoPage> {
  GambiaInfo _stats;
  double deathPercentage;
  double activePercentage;
  bool _isLoading = false;
  CovidApi api = CovidApi();
  double recoveryPercentage;
  Size size;

  HomeCountry _homeCountry;

  @override
  void initState() {
    super.initState();
    _fetchHomeCountry();
    _fetchGambiaInfoStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'COVID-19 Gambia',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        // change from leading .list
        // to png image
        leading: Icon(
          Icons.outlined_flag,
          color: Theme.of(context).accentColor,
        ),
        actions: <Widget>[
          ThemeSwitch(),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? VirusLoader()
            : _stats == null
                ? buildErrorMessage()
                : ListView(
                    children: <Widget>[
                      if (_homeCountry != null)
                        ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.favorite,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          title: Text(_homeCountry.name),
                          subtitle: Text(
                            _homeCountry.cases + '--' + _homeCountry.deaths,
                          ),
                          trailing: Icon(Icons.arrow_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CountryDetailPage(
                                countryName: _homeCountry.name,
                              ),
                            ),
                          ),
                        ),
                      StatisticCard(
                        color: Color(0xFFFFF492),
                        text: 'Total Cases',
                        assetName: 'assets/count.png',
                        stats: _stats.cases,
                      ),

                      StatisticCard(
                        color: Color(0xFFE40000),
                        text: 'Total Deaths',
                        assetName: 'assets/death.png',
                        stats: _stats.deaths,
                      ),

                      StatisticCard(
                        color: Color(0xFF70A901),
                        text: 'Total recovered',
                        assetName: 'assets/patient.png',
                        stats: _stats.recovered,
                      ),
                      
                      StatisticCard(
                        color: Color(0xFF70A901),
                        text: 'Today Cases',
                        assetName: 'assets/count.png',
                        stats: _stats.recovered,
                      ),                                 

                      StatisticCard(
                        color: Color(0xFFEEDA28),
                       text: 'Active',
                        assetName: 'assets/suspect.png',
                       stats: _stats.active,
                     ),

                     StatisticCard(
                        color: Color(0xFFFFF492),
                        text: 'Cases Per One Million',
                        assetName: 'assets/count.png',
                        stats: _stats.casesPerOneMillion  
                      ),

                      StatisticCard(
                        color: Color(0xFFE40000),
                        text: 'Death Per One Million',
                        assetName: 'assets/death.png',
                        stats: _stats.deathsPerOneMillion,
                      ), 

                      StatisticCard(
                        color: Colors.red,
                        text: 'Total Tests',
                        assetName: 'assets/fever.png',
                        stats: _stats.totalTests,
                      ),

                     StatisticCard(
                        color: Color(0xFFE40000),
                        text: 'Tests Per One Million',
                        assetName: 'assets/fever.png',
                        stats: _stats.deathsPerOneMillion,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            //leading: Icon(Icons.pie_chart),
                            leading: Image.asset('assets/death.png'),
                            title: Text('Death Percentage'),
                            trailing: Text(
                              deathPercentage.toStringAsFixed(2) + ' %',
                              style: TextStyle(
                                  color: Color(0xFFE40000),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            leading: Image.asset('assets/patient.png'),
                            title: Text('Recovery Percentage'),
                            trailing: Text(
                              recoveryPercentage.toStringAsFixed(2) + ' %',
                              style: TextStyle(
                                  color: Color(0xFF70A901),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
      ),
    );
  }

  Center buildErrorMessage() {
    return Center(
      child: Text(
        'Unable to get Updates.\nPlease check your internet',
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.grey,
            ),
      ),
    );
  }

  void _fetchGambiaInfoStats() async {
    setState(() => _isLoading = true);
    try {
      var stats = await api.getGambiaInfo();
      deathPercentage = (stats.deaths / stats.cases) * 100;
      recoveryPercentage = (stats.recovered / stats.cases) * 100;
      activePercentage = 100 - (deathPercentage + recoveryPercentage);

      print(deathPercentage);
      print(recoveryPercentage);
      print(activePercentage);
      setState(() => _stats = stats);
    } catch (ex) {
      setState(() => _stats = null);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _fetchHomeCountry() async {
    var list = await mySharedPreferences.fetchHomeCountry();
    if (list != null) {
      setState(() {
        _homeCountry = HomeCountry(
          name: list[0],
          cases: list[1],
          deaths: list[2],
        );
      });
    }
  }
}

