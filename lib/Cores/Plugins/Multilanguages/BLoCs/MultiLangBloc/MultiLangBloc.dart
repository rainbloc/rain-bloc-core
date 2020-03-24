import 'dart:async';

import '../../../../../BLoCs/Bloc.dart';
import '../../SP/SPLang.dart';

class MultiLangBloc extends BlocMaster {
  final defaultLang = "en";
  final _cacheSPlang = SPLang();

  final _langController = StreamController<Map<dynamic, dynamic>>();
  Stream<Map<dynamic, dynamic>> get stream => _langController.stream;

  MultiLangBloc() {
    firstLoad();
  }

  void firstLoad() async {
    final cache = await _cacheSPlang.getLangCache();
    print("firstLoad $cache");
    if (cache["error"] != null) {
      await _cacheSPlang.setLangCache({"lang": defaultLang});
    }
  }

  void getLang() async {
    // Get From REST API
    Map results;
    results = await _cacheSPlang.getLangCache();
    print("json Value results $results");

    _langController.sink.add(results);
  }

  void setLangCache(String langKey) async {
    await _cacheSPlang.setLangCache({"lang": langKey});
    getLang();
  }

  @override
  void dispose() {
    _langController.close();
  }
}
