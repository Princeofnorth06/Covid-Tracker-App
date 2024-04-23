import 'dart:convert';

import 'package:covid_tracker/Model/Services/utilities/app_url.dart';

import 'package:covid_tracker/Model/Services/utilities/world_states_model.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListAPi() async {
    var data;

    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Failed to load countries: ${response.statusCode}');
    }
  }
}
