import 'package:isar/isar.dart';

part 'alarm_settings.g.dart';

@collection
class AlarmSettings {
  Id id = Isar.autoIncrement;

  DateTime? orario;
  String? secretQrCodeString;
  String? audioUri;
}
