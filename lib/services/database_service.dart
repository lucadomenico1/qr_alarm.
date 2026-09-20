import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/alarm_settings.dart';

class DatabaseService {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [AlarmSettingsSchema],
      directory: dir.path,
    );
  }

  static Future<void> saveSecretQrCode(String code) async {
    final settings = await isar.alarmSettings.where().findFirst() ?? AlarmSettings();
    settings.secretQrCodeString = code;
    await isar.writeTxn(() async {
      await isar.alarmSettings.put(settings);
    });
  }

  static Future<AlarmSettings?> getSettings() async {
    return await isar.alarmSettings.where().findFirst();
  }

  static Future<void> saveTime(DateTime time) async {
    final settings = await getSettings() ?? AlarmSettings();
    settings.orario = time;
    await isar.writeTxn(() async {
      await isar.alarmSettings.put(settings);
    });
  }

  static Future<void> saveAudioUri(String audioUri) async {
    final settings = await getSettings() ?? AlarmSettings();
    settings.audioUri = audioUri;
    await isar.writeTxn(() async {
      await isar.alarmSettings.put(settings);
    });
  }
}
