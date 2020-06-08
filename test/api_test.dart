import 'package:flutter_test/flutter_test.dart';
import 'package:covid19_gambia/controllers/covid_api.dart';
import 'package:covid19_gambia/models/gambia_info_model.dart';

void main() {
  test('Get gambia info', () async {
    CovidApi api = CovidApi();
    GambiaInfo info = await api.getGambiaInfo();
    print(info.cases);
  });

  test('Get all countries info', () async {
    CovidApi api = CovidApi();
    var list = await api.getAllCountriesInfo();
    print(list.first.country);
  });

  test('Get country by name', () async {
    CovidApi api = CovidApi();
    var country = await api.getCountryByName('Gambia');
    print(country.country);
  });
}
