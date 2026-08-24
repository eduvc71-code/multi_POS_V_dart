import 'package:flutter/material.dart';

class GlobalMaterialLocalizations {
  static const delegate = _MockDelegate();
}

class GlobalWidgetsLocalizations {
  static const delegate = _MockDelegate();
}

class GlobalCupertinoLocalizations {
  static const delegate = _MockDelegate();
}

class _MockDelegate extends LocalizationsDelegate<dynamic> {
  const _MockDelegate();
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<dynamic> load(Locale locale) async => Object();
  @override
  bool shouldReload(_MockDelegate old) => false;
}
