import 'package:flutter/material.dart';

class BaseBackgroundAddBar extends StatelessWidget {
  const BaseBackgroundAddBar({
    Key? key,
    this.height = 67,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        color: Theme.of(context).cardColor,
        height: height,
      ),
    );
  }
}
