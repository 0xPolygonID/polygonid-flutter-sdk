import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_dimensions.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';
import 'package:polygonid_flutter_sdk_example/utils/image_resources.dart';

class ClaimCard extends StatelessWidget {
  final ClaimModel claimModel;

  const ClaimCard({Key? key, required this.claimModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.width *
        CustomDimensions.claimCardHeightRatio;
    return SizedBox(
      height: cardHeight,
      child: Stack(
        children: [
          _buildBackground(),
          _buildContent(),
        ],
      ),
    );
  }

  ///
  Widget _buildBackground() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: const BoxDecoration(
          gradient: CustomColors.claimCardBackground,
        ),
        width: double.infinity,
        height: double.infinity,
        child: SvgPicture.asset(
          ImageResources.claimBackground,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  ///
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      claimModel.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              ),
              //const Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CustomStrings.claimCardIssuerLabel,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.claimCardIssuerTextStyle,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      claimModel.issuer,
                      style: CustomTextStyles.claimCardIssuerNameTextStyle,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
