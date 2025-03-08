class ApiConstants {
  static const String baseUrl = 'https://api.stagingcupid.com/api/v1';
  static const String countriesEndpoint = '/countries';
  static const String statesEndpoint = '/countries/{countryId}/states';

  static const Map<String, String> headers = {
    'x-api-key': 'sA,{tzUD=]dHvYNBJ4xVZ3c=&zS%.UqVc{But?kc',
    'User-Agent': 'com.stagingcupid.api/10.16.6 (Release) Android/31',
  };
}

class BackupApiConstants {
  static const String baseUrl = 'https://country-state-city-search-rest-api.p.rapidapi.com';
  static const String allCountriesEndpoint = '/allcountries';
  static const String statesByCountryCodeEndpoint = '/states-by-countrycode';

  static const Map<String, String> headers = {
    'x-rapidapi-host': 'country-state-city-search-rest-api.p.rapidapi.com',
    'x-rapidapi-key': '450072f052msh36feb91b3b6401dp1a0b00jsn0f6325838f0f',
  };
}
