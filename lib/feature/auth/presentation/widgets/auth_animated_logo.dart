import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/common/assets.gen.dart';
import 'package:svarog_heart_tracker/core/constant/duration.dart';

class AuthAnimatedLogo extends StatefulWidget {
  const AuthAnimatedLogo({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  State<AuthAnimatedLogo> createState() => _AuthAnimatedLogoState();
}

class _AuthAnimatedLogoState extends State<AuthAnimatedLogo> {
  bool hasFocus = false;

  @override
  void initState() {
    widget.focusNode.addListener(() {
      setState(() {
        hasFocus = widget.focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: hasFocus ? 0 : 210,
      duration: AppDuration.medium,
      child: AnimatedOpacity(
        duration: AppDuration.fast,
        opacity: hasFocus ? 0 : 1,
        child: IgnorePointer(
          child: Hero(
            tag: 'appIcon.svg',
            child: Assets.icons.appIcon.svg(
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
