import 'package:flutter/material.dart';

class BaseDivider extends StatelessWidget {
  const BaseDivider({
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
