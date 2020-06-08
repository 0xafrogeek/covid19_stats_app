class GambiaInfo {
  int cases;
  int deaths;
  int recovered;
  int todayCases;
  int active;
  int casesPerOneMillion;
  int deathsPerOneMillion;
  int totalTests;
  int testsPerOneMillion;

  GambiaInfo(
      {this.cases,
      this.deaths,
      this.recovered,
      this.todayCases,
      this.active,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.totalTests,
      this.testsPerOneMillion});

  GambiaInfo.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    todayCases = json['todayCases'];
    active = json['active'];
    casesPerOneMillion = json['casesPerOneMillion'];
    deathsPerOneMillion = json['deathsPerOneMillion'];
    totalTests = json['totalTests'];
    testsPerOneMillion = json['testsPerOneMillion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cases'] = this.cases;  
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    data['todayCases'] = this.todayCases; 
    data['active'] = this.active;
    data['casesPerOneMillion'] = this.casesPerOneMillion;
    data['deathsPerOneMillion'] = this.deathsPerOneMillion;
    data['totalTests'] = this.totalTests;
    data['testsPerOneMillion'] = this.testsPerOneMillion;
    return data;
  }
}
