import 'dart:convert';
import './SharedPrefStorageMaster.dart';

class SPLang extends SharedPrefStorageMaster {
  String prefix = 'lang';
  String _errorResult = '{"error":1}';
  int _expiredTime = 150000; // 5 seconds

  @override
  Map<String, String> sharedKey = {
    "lang_cache": "lang_cache",
  };

  Future<bool> setLangCache(Map<dynamic, dynamic> jsonMap) async {
    jsonMap["created_time"] = new DateTime.now().millisecondsSinceEpoch;
    var jsonValue = jsonEncode(jsonMap);
    await this.setData(key: "lang_cache", value: jsonValue);
    return true;
  }

  Future<Map> getLangCache() async {
    String gData = await this.getData("lang_cache") ?? _errorResult;

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
