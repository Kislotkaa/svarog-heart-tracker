import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseToggle extends StatefulWidget {
  BaseToggle({
    Key? key,
    this.height = 56,
    this.spacingSliders = 8,
    this.sliderStyle,
    this.containerStyle,
    required this.isActive,
    required this.sliders,
    this.callBack,
    this.slidersCallBack,
  }) : super(key: key);

  final double height;
  final double spacingSliders;

  late int isActive;
  final List<String> sliders;
  final ToggleSliderStyle? sliderStyle;
  final ToggleContainerStyle? containerStyle;

  final Function(int i)? callBack;
  final List<Function(int i)?>? slidersCallBack;

  @override
  State<BaseToggle> createState() => _BaseToggleState();
}

class _BaseToggleState extends State<BaseToggle> {
  late ToggleSliderStyle _sliderStyle;
  late ToggleContainerStyle _containerStyle;

  late String error = '';

  @override
  void initState() {
    _initStyle();
    _checkValid();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BaseToggle oldWidget) {
    _initStyle();
    _checkValid();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> underSliders = _getUnderToggle();

    return Container(
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      padding: _containerStyle.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          _containerStyle.borderRadius,
        ),
        color: _containerStyle.backgroundColor,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var elementWidth = constraints.maxWidth / widget.sliders.length;
          var elementPosition = elementWidth * widget.isActive;
          return Stack(
            children: [
              AnimatedPositioned(
                top: 0,
                bottom: 0,
                left: elementPosition,
                width: elementWidth,
                duration: _sliderStyle.animatedDuration,
                curve: Curves.easeIn,
                child: AnimatedContainer(
                  duration: _sliderStyle.animatedDuration,
                  margin: EdgeInsets.only(
                    right: widget.isActive != widget.sliders.length - 1 ? widget.spacingSliders : 0,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_sliderStyle.borderRadius),
                    color: _sliderStyle.backgroundColor,
                    boxShadow: _sliderStyle.shadow,
                  ),
                ),
              ),
              Row(children: underSliders),
            ],
          );
        },
      ),
    );
  }

  void _setActive(int i) {
    if (widget.slidersCallBack != null) {
      widget.slidersCallBack![i]!(i);
    }
    widget.callBack != null ? widget.callBack!(i) : null;
    setState(() {
      widget.isActive = i;
    });
  }

  List<Widget> _getUnderToggle() {
    List<Widget> textToggle = [];
    for (var i = 0; i < widget.sliders.length; i++) {
      textToggle.add(
        Expanded(
          child: GestureDetector(
            onTap: () => _setActive(i),
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                right: i != widget.sliders.length - 1 ? widget.spacingSliders : 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_sliderStyle.borderRadius),
                color: Colors.transparent,
              ),
              child: Text(
                widget.sliders[i],
                style: _getTextStyleActive(i, widget.isActive),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );
    }
    return textToggle;
  }

  TextStyle? _getTextStyleActive(int i, int isActive) {
    if (i == isActive) {
      return _sliderStyle.textStyleActive;
    } else {
      return _sliderStyle.textStyleInActive;
    }
  }

  void _initStyle() {
    if (widget.sliderStyle != null) {
      _sliderStyle = widget.sliderStyle!;
    } else {
      _sliderStyle = ToggleSliderStyle();
    }
    if (widget.containerStyle != null) {
      _containerStyle = widget.containerStyle!;
    } else {
      _containerStyle = ToggleContainerStyle();
    }
  }

  void _checkValid() {
    error = '';

    if (widget.slidersCallBack != null) {
      if (widget.sliders.length != widget.slidersCallBack!.length) {
        error = 'Размер списка slidersCallBack не соответсвует sliders';
      }
    }
  }
}

class ToggleSliderStyle {
  ToggleSliderStyle({
    this.borderRadius = 4,
    this.backgroundColor = Colors.white,
    this.textStyleActive = const TextStyle(color: Colors.blue),
    this.textStyleInActive = const TextStyle(),
    this.animatedDuration = const Duration(milliseconds: 150),
    this.shadow = const [
      BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 8,
        spreadRadius: -2,
        color: Colors.black26,
      ),
    ],
  });

  final double borderRadius;
  final Color backgroundColor;
  final TextStyle? textStyleActive;
  final TextStyle? textStyleInActive;
  final Duration animatedDuration;
  final List<BoxShadow> shadow;
}

class ToggleContainerStyle {
  ToggleContainerStyle({
    this.borderRadius = 8,
    this.backgroundColor = Colors.black12,
    this.padding = const EdgeInsets.all(8.0),
  });

  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color backgroundColor;
}
