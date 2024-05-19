import 'package:flutter/material.dart';

class BaseDividerWidget extends StatelessWidget {
  const BaseDividerWidget({
    Key? key,
    this.padding,
    this.color,
  }) : super(key: key);

  final EdgeInsets? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Divider(
        height: 1,
        color: color,
      ),
    );
  }
}
