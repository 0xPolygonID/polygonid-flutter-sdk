import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/models/iden3_message.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_state.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/widgets/claim_card.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_event.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';

class ClaimsScreen extends StatefulWidget {
  final ClaimsBloc _bloc;

  ClaimsScreen({Key? key})
      : _bloc = getIt<ClaimsBloc>(),
        super(key: key);

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._bloc.add(const ClaimsEvent.getClaims());
    });
  }

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildTitle(),
                    const SizedBox(height: 6),
                    _buildDescription(),
                    const SizedBox(height: 24),
                    _buildClaimList(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildClaimsConnectButton(),
            _buildBlocListener(),
          ],
        ),
      ),
    );
  }

  ///
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        CustomStrings.claimsTitle,
        style: CustomTextStyles.descriptionTextStyle.copyWith(fontSize: 20),
      ),
    );
  }

  ///
  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        CustomStrings.claimsDescription,
        textAlign: TextAlign.start,
        style: CustomTextStyles.descriptionTextStyle,
      ),
    );
  }

  ///
  Widget _buildClaimsConnectButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          widget._bloc.add(const ClaimsEvent.clickScanQrCode());
        },
        style: CustomButtonStyle.primaryButtonStyle,
        child: const Text(
          CustomStrings.authButtonCTA,
          style: CustomTextStyles.primaryButtonTextStyle,
        ),
      ),
    );
  }

  ///
  Widget _buildClaimList() {
    return BlocBuilder(
      bloc: widget._bloc,
      builder: (BuildContext context, ClaimsState state) {
        if (state is LoadedDataClaimsState) {
          List<ClaimModel> claimList = state.claimList;
          List<Widget> claimWidgetList = _buildClaimCardWidgetList(claimList);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: claimWidgetList,
          );
        }
        return const SizedBox.shrink();
      },
      buildWhen: (_, ClaimsState currentState) {
        bool rebuild = currentState is LoadedDataClaimsState;
        return rebuild;
      },
    );
  }

  ///
  List<Widget> _buildClaimCardWidgetList(List<ClaimModel> claimList) {
    return claimList
        .map((claimModelItem) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ClaimCard(claimModel: claimModelItem),
            ))
        .toList();
  }

  ///
  Widget _buildBlocListener() {
    return BlocListener<ClaimsBloc, ClaimsState>(
      bloc: widget._bloc,
      listener: (context, state) {
        if (state is NavigateToQrCodeScannerClaimsState) {
          _handleNavigateToQrCodeScannerClaimsState();
        }
        if (state is QrCodeScannedClaimsState) {
          _handleQrCodeScanned(state.iden3message);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  ///
  Future<void> _handleNavigateToQrCodeScannerClaimsState() async {
    String? qrCodeScanningResult =
        await Navigator.pushNamed(context, Routes.qrCodeScannerPath) as String?;
    widget._bloc.add(ClaimsEvent.onScanQrCodeResponse(qrCodeScanningResult));
  }

  ///
  void _handleQrCodeScanned(Iden3Message iden3message) {
    widget._bloc
        .add(ClaimsEvent.fetchAndSaveClaims(iden3message: iden3message));
  }
}
