import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/common/widgets/button_next_action.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/home_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/home_event.dart';
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
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Stack(
                  children: [
                    _buildCreateIdentityButton(),
                    _buildNavigateToNextPageButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void _initGetIdentifier() {
    widget._bloc.add(const GetIdentifierHomeEvent());
  }

  ///
  Widget _buildCreateIdentityButton() {
    return Align(
      alignment: Alignment.center,
      child: BlocBuilder(
        bloc: widget._bloc,
        builder: (BuildContext context, HomeState state) {
          bool enabled = (state is! LoadingDataHomeState) &&
              (state.identifier == null || state.identifier!.isEmpty);
          return AbsorbPointer(
            absorbing: !enabled,
            child: ElevatedButton(
              onPressed: () {
                widget._bloc.add(const HomeEvent.createIdentity());
              },
              style: enabled
                  ? CustomButtonStyle.primaryButtonStyle
                  : CustomButtonStyle.disabledPrimaryButtonStyle,
              child: const Text(
                CustomStrings.homeButtonCTA,
                style: CustomTextStyles.primaryButtonTextStyle,
              ),
            ),
          );
        },
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
    return BlocBuilder(
      bloc: widget._bloc,
      builder: (BuildContext context, HomeState state) {
        if (state is! LoadingDataHomeState) return const SizedBox.shrink();
        return const SizedBox(
          height: 48,
          width: 48,
          child: CircularProgressIndicator(
            backgroundColor: CustomColors.primaryButton,
          ),
        );
      },
    );
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
          BlocBuilder(
            bloc: widget._bloc,
            builder: (BuildContext context, HomeState state) {
              return Text(
                state.identifier ??
                    CustomStrings.homeIdentifierSectionPlaceHolder,
                key: const Key('identifier'),
                style: CustomTextStyles.descriptionTextStyle
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
              );
            },
            buildWhen: (_, currentState) =>
                currentState is LoadedIdentifierHomeState,
          ),
        ],
      ),
    );
  }

  ///
  Widget _buildErrorSection() {
    return BlocBuilder(
      bloc: widget._bloc,
      builder: (BuildContext context, HomeState state) {
        if (state is! ErrorHomeState) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            state.message,
            style: CustomTextStyles.descriptionTextStyle
                .copyWith(color: CustomColors.redError),
          ),
        );
      },
    );
  }

  ///
  Widget _buildNavigateToNextPageButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: BlocBuilder(
          bloc: widget._bloc,
          builder: (BuildContext context, HomeState state) {
            bool enabled = (state is! LoadingDataHomeState) &&
                (state.identifier != null && state.identifier!.isNotEmpty);
            return ButtonNextAction(
              enabled: enabled,
              onPressed: () {
                Navigator.pushNamed(context, Routes.authPath);
              },
            );
          },
        ),
      ),
    );
  }
}
