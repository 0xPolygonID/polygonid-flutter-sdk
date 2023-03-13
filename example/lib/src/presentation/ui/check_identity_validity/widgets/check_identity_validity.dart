import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/check_identity_validity/bloc/check_identity_validity_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/check_identity_validity/bloc/check_identity_validity_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/check_identity_validity/bloc/check_identity_validity_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';

class CheckIdentityValidityScreen extends StatefulWidget {
  const CheckIdentityValidityScreen({Key? key}) : super(key: key);

  @override
  State<CheckIdentityValidityScreen> createState() =>
      _CheckIdentityValidityScreenState();
}

class _CheckIdentityValidityScreenState
    extends State<CheckIdentityValidityScreen> {
  late final CheckIdentityValidityBloc _bloc;

  String _secret = '';
  String _blockchain = 'polygon';
  String _network = 'mumbai';

  TextEditingController _secretController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = getIt<CheckIdentityValidityBloc>();
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
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildTitle(),
                  const SizedBox(height: 6),
                  _buildDescription(),
                  const SizedBox(height: 18),
                  _buildSecretField(),
                  const SizedBox(height: 18),
                  _buildBlockchainField(),
                  const SizedBox(height: 18),
                  _buildNetworkField(),
                  const SizedBox(height: 18),
                  _buildResult(),
                ],
              ),
            ),
          ),
          _buildButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  ///
  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'Check Identity Validity',
        style: CustomTextStyles.titleTextStyle,
      ),
    );
  }

  ///
  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'Check if an identity is valid or not.',
        style: CustomTextStyles.descriptionTextStyle,
      ),
    );
  }

  ///
  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        _bloc.add(
            CheckIdentityValidityEvent.checkIdentityValidity(secret: _secret));
      },
      style: CustomButtonStyle.primaryButtonStyle,
      child: const FittedBox(
        child: Text(
          CustomStrings.chechIdentityValidityButtonCTA,
          textAlign: TextAlign.center,
          style: CustomTextStyles.primaryButtonTextStyle,
        ),
      ),
    );
  }

  ///
  Widget _buildResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder<CheckIdentityValidityBloc, CheckIdentityValidityState>(
        bloc: _bloc,
        builder: (context, state) {
          return state.when(
            initial: () {
              return const SizedBox.shrink();
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            success: () {
              return Text(
                'Identity is valid',
                style: CustomTextStyles.successTextStyle,
              );
            },
            error: (error) {
              return Text(
                "Invalid identity\n$error",
                style: CustomTextStyles.errorTextStyle,
              );
            },
          );
        },
      ),
    );
  }

  ///
  Widget _buildSecretField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        controller: _secretController,
        onChanged: (value) {
          _secret = value;
          _bloc.add(const ResetCheckIdentityValidity());
        },
        decoration: const InputDecoration(
          hintText: 'Secret',
          labelText: 'Secret',
          labelStyle: TextStyle(color: CustomColors.primaryButton),
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: CustomColors.primaryButton),
          ),
        ),
      ),
    );
  }

  ///
  Widget _buildBlockchainField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        enabled: false,
        initialValue: _blockchain,
        onChanged: (value) {
          _blockchain = value;
          _bloc.add(const ResetCheckIdentityValidity());
        },
        decoration: const InputDecoration(
          hintText: 'Blockchain',
          labelText: 'Blockchain',
          labelStyle: TextStyle(color: CustomColors.primaryButton),
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: CustomColors.primaryButton),
          ),
        ),
      ),
    );
  }

  ///
  Widget _buildNetworkField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        initialValue: _network,
        enabled: false,
        onChanged: (value) {
          _network = value;
          _bloc.add(const ResetCheckIdentityValidity());
        },
        decoration: const InputDecoration(
          hintText: 'Network',
          labelText: 'Network',
          labelStyle: TextStyle(color: CustomColors.primaryButton),
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: CustomColors.primaryButton),
          ),
        ),
      ),
    );
  }
}
