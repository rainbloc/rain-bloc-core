import 'dart:async';

import 'package:rain_bloc/BLoCs/Bloc.dart';
import 'package:rain_bloc/DataSources/REST/Newsapi.org/DSRestNewsApi.dart';
import 'package:rain_bloc/DataSources/SharedPref/SPNews.dart';

class NewsBloc extends BlocMaster {
  final _restNewsClient = DSRestNewsApi();
  final _cacheSPNews = SPNews();

  final _newsController = StreamController<Map<dynamic, dynamic>>();
  Stream<Map<dynamic, dynamic>> get stream => _newsController.stream;

  void getNews() async {
    
    // Get From REST API
    Map results;
    final cache = await _cacheSPNews.getNewsCache();
     print("CACHE 1 : ${cache["created_time"]}");
    if (cache["error"] != null) {
      results = await _restNewsClient.getNews();
      _cacheSPNews.setNewsCache(results);

    } else {
      results = cache;
    }
    print("CACHE ${results["created_time"]}");
    _newsController.sink.add(results);
  }

  @override
  void dispose() {
    _newsController.close();
  }
}
