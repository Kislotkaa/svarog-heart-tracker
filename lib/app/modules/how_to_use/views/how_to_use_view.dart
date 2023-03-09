import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/how_to_use_controller.dart';

class HowToUseView extends GetView<HowToUseController> {
  const HowToUseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HowToUseView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HowToUseView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
