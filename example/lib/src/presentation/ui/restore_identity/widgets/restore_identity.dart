import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/restore_identity/bloc/restore_identity_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/restore_identity/bloc/restore_identity_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/restore_identity/bloc/restore_identity_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';

class RestoreIdentityScreen extends StatefulWidget {
  const RestoreIdentityScreen({Key? key}) : super(key: key);

  @override
  State<RestoreIdentityScreen> createState() => _RestoreIdentityScreenState();
}

class _RestoreIdentityScreenState extends State<RestoreIdentityScreen> {
  late final RestoreIdentityBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<RestoreIdentityBloc>();
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
                  const SizedBox(height: 24),
                  _buildResultLabel(),
                  const SizedBox(height: 8),
                  _buildResult(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildRestoreButton(),
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
        CustomStrings.restoreIdentityTitle,
        style: CustomTextStyles.titleTextStyle,
      ),
    );
  }

  ///
  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        CustomStrings.restoreIdentityScreenDescription,
        style: CustomTextStyles.descriptionTextStyle,
      ),
    );
  }

  ///
  Widget _buildResultLabel() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        "Result:",
        style: CustomTextStyles.titleTextStyle,
      ),
    );
  }

  ///
  Widget _buildResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder<RestoreIdentityBloc, RestoreIdentityState>(
        bloc: _bloc,
        builder: (context, state) {
          return state.when(
            initial: () {
              return _buildResultInitialState();
            },
            loading: () {
              return _buildLoadingState();
            },
            success: () {
              return _buildSuccessState();
            },
            error: (error) {
              return _buildErrorState(error);
            },
          );
        },
      ),
    );
  }

  ///
  Widget _buildResultInitialState() {
    return const Text(
      CustomStrings.restoreIdentityScreenInitialState,
      style: CustomTextStyles.descriptionTextStyle,
    );
  }

  ///
  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  ///
  Widget _buildSuccessState() {
    return const Text(
      CustomStrings.restoreIdentityScreenSuccess,
      style: CustomTextStyles.descriptionTextStyle,
    );
  }

  ///
  Widget _buildErrorState(String error) {
    return Text(
      error,
      style: CustomTextStyles.errorTextStyle,
    );
  }

  ///
  Widget _buildRestoreButton() {
    return ElevatedButton(
      onPressed: () {
        _bloc.add(const RestoreIdentityEvent.restoreIdentity());
      },
      style: CustomButtonStyle.primaryButtonStyle,
      child: const FittedBox(
        child: Text(
          CustomStrings.restoreIdentityButtonCTA,
          textAlign: TextAlign.center,
          style: CustomTextStyles.primaryButtonTextStyle,
        ),
      ),
    );
  }
}
