import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_app_bar_widget.dart';

@RoutePage()
class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBarWidget(title: 'Unknown'),
      body: Center(
        child: Text('Неизвестный роут!'),
      ),
    );
  }
}
