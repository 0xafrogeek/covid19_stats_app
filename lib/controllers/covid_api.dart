import 'dart:convert';
import 'package:covid19_gambia/models/country_model.dart';
import 'package:covid19_gambia/models/gambia_info_model.dart';
import '../gambia.dart';

class CovidApi {
  Future<GambiaInfo> getGambiaInfo() async {
    String response = await netWorkCalls.get(UrlConstants.gambiaInfo);
    return GambiaInfo.fromJson(jsonDecode(response));
  }

  Future<List<Country>> getAllCountriesInfo() async {
    var response = await netWorkCalls.get(UrlConstants.allCountries);
    var list = jsonDecode(response) as List;
    return list.map((item) => Country.fromJson(item)).toList();
  }

  Future<Country> getCountryByName(String country) async {
    var response =
        await netWorkCalls.get('${UrlConstants.allCountries}/$country');
    return Country.fromJson(jsonDecode(response));
  }
}
