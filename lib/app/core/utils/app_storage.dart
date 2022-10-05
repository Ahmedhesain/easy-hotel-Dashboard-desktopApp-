// ignore_for_file: constant_identifier_names

import 'package:get_storage/get_storage.dart';

abstract class AppStorage {
  static final _getStorage = GetStorage();

  //region Keys

  static const USER = 'USER';
  static const IS_LOGGED_IN = "IS_LOGGED_IN";


  static T? read<T>(String key) => _getStorage.read<T>(key);

  static Future write<T>(String key, T value) => _getStorage.write(key, value);

  static Future remove(String key) => GetStorage().remove(key);

  static Future removeAll() => GetStorage().erase();


}
