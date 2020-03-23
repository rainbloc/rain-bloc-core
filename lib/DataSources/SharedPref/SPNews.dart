import 'dart:convert';
import './SharedPrefStorageMaster.dart';

class SPNews extends SharedPrefStorageMaster {
  String prefix = 'news';
  String _errorResult = '{"error":1}';
  int _expiredTime = 150000; // 5 seconds

  @override
  Map<String, String> sharedKey = {
    "news_cache": "news_cache",
  };

  void setNewsCache(Map<dynamic, dynamic> jsonMap) async {
    // print("JSON ENcode");
    jsonMap["created_time"] = new DateTime.now().millisecondsSinceEpoch;
    print("JSON ENcode $jsonMap");

    var jsonValue = jsonEncode(jsonMap);
    this.setData(key: "news_cache", value: jsonValue);
  }

  Future<Map> getNewsCache() async {
    String gData = await this.getData("news_cache") ?? _errorResult;

    Map<dynamic, dynamic> map = await jsonDecode(gData);

    if (map["created_time"] != null) {
      int curTime = new DateTime.now().millisecondsSinceEpoch;
      double cachedTimeDif = (curTime - map["created_time"]) / 1;
      if (cachedTimeDif > _expiredTime) {
        Map n = jsonDecode(_errorResult);
        n["expired"] = true;
        print("cachedTime expired ${ map["created_time"]} | $curTime | $cachedTimeDif");

        return n;
      }
    }

    print("get from cache ${map["created_time"]}");
    return map;
  }
}
