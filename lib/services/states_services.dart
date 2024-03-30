import 'dart:convert';

import 'package:covid_tracker/model/WorldStateModel.dart';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStateModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('error message');
    }
  }

  Future<List<dynamic>> fetchCountryWiseRecord() async {
    final response = await http.get(Uri.parse(AppUrl.countriesName));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error message');
    }
  }
}
