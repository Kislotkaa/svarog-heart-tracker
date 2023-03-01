import 'package:flutter/material.dart';

import '../resourse/app_colors.dart';

class BaseTextLink extends StatelessWidget {
  const BaseTextLink(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        children: [
          Container(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppColors.linkColorConst,
                  ),
            ),
          ),
          Container(
            height: 1,
            color: AppColors.linkColorConst,
          )
        ],
      ),
    );
  }
}
