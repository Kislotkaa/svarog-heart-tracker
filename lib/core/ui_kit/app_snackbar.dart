import 'dart:async';

import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

/// гарантирует отображение одного и только снекбара
OverlayEntry? _previousEntry;

/// позизиця снекбара на экране
enum SnackBarPosition {
  BOTTOM,
  TOP,
}

enum SnackStatusEnum { warning, access, normal, error }

class AppSnackbar {
  /// снекбар, который отображает текст в цветном контейнере
  static void showTextFloatingSnackBar({
    required String title,
    required String? description,
    required OverlayState? overlayState,
    SnackStatusEnum? status,
    Duration forwardAnimationDuration = const Duration(milliseconds: 300),
    Duration reverseAnimationDuration = const Duration(milliseconds: 300),
    Duration displayDuration = const Duration(seconds: 2),
    EdgeInsets margin = const EdgeInsets.only(left: 16, right: 16, top: 16),
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    Color? backgroundColor,
    Curve forwardCurve = Curves.easeIn,
    Curve reverseCurve = Curves.easeOut,
    DismissDirection dismissDirection = DismissDirection.up,
    SnackBarPosition snackBarPosition = SnackBarPosition.TOP,
    bool isDismissible = true,
  }) {
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (_) => _AppFloatingSnackBarWidget(
        onDismissed: () {
          overlayEntry.remove();
          _previousEntry = null;
        },
        borderRadius: BorderRadius.circular(16),
        forwardAnimationDuration: forwardAnimationDuration,
        reverseAnimationDuration: reverseAnimationDuration,
        displayDuration: displayDuration,
        forwardCurve: forwardCurve,
        reverseCurve: reverseCurve,
        dismissDirection: dismissDirection,
        snackBarPosition: snackBarPosition,
        margin: margin,
        isDismissible: isDismissible,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? appTheme.revertBasicColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (status != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Builder(builder: (context) {
                    switch (status) {
                      case SnackStatusEnum.error:
                        return Icon(
                          Icons.error_outline,
                          color: appTheme.errorColor,
                        );
                      case SnackStatusEnum.warning:
                        return Icon(
                          Icons.warning_amber,
                          color: appTheme.yellowColor,
                        );

                      case SnackStatusEnum.access:
                        return Icon(
                          Icons.check,
                          color: appTheme.greenColor,
                        );

                      default:
                        return const SizedBox();
                    }
                  }),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: appTheme.textTheme.captionExtrabold14.copyWith(
                      color: appTheme.cardColor,
                    ),
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        description,
                        style: appTheme.textTheme.smallCaptionSemibold12.copyWith(
                          color: appTheme.textGrayColor,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (isSnackBarOpened) {
      closeSnackbar();
    }

    overlayState?.insert(overlayEntry);
    _previousEntry = overlayEntry;
  }

  /// проверка на отображающийся снекбар
  static bool get isSnackBarOpened => _previousEntry?.mounted == true;

  /// закрытие снекбара
  static void closeSnackbar() {
    _previousEntry?.remove();
    _previousEntry = null;
  }
}

/// Анимирующийся виджет с child
class _AppFloatingSnackBarWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;
  final Duration forwardAnimationDuration;
  final Duration reverseAnimationDuration;
  final Duration displayDuration;
  final Curve forwardCurve;
  final Curve reverseCurve;
  final bool isDismissible;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final DismissDirection dismissDirection;
  final SnackBarPosition snackBarPosition;

  const _AppFloatingSnackBarWidget({
    Key? key,
    required this.child,
    required this.onDismissed,
    required this.forwardAnimationDuration,
    required this.reverseAnimationDuration,
    required this.displayDuration,
    required this.forwardCurve,
    required this.reverseCurve,
    required this.margin,
    required this.dismissDirection,
    required this.snackBarPosition,
    required this.borderRadius,
    this.isDismissible = false,
  }) : super(key: key);

  @override
  _AppFloatingSnackBarState createState() => _AppFloatingSnackBarState();
}

class _AppFloatingSnackBarState extends State<_AppFloatingSnackBarWidget> with SingleTickerProviderStateMixin {
  late final Animation<Offset> _offsetAnimation;
  late final AnimationController _animationController;
  late final Tween<Offset> _offsetTween;

  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.forwardAnimationDuration,
      reverseDuration: widget.reverseAnimationDuration,
    )..addStatusListener(
        (status) {
          /// если анимация завершена, то запускаем таймер отображающегося снекбара
          /// потом отматывваем анимацию назад
          if (status == AnimationStatus.completed) {
            _timer = Timer(
              widget.displayDuration,
              () {
                if (mounted) {
                  _animationController.reverse();
                }
              },
            );
          }

          /// если смахнули, то выключаем таймер отображения и удаляем снекбар
          if (status == AnimationStatus.dismissed) {
            _timer?.cancel();
            widget.onDismissed.call();
          }
        },
      );

    if (SnackBarPosition.BOTTOM == widget.snackBarPosition) {
      _offsetTween = Tween(begin: const Offset(0, 1), end: Offset.zero);
    } else if ((SnackBarPosition.TOP == widget.snackBarPosition)) {
      _offsetTween = Tween(begin: const Offset(0, -1), end: Offset.zero);
    }
    _offsetAnimation = _offsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.forwardCurve,
        reverseCurve: widget.reverseCurve,
      ),
    );

    /// если виджет смонтирован в дерево, то запускаем анимацию
    if (mounted) {
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      /// если widget.snackBarPosition == SnackBarPosition.TOP, то берем отступ из margin
      /// в противном случае null, делается для того, чтобы контейнер не растягивался
      /// с widget.snackBarPosition == SnackBarPosition.BOTTOM аналагичная ситуация
      top: widget.snackBarPosition == SnackBarPosition.TOP ? widget.margin.top : null,
      bottom: widget.snackBarPosition == SnackBarPosition.BOTTOM ? widget.margin.bottom : null,
      left: widget.margin.left,
      right: widget.margin.right,
      child: SlideTransition(
        position: _offsetAnimation,
        child: SafeArea(
          /// можем ли смахнуть снекбар, если да, то добавляем Dismissible виджет
          child: widget.isDismissible
              ? Dismissible(
                  key: UniqueKey(),
                  direction: widget.dismissDirection,
                  dismissThresholds: {widget.dismissDirection: 0.2},
                  confirmDismiss: (direction) async {
                    /// если смонтирован
                    if (mounted) {
                      /// и направление свайпа в сторону, которую мы указали для dismissDirection
                      /// то реверсим анимацию, в противном случае сбрасываем ее
                      if (direction == widget.dismissDirection) {
                        await _animationController.reverse();
                      } else {
                        _animationController.reset();
                      }
                    }
                    return false;
                  },

                  /// не забываем прописывать Material, чтобы все правильно отображалось
                  child: ClipRRect(
                    borderRadius: widget.borderRadius,
                    child: Material(
                      child: widget.child,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: widget.borderRadius,
                  child: Material(
                    borderRadius: widget.borderRadius,
                    child: widget.child,
                  ),
                ),
        ),
      ),
    );
  }
}
