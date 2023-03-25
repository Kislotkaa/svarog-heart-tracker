import 'package:flutter/material.dart';

class BaseTitle extends StatelessWidget {
  final String? title;
  final TextStyle? style;
  final int? maxLinesTitle;

  const BaseTitle({
    Key? key,
    required this.title,
    this.style,
    this.maxLinesTitle = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: style ?? Theme.of(context).textTheme.headline3,
          maxLines: maxLinesTitle,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
