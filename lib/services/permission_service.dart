import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestCorePermissions() async {
    final camera = await Permission.camera.request();
    final notification = await Permission.notification.request();
    
    PermissionStatus systemAlertWindow = PermissionStatus.granted;
    if (Platform.isAndroid) {
      systemAlertWindow = await Permission.systemAlertWindow.request();
    }

    return camera.isGranted && notification.isGranted && systemAlertWindow.isGranted;
  }
}
