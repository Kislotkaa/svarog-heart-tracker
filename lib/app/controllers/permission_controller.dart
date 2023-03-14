import 'dart:async';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  Future<void> getPermission() async {
    await Permission.bluetooth.request();
    await Permission.location.request();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getPermission();
  }
}
