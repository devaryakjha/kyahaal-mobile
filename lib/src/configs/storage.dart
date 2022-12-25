part of 'config.dart';

class AppStorage {
  AppStorage._();
  static AppStorage instance = AppStorage._();
  String boxName = 'kyahaal_preferences';

  Box get preferenceBox => Hive.box(boxName);

  init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  void addString(String key, String value) async {
    await preferenceBox.put(key, value);
  }

  String? getString(String key, {String? defaultValue}) {
    return preferenceBox.get(key, defaultValue: defaultValue);
  }
}
