import 'dart:async';

import 'package:rainbloc/BLoCs/Bloc.dart';
import 'package:rainbloc/DataSources/REST/Newsapi.org/DSRestNewsApi.dart';
import 'package:rainbloc/DataSources/SharedPref/SPNews.dart';

class NewsBloc extends BlocMaster {
  final _restNewsClient = DSRestNewsApi();
  final _cacheSPNews = SPNews();

  final _newsController = StreamController<Map<dynamic, dynamic>>();
  Stream<Map<dynamic, dynamic>> get stream => _newsController.stream;

  void getNews() async {
    
    // Get From REST API
    Map results;
    final cache = await _cacheSPNews.getNewsCache();

    if (cache["error"] != null) {
      results = await _restNewsClient.getNews();
      _cacheSPNews.setNewsCache(results);

    } else {
      results = cache;
    }
    _newsController.sink.add(results);
  }

  @override
  void dispose() {
    _newsController.close();
  }
}
