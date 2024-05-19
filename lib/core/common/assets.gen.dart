/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Roboto-Black.ttf
  String get robotoBlack => 'assets/fonts/Roboto-Black.ttf';

  /// File path: assets/fonts/Roboto-BlackItalic.ttf
  String get robotoBlackItalic => 'assets/fonts/Roboto-BlackItalic.ttf';

  /// File path: assets/fonts/Roboto-Bold.ttf
  String get robotoBold => 'assets/fonts/Roboto-Bold.ttf';

  /// File path: assets/fonts/Roboto-BoldItalic.ttf
  String get robotoBoldItalic => 'assets/fonts/Roboto-BoldItalic.ttf';

  /// File path: assets/fonts/Roboto-Italic.ttf
  String get robotoItalic => 'assets/fonts/Roboto-Italic.ttf';

  /// File path: assets/fonts/Roboto-Light.ttf
  String get robotoLight => 'assets/fonts/Roboto-Light.ttf';

  /// File path: assets/fonts/Roboto-LightItalic.ttf
  String get robotoLightItalic => 'assets/fonts/Roboto-LightItalic.ttf';

  /// File path: assets/fonts/Roboto-Medium.ttf
  String get robotoMedium => 'assets/fonts/Roboto-Medium.ttf';

  /// File path: assets/fonts/Roboto-MediumItalic.ttf
  String get robotoMediumItalic => 'assets/fonts/Roboto-MediumItalic.ttf';

  /// File path: assets/fonts/Roboto-Regular.ttf
  String get robotoRegular => 'assets/fonts/Roboto-Regular.ttf';

  /// File path: assets/fonts/Roboto-Thin.ttf
  String get robotoThin => 'assets/fonts/Roboto-Thin.ttf';

  /// File path: assets/fonts/Roboto-ThinItalic.ttf
  String get robotoThinItalic => 'assets/fonts/Roboto-ThinItalic.ttf';

  /// List of all assets
  List<String> get values => [
        robotoBlack,
        robotoBlackItalic,
        robotoBold,
        robotoBoldItalic,
        robotoItalic,
        robotoLight,
        robotoLightItalic,
        robotoMedium,
        robotoMediumItalic,
        robotoRegular,
        robotoThin,
        robotoThinItalic
      ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/appIcon.svg
  SvgGenImage get appIcon => const SvgGenImage('assets/icons/appIcon.svg');

  /// File path: assets/icons/body.svg
  SvgGenImage get body => const SvgGenImage('assets/icons/body.svg');

  /// File path: assets/icons/fire.svg
  SvgGenImage get fire => const SvgGenImage('assets/icons/fire.svg');

  /// List of all assets
  List<SvgGenImage> get values => [appIcon, body, fire];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/appBanner.png
  AssetGenImage get appBanner => const AssetGenImage('assets/images/appBanner.png');

  /// File path: assets/images/appIcon.png
  AssetGenImage get appIcon => const AssetGenImage('assets/images/appIcon.png');

  /// File path: assets/images/backGroundLogo.png
  AssetGenImage get backGroundLogo => const AssetGenImage('assets/images/backGroundLogo.png');

  /// File path: assets/images/eng.png
  AssetGenImage get eng => const AssetGenImage('assets/images/eng.png');

  /// File path: assets/images/rus.png
  AssetGenImage get rus => const AssetGenImage('assets/images/rus.png');

  /// File path: assets/images/vk.png
  AssetGenImage get vk => const AssetGenImage('assets/images/vk.png');

  /// List of all assets
  List<AssetGenImage> get values => [appBanner, appIcon, backGroundLogo, eng, rus, vk];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
