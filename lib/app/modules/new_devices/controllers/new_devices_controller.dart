import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';

class NewDevicesController extends GetxController {
  NewDevicesController({
    required this.bluetoothController,
  });

  final BluetoothController bluetoothController;
}
