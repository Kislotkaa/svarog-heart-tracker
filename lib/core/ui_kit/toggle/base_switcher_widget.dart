import 'package:flutter/cupertino.dart';

class BaseSwitcherWidget extends StatefulWidget {
  const BaseSwitcherWidget({super.key, required this.callBack, this.initValue});

  final bool? initValue;

  final Function(bool flag) callBack;

  @override
  State<BaseSwitcherWidget> createState() => _BaseSwitcherWidgetState();
}

class _BaseSwitcherWidgetState extends State<BaseSwitcherWidget> {
  late bool flag = false;

  @override
  void initState() {
    flag = widget.initValue ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: flag,
      onChanged: (_) {
        switchFlag();
      },
    );
  }

  void switchFlag() {
    setState(() {
      flag = !flag;
      widget.callBack.call(flag);
    });
  }
}
