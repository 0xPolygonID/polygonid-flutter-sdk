import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/bloc/claim_detail_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/bloc/claim_detail_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/bloc/claim_detail_state.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_detail_model.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';

class ClaimDetailScreen extends StatefulWidget {
  final ClaimModel claimModel;
  final ClaimDetailBloc _bloc;

  ClaimDetailScreen({Key? key, required this.claimModel})
      : _bloc = getIt<ClaimDetailBloc>(),
        super(key: key);

  @override
  State<ClaimDetailScreen> createState() => _ClaimDetailScreenState();
}

class _ClaimDetailScreenState extends State<ClaimDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  ///
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: CustomColors.background,
    );
  }

  ///
  Widget _buildBody() {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildTitle(),
                    const SizedBox(height: 6),
                    _buildDetails(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildRemoveClaimButton(),
            _buildBlocListener(),
          ],
        ),
      ),
    );
  }

  ///
  Widget _buildTitle() {
    return Text(
      widget.claimModel.name,
      style: CustomTextStyles.descriptionTextStyle.copyWith(fontSize: 20),
    );
  }

  ///
  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.claimModel.details
          .map((detail) => _buildDetail(detail))
          .toList(),
    );
  }

  ///
  Widget _buildDetail(ClaimDetailModel detail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.name,
          ),
          Text(
            detail.value,
          ),
        ],
      ),
    );
  }

  ///
  Widget _buildRemoveClaimButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            widget._bloc.add(
                ClaimDetailEvent.deleteClaim(claimId: widget.claimModel.id));
          },
          style: CustomButtonStyle.primaryButtonStyle,
          child: const Text(
            CustomStrings.deleteClaimButtonCTA,
            style: CustomTextStyles.primaryButtonTextStyle,
          ),
        ),
      ),
    );
  }

  ///
  Widget _buildBlocListener() {
    return BlocListener<ClaimDetailBloc, ClaimDetailState>(
      bloc: widget._bloc,
      listener: (context, state) {
        if (state is ClaimDeletedClaimDetailState) {
          Navigator.of(context).pop(true);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
