import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';

class CustomTextStyles {
  CustomTextStyles._();

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    color: CustomColors.subtitleText,
  );

  static const TextStyle generalStyle = TextStyle(
    fontSize: 14,
  );

  static const TextStyle primaryButtonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle titleTextStyle = TextStyle(
    color: CustomColors.textGrayDark,
    fontSize: 20,
    height: 1.8,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle descriptionTextStyle = TextStyle(
    color: CustomColors.textGrayDark,
    fontSize: 16,
    height: 1.8,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400,
  );

  static TextStyle successTextStyle =
      descriptionTextStyle.copyWith(color: CustomColors.greenSuccess);

  static TextStyle errorTextStyle =
      descriptionTextStyle.copyWith(color: CustomColors.redError);

  static TextStyle claimCardIssuerTextStyle = TextStyle(
    color: CustomColors.proofCardSubtitle.withOpacity(0.8),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle claimCardIssuerNameTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
