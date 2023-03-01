import 'package:flutter/material.dart';

class BaseHandle extends StatelessWidget {
  const BaseHandle({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 8),
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
