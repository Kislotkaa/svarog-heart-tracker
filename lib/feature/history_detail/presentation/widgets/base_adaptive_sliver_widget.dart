import 'package:flutter/material.dart';

class BaseAdaptiveSliverWidget extends StatelessWidget {
  const BaseAdaptiveSliverWidget(this.child, {super.key, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );

    return SliverPrototypeExtentList(
      delegate: SliverChildListDelegate(
        [content],
      ),
      prototypeItem: content,
    );
  }
}
