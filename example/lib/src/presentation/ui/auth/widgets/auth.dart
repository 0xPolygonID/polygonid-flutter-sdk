import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_state.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/common/widgets/button_next_action.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';

class AuthScreen extends StatefulWidget {
  final AuthBloc _bloc;

  AuthScreen({Key? key})
      : _bloc = getIt<AuthBloc>(),
        super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
                  children: [
                    const SizedBox(height: 50),
                    _buildDescription(),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                _buildBlocListener(),
                _buildAuthConnectButton(),
                _buildNavigateToNextPageButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget _buildAuthConnectButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          //widget._bloc.getIden3messageFromQrScanning(context);
          widget._bloc.add(const AuthEvent.clickScanQrCode());
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
  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        CustomStrings.authDescription,
        textAlign: TextAlign.center,
        style: CustomTextStyles.descriptionTextStyle,
      ),
    );
  }

  ///
  Widget _buildNavigateToNextPageButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: ButtonNextAction(
          onPressed: () {
            Navigator.pushNamed(context, Routes.claimsPath);
          },
        ),
      ),
    );
  }

  ///
  Widget _buildBlocListener() {
    return BlocListener<AuthBloc, AuthState>(
      bloc: widget._bloc,
      listener: (context, state) {
        if (state is NavigateToQrCodeScannerAuthState) _handleNavigateToQrCodeScannerAuthState();
      },
      child: const SizedBox.shrink(),
    );
  }

  ///
  Future<void> _handleNavigateToQrCodeScannerAuthState() async {
    String? qrCodeScanningResult = await Navigator.pushNamed(context, Routes.qrCodeScannerPath) as String?;
    widget._bloc.add(AuthEvent.onScanQrCodeResponse(qrCodeScanningResult));
  }
}
