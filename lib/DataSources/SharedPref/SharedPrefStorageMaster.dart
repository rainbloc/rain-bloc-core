import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorageMaster {
  SharedPreferences _prefs;
  SharedPreferences storage;
  String prefix = 'default';
  Map<String, String> sharedKey = {'value':'value'};

  SharedPrefStorageMaster() {
    _firstLoad();
  }

  _firstLoad() async {
    _prefs = await SharedPreferences.getInstance();
    storage = _prefs;
    _prefs.setString("test", "hello");
    print("_prefs");
    print("$_prefs");
  }

  load() async {
    if (_prefs == null || storage == null) {
      await _firstLoad();
    }
  }

  Future<bool> setData({@required String key, @required String value}) async {
    if (sharedKey[key] == null) {
      return false;
    }
    await this.load();

    this.storage.setString('${prefix + key}', value);

    return true;
  }

  getData(String key) async {
    await this.load();
    return this.storage.getString('${prefix + key}');
  }
}
