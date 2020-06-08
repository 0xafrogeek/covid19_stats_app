//import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19_gambia/gambia.dart';
import 'package:covid19_gambia/views/home_master.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.blue[700],
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.blueGrey[700],
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.green,
  accentIconTheme: IconThemeData(color: Colors.blueGrey[700]),
  dividerColor: Colors.white54,
);

 

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;

    notifyListeners();
  }
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isDarkTheme = prefs.getBool(SharedPreferencesKeys.isDarkTheme);
  ThemeData theme;
  if(isDarkTheme != null) {
    theme = isDarkTheme ? darkTheme : lightTheme;
  } else {
    theme = lightTheme;
  }
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(theme),
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Gambia',
      theme: themeNotifier.getTheme(),
      home:  new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: HomePageMaster(),
      title: new Text('COVID-19 Gambia',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.green[100]
        ),
      ),
      image: new Image.asset('assets/icon/gambia2.ico'),
      backgroundColor: Colors.blue,
      photoSize: 200,
      ),
    );
  }
}
