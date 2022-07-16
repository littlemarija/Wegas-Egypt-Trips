/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app icon.svg
  SvgGenImage get appIcon => const SvgGenImage('assets/images/app icon.svg');

  /// File path: assets/images/appicon.png
  AssetGenImage get appicon => const AssetGenImage('assets/images/appicon.png');

  /// File path: assets/images/bg1.png
  AssetGenImage get bg1 => const AssetGenImage('assets/images/bg1.png');

  /// File path: assets/images/bg2.png
  AssetGenImage get bg2 => const AssetGenImage('assets/images/bg2.png');

  /// File path: assets/images/bg3.png
  AssetGenImage get bg3 => const AssetGenImage('assets/images/bg3.png');

  /// File path: assets/images/bomb.png
  AssetGenImage get bomb => const AssetGenImage('assets/images/bomb.png');

  /// File path: assets/images/dilan.png
  AssetGenImage get dilan => const AssetGenImage('assets/images/dilan.png');

  /// File path: assets/images/dilancell.png
  AssetGenImage get dilancell =>
      const AssetGenImage('assets/images/dilancell.png');

  /// File path: assets/images/emily.png
  AssetGenImage get emily => const AssetGenImage('assets/images/emily.png');

  /// File path: assets/images/emilycell.png
  AssetGenImage get emilycell =>
      const AssetGenImage('assets/images/emilycell.png');

  /// File path: assets/images/homeicon.svg
  SvgGenImage get homeicon => const SvgGenImage('assets/images/homeicon.svg');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/lora.png
  AssetGenImage get lora => const AssetGenImage('assets/images/lora.png');

  /// File path: assets/images/loracell.png
  AssetGenImage get loracell =>
      const AssetGenImage('assets/images/loracell.png');

  /// File path: assets/images/lose.png
  AssetGenImage get lose => const AssetGenImage('assets/images/lose.png');

  /// File path: assets/images/nora.png
  AssetGenImage get nora => const AssetGenImage('assets/images/nora.png');

  /// File path: assets/images/noracell.png
  AssetGenImage get noracell =>
      const AssetGenImage('assets/images/noracell.png');

  /// File path: assets/images/nubis.png
  AssetGenImage get nubis => const AssetGenImage('assets/images/nubis.png');

  /// File path: assets/images/nubiscell.png
  AssetGenImage get nubiscell =>
      const AssetGenImage('assets/images/nubiscell.png');

  /// File path: assets/images/onboardingbtn.svg
  SvgGenImage get onboardingbtn =>
      const SvgGenImage('assets/images/onboardingbtn.svg');

  /// File path: assets/images/onbomb.png
  AssetGenImage get onbomb => const AssetGenImage('assets/images/onbomb.png');

  /// File path: assets/images/rira.png
  AssetGenImage get rira => const AssetGenImage('assets/images/rira.png');

  /// File path: assets/images/riracell.png
  AssetGenImage get riracell =>
      const AssetGenImage('assets/images/riracell.png');

  /// File path: assets/images/win.png
  AssetGenImage get win => const AssetGenImage('assets/images/win.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
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
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
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
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;
}
