import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

class BaseVersion extends StatelessWidget {
  const BaseVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null) return const SizedBox();

        var text = 'v.${data.version} +${data.buildNumber}';

        return Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: appTheme.textTheme.smallCaptionSemibold12,
          ),
        );
      },
    );
  }
}
