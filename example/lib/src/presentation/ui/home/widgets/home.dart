import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/home_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/home_state.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initGetIdentifier();
    });
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
  void _initGetIdentifier() {
    widget._bloc.getIdentifier();
  }

  ///
  Widget _buildCreateIdentityButton() {
    return StreamBuilder<HomeState>(
        stream: widget._bloc.observableState,
        builder: (context, snapshot) {
          bool enabled = (snapshot.data is! LoadingDataHomeState) && (snapshot.data?.identifier == null || snapshot.data!.identifier!.isEmpty);
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
        });
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
    return StreamBuilder<HomeState>(
        stream: widget._bloc.observableState,
        builder: (context, snapshot) {
          return SizedBox(
            height: 48,
            width: 48,
            child: Visibility(
              visible: snapshot.data is LoadingDataHomeState,
              child: const CircularProgressIndicator(
                backgroundColor: CustomColors.primaryButton,
              ),
            ),
          );
        });
  }

  ///
  Widget _buildIdentifierSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            CustomStrings.homeIdentifierSectionPrefix,
            style: CustomTextStyles.descriptionTextStyle.copyWith(fontSize: 20),
          ),
          StreamBuilder<HomeState>(
              stream: widget._bloc.observableState,
              builder: (context, snapshot) {
                String identifierText = snapshot.data?.identifier ?? CustomStrings.homeIdentifierSectionPlaceHolder;
                return Text(
                  identifierText,
                  key: const Key('identifier'),
                  style: CustomTextStyles.descriptionTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                );
              }),
        ],
      ),
    );
  }

  ///
  Widget _buildErrorSection() {
    return StreamBuilder<HomeState>(
        stream: widget._bloc.observableState,
        builder: (context, snapshot) {
          bool visible = snapshot.data is ErrorHomeState && (snapshot.data as ErrorHomeState).message.isNotEmpty;
          String message = snapshot.data is ErrorHomeState ? (snapshot.data as ErrorHomeState).message : "";
          return Visibility(
            visible: visible,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                message,
                style: CustomTextStyles.descriptionTextStyle.copyWith(color: CustomColors.redError),
              ),
            ),
          );
        });
  }
}
