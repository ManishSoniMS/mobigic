import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class that handles the storage of the [SharedPreferences] database.
@singleton
class LocalDatabase {
  LocalDatabase._();

  late SharedPreferences _pref;

  /// initialize LocalDatabase
  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static final LocalDatabase _instance = LocalDatabase._();

  /// Returns the instance of the [LocalDatabase].
  @factoryMethod
  static LocalDatabase getInstance() {
    return _instance;
  }

  /// get authBox
  SharedPreferences get pref => _pref;

  /// close the database
  @disposeMethod
  Future<void> dispose() async {}
}
