import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polygonid_flutter_sdk_example/src/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/home/home_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/home/home_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';
import 'package:polygonid_flutter_sdk_example/utils/image_resources.dart';

class HomeScreen extends StatefulWidget {
  final HomeBloc _bloc;

  HomeScreen({Key? key})
      : _bloc = getIt<HomeBloc>(),
        super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? _changeStateStreamSubscription;

  bool _isLoadingData = true;
  String? _identifier;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initChangeStateListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initGetIdentifier();
    });
  }

  @override
  void dispose() {
    _changeStateStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: CustomColors.background,
      body: SafeArea(
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
                      _buildLogo(),
                      const SizedBox(height: 13),
                      _buildDescription(),
                      const SizedBox(height: 24),
                      _buildProgress(),
                      const SizedBox(height: 24),
                      _buildIdentifierSection(),
                      const SizedBox(height: 24),
                      _buildErrorSection(),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
              _buildCreateIdentityButton(),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void _initChangeStateListener() {
    _changeStateStreamSubscription = widget._bloc.observableState.listen((HomeState event) {
      _handleHomeState(event);
    });
  }

  ///
  void _initGetIdentifier() {
    widget._bloc.getIdentifier();
  }

  ///
  void _handleHomeState(HomeState event) {
    if (event is LoadingDataHomeState) _handleLoadingData();
    if (event is LoadedIdentifierHomeState) _handleLoadedIdentifier(event.identifier);
    if (event is ErrorHomeState) _handleError(event.message);
  }

  ///
  void _handleLoadingData() {
    setState(() {
      _isLoadingData = true;
      _error = "";
    });
  }

  ///
  void _handleLoadedIdentifier(String? identifier) {
    setState(() {
      _isLoadingData = false;
      _identifier = identifier;
    });
  }

  ///
  void _handleError(String message) {
    setState(() {
      _error = message;
    });
  }

  ///
  Widget _buildCreateIdentityButton() {
    bool enabled = (!_isLoadingData) && (_identifier == null || _identifier!.isEmpty);
    return AbsorbPointer(
      absorbing: !enabled,
      child: ElevatedButton(
        onPressed: widget._bloc.createIdentity,
        style: enabled ? CustomButtonStyle.primaryButtonStyle : CustomButtonStyle.disabledPrimaryButtonStyle,
        child: const Text(
          CustomStrings.homeButtonCTA,
          style: CustomTextStyles.primaryButtonTextStyle,
        ),
      ),
    );
  }

  ///
  Widget _buildLogo() {
    return SvgPicture.asset(
      ImageResources.logo,
      width: 120,
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
  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        CustomStrings.homeDescription,
        textAlign: TextAlign.center,
        style: CustomTextStyles.descriptionTextStyle,
      ),
    );
  }

  ///
  Widget _buildProgress() {
    return SizedBox(
      height: 48,
      width: 48,
      child: Visibility(
        visible: _isLoadingData,
        child: const CircularProgressIndicator(
          backgroundColor: CustomColors.primaryButton,
        ),
      ),
    );
  }

  ///
  Widget _buildIdentifierSection() {
    String identifierText = _identifier ?? CustomStrings.homeIdentifierSectionPlaceHolder;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            CustomStrings.homeIdentifierSectionPrefix,
            style: CustomTextStyles.descriptionTextStyle.copyWith(fontSize: 20),
          ),
          Text(
            identifierText,
            key: const Key('identifier'),
            style: CustomTextStyles.descriptionTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  ///
  Widget _buildErrorSection() {
    return Visibility(
      visible: _error != null && _error!.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          _error ?? "",
          style: CustomTextStyles.descriptionTextStyle.copyWith(color: CustomColors.redError),
        ),
      ),
    );
  }
}
