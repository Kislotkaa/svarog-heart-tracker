import 'package:flutter/material.dart';

Future<void> baseDialog({
  required BuildContext context,
  required Widget child,
  RouteSettings? routeSettings,
}) async {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    routeSettings: routeSettings,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return child;
    },
  );
}
