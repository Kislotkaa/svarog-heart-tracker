import 'package:flutter/material.dart';

import '../resourse/app_colors.dart';
import '../resourse/app_const.dart';

class BaseCardPeople extends StatelessWidget {
  const BaseCardPeople({
    super.key,
    required this.name,
    required this.heartRate,
  });

  final String name;
  final int heartRate;

  @override
  Widget build(BuildContext context) {
    Widget iconHeart = SizedBox();
    if (heartRate < 145) {
      iconHeart = const Icon(
        Icons.favorite,
        color: AppColors.greenConst,
        size: 62,
      );
    } else if (heartRate < 160) {
      iconHeart = const Icon(
        Icons.favorite,
        color: AppColors.orangeConst,
        size: 62,
      );
    } else {
      iconHeart = const Icon(
        Icons.favorite,
        color: AppColors.redConst,
        size: 62,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).canvasColor,
        ),
      ),
      padding: const EdgeInsets.all(AppConst.paddingAll),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.headline5,
          ),
          iconHeart,
          RichText(
            text: TextSpan(
              text: heartRate.toString(),
              style: Theme.of(context).textTheme.headline3,
              children: <TextSpan>[
                TextSpan(
                  text: ' уд/м',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BaseCapCardPeople extends StatelessWidget {
  const BaseCapCardPeople({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Theme.of(context).canvasColor,
          ),
        ),
        padding: const EdgeInsets.all(AppConst.paddingAll),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Добавить',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 4),
            const Icon(
              Icons.add,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
