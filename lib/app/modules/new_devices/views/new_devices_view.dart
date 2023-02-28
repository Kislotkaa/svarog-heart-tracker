import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_devices_controller.dart';

Future<void> showNewDevices(
  String? userId,
) async {
  await showModalBottomSheet(
    barrierColor: Colors.black.withOpacity(0.1),
    backgroundColor: Colors.black.withOpacity(0),
    isScrollControlled: true,
    context: Get.context!,
    builder: (context) => GetBuilder(
      init: NewDevicesController(
        bluetoothController: Get.find(),
      ),
      builder: (dynamic _) => const NewDevicesView(),
    ),
  );
}

class NewDevicesView extends GetView<NewDevicesController> {
  const NewDevicesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewDevicesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewDevicesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
