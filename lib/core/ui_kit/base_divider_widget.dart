import 'package:flutter/material.dart';

class BaseDividerWidget extends StatelessWidget {
  const BaseDividerWidget({
    Key? key,
    this.padding,
  }) : super(key: key);

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: const Divider(
        height: 1,
      ),
    );
  }
}
