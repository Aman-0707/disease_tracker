import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/c19model.dart';

class Service {
  Future<Covid> fetch() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Covid.fromJson(data as Map<String, dynamic>);
    } else {
      throw Exception('errr');
    }
  }

  Future<List<dynamic>> country() async {
    var data;
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('errr');
    }
  }
}
