import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/backup_identity/bloc/backup_identity_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/backup_identity/bloc/backup_identity_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/backup_identity/bloc/backup_identity_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';

class BackupIdentityScreen extends StatefulWidget {
  const BackupIdentityScreen({Key? key}) : super(key: key);

  @override
  State<BackupIdentityScreen> createState() => _BackupIdentityScreenState();
}

class _BackupIdentityScreenState extends State<BackupIdentityScreen> {
  late final BackupIdentityBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<BackupIdentityBloc>();
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
        CustomStrings.backupIdentityTitle,
        style: CustomTextStyles.titleTextStyle,
      ),
    );
  }

  ///
  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        CustomStrings.backupIdentityScreenDescription,
        style: CustomTextStyles.descriptionTextStyle,
      ),
    );
  }

  ///
  Widget _buildResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder<BackupIdentityBloc, BackupIdentityState>(
        bloc: _bloc,
        builder: (context, state) {
          return state.when(
            initial: () {
              return _buildResultInitialState();
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            success: (value) {
              return Text(
                value,
                style: CustomTextStyles.descriptionTextStyle,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              );
            },
            error: (error) {
              return Text(
                error,
                style: CustomTextStyles.errorTextStyle,
              );
            },
          );
        },
      ),
    );
  }

  ///
  Widget _buildResultInitialState() {
    return const Text(
      "Not exported yet",
      style: CustomTextStyles.descriptionTextStyle,
    );
  }

  ///
  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        _bloc.add(const BackupIdentityEvent.backupIdentity());
      },
      style: CustomButtonStyle.primaryButtonStyle,
      child: const FittedBox(
        child: Text(
          CustomStrings.backupIdentityButtonCTA,
          textAlign: TextAlign.center,
          style: CustomTextStyles.primaryButtonTextStyle,
        ),
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
}
