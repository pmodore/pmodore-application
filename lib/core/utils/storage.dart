import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FStorage {
  static const notificationKey = "_notification_";
  static const soundKey = "_sound_";
  static const vibrationKey = "_vibration_";
  static const appUpdateKey = "_update_";
  static const newTipKey = "_tip_";
  static const showAdsKey = "_ads_";
  static const initialized = "_init_";

  static late FlutterSecureStorage flutterSecureStorage;

  static initialize() async {
    flutterSecureStorage = const FlutterSecureStorage();

    String? init = await read(initialized);
    if (init != "1") {
      write(initialized, "1");
      write(notificationKey, "1");
      write(soundKey, "1");
      write(vibrationKey, "1");
      write(appUpdateKey, "1");
      write(newTipKey, "1");
      write(showAdsKey, "0");
    }
  }

  static write(String key, dynamic value) async =>
      await flutterSecureStorage.write(key: key, value: value);

  static delete(String key) async =>
      await flutterSecureStorage.delete(key: key);

  static Future<String?> read(String key) async =>
      await flutterSecureStorage.read(key: key);
}
