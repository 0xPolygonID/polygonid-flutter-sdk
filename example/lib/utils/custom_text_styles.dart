import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';

class CustomTextStyles {
  CustomTextStyles._();

  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'ModernEra',
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontFamily: 'ModernEra',
    fontSize: 14,
    color: CustomColors.subtitleText,
  );

  static const TextStyle generalStyle = TextStyle(
    fontFamily: 'ModernEra',
    fontSize: 14,
  );

  static const TextStyle primaryButtonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'ModernEra',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle descriptionTextStyle = TextStyle(
    color: CustomColors.textGrayDark,
    fontSize: 16,
    height: 1.8,
    decoration: TextDecoration.none,
    fontFamily: 'ModernEra',
    fontWeight: FontWeight.w400,
  );

  static TextStyle claimCardIssuerTextStyle = TextStyle(
    color: CustomColors.proofCardSubtitle.withOpacity(0.8),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle claimCardIssuerNameTextStyle = const TextStyle(
    fontFamily: 'ModernEra',
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
