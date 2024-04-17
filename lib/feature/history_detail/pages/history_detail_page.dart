import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HistoryDetailPage extends StatelessWidget {
  const HistoryDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('История детальная'),
      ),
    );
  }
}
