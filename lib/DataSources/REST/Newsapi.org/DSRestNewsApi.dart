import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert' show json;

import 'package:rainbloc/DataSources/RestaurantDSModel.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class DSRestNewsApi {
  static String get _apiKey => '501832d39f5b4ebea0f6e380d7d23e20';
  final _host = 'newsapi.org';
  final _contextRoot = 'v2';

  Future<Map> getNews() async {
    final path    = '/top-headlines';
    final Map<String, String> 
          _params = {'apiKey': _apiKey, 'country': 'id'};
    final uri     = Uri.http(_host, '${_contextRoot + path}', _params);
    final results = await http.get(uri, headers: _headers);
    final jsonRes = json.decode(results.body);

    return jsonRes;
  }

  Map<String, String> get _headers => {'Accept': 'application/json'};
}
