import 'dart:async';

import 'package:hello_bloc/BLoCs/Bloc.dart';
import 'package:hello_bloc/DataSources/REST/Newsapi.org/DSRestNewsApi.dart';

class NewsBloc extends BlocMaster{


  final _newsClient = DSRestNewsApi();

  final _newsController = StreamController<Map<dynamic, dynamic>>();
  Stream<Map<dynamic, dynamic>> get stream => _newsController.stream;

  void getNews() async {
    final results = await _newsClient.getNews();
    _newsController.sink.add(results);
  }

  @override
  void dispose() {
    _newsController.close();
  }
}