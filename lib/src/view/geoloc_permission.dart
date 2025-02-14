import 'package:core_kosmos/core_package.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permissionrequest/src/provider/geoloc_provider.dart';
import 'package:permissionrequest/src/view/blank_permission.dart';
import 'package:ui_kosmos_v4/cta/theme.dart';

class GeolocPermission extends ConsumerWidget {
  const GeolocPermission({
    Key? key,
    this.pageController,
    this.validateText = 'Activer la géolocalisation',
    this.onBack,
    this.onSkip,
    this.onValidate,
    this.skipText,
    this.asset = 'assets/geoloc.png',
    this.title = 'Géolocalisation',
    this.subtitle = 'Pour utiliser pleinement notre application mobile, vous devez accepter la géolocalisation.',
    this.isBackground = false,
    this.isSafeArea = true,
    this.backgroundColor,
    this.titleStyle,
    this.package = 'permissionrequest',
    this.assetSize,
    this.subtitleStyle,
    this.validateButtonPadding,
    this.backButtonPadding,
    this.skipButtonPadding,
    this.themeBack,
    this.themeNameBack,
    this.themeSkip,
    this.themeNameSkip,
    this.themeValidate,
    this.themeNameValidate,
    this.assetChild,

  }) : super(key: key);

  final VoidCallback? onValidate;
  final PageController? pageController;
  final VoidCallback? onBack;
  final VoidCallback? onSkip;
  final String validateText;
  final String? skipText;
  final String? title;
  final String? subtitle;
  final String? asset;
  final Color? backgroundColor;
  final bool isBackground;
  final String? package;
  final bool isSafeArea;
  final EdgeInsets? validateButtonPadding;
  final EdgeInsets? backButtonPadding;
  final EdgeInsets? skipButtonPadding;
  final Size? assetSize;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final CtaThemeData? themeBack;
  final String? themeNameBack;
  final CtaThemeData? themeValidate;
  final String? themeNameValidate;
  final CtaThemeData? themeSkip;
  final String? themeNameSkip;
  final Widget? assetChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlankPermission(
      subtitle: subtitle,
      validateText: validateText,
      asset: asset,
      package: package,
      title: title,
      onValidate: onValidate ??
          () async {
            try {
              await ref.read(geolocProvider).init();
              pageController!.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
            } catch (e) {
              printInDebug(e);
              await openAppSettings();
            }
          },
      onBack: onBack ??
          () {
            if (pageController != null) {
              if (pageController!.page != 0) {
                pageController!.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            }
          },
      onSkip: onSkip ?? () => Navigator.pop(context),
      skipText: skipText,
      assetChild: assetChild,
      backgroundColor: backgroundColor,
      isBackground: isBackground,
      themeSkip: themeSkip,
      themeBack: themeBack,
      isSafeArea: isSafeArea,
      validateButtonPadding: validateButtonPadding,
      backButtonPadding: backButtonPadding,
      skipButtonPadding: skipButtonPadding,
      assetSize: assetSize,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
    );
  }
}
