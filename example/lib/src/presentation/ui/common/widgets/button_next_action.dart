import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';

class ButtonNextAction extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;

  const ButtonNextAction({
    Key? key,
    required this.onPressed,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enabled,
      child: Ink(
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: enabled
              ? CustomColors.primaryButton
              : CustomColors.primaryButton.withOpacity(0.5),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.navigate_next,
            color: CustomColors.primaryButtonText,
          ),
        ),
      ),
    );
  }
}
