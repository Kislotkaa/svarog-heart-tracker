import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HowToUsePage extends StatelessWidget {
  const HowToUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Как пользоваться'),
      ),
    );
  }
}
