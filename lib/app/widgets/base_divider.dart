import 'package:flutter/material.dart';

class BaseDivider extends StatelessWidget {
  const BaseDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
    );
  }
}
