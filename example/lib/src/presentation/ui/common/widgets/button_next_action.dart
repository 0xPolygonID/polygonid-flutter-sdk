import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';

class ButtonNextAction extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonNextAction({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        shape: CircleBorder(),
        color: CustomColors.primaryButton,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.navigate_next,
          color: CustomColors.primaryButtonText,
        ),
      ),
    );
  }
}
