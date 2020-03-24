import 'package:flutter/material.dart';
import './langs.dart';
import './SP/SPLang.dart';

class MultiLangs {
  String _defaultLang = "en";
  final _cacheSPlang = SPLang();

  String get defaultLang {
    return _defaultLang;
  }

  void set defaultLang(String text) {
    _defaultLang = text;
  }

  // MultiLangs({String defaultLang = "en"})
  String getLang(
      {@required String key, @required String defaultText, String lang}) {
    print("lg default_lang : $_defaultLang");

    if (lang == null) lang = this._defaultLang;
    if (langs[lang] == null) return defaultText;

    dynamic lg = langs[lang][key];

    if (lg == null) {
      return defaultText;
    }
    return lg;
  }

  void setLang(String langKey) async {
    await _cacheSPlang.setLangCache({"lang": langKey});
    _defaultLang = langKey;
  }
}
