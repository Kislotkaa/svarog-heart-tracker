import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

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
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
      },
    );
  }
}
