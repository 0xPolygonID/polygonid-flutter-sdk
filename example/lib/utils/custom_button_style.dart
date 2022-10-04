import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';

class CustomButtonStyle {
  CustomButtonStyle._();

  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    enableFeedback: false,
    padding:
        const EdgeInsets.only(top: 18.0, bottom: 18.0, right: 24.0, left: 24.0),
    backgroundColor: CustomColors.primaryButton,
    shadowColor: CustomColors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static ButtonStyle disabledPrimaryButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    enableFeedback: false,
    padding:
        const EdgeInsets.only(top: 18.0, bottom: 18.0, right: 24.0, left: 24.0),
    backgroundColor: CustomColors.primaryButton.withOpacity(0.5),
    shadowColor: CustomColors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static ButtonStyle iconButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0.0),
    shape: MaterialStateProperty.all(const CircleBorder()),
    backgroundColor: MaterialStateProperty.all(Colors.white), // <-- Button color
    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.pressed)) {
        return CustomColors.backButtonPressed;
      }
      return null; // <-- Splash color
    }),
  );
}
