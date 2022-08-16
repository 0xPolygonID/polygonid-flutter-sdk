import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polygonid_flutter_sdk_example/src/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/splash/splash_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/splash/splash_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/image_resources.dart';

class SplashScreen extends StatefulWidget {
  final SplashBloc _bloc;

  SplashScreen({Key? key})
      : _bloc = getIt<SplashBloc>(),
        super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _changeStateStreamSubscription;

  @override
  void initState() {
    _initChangeStateListener();
    _initFakeLoading();
    super.initState();
  }

  @override
  void dispose() {
    _changeStateStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: _buildBody(),
    );
  }

  ///
  Widget _buildBody() {
    return Center(
      child: SvgPicture.asset(
        ImageResources.logo,
        width: 180,
      ),
    );
  }

  ///
  void _initChangeStateListener() {
    _changeStateStreamSubscription = widget._bloc.observableState.listen((SplashState event) {
      _handleSplashState(event);
    });
  }

  ///
  void _handleSplashState(SplashState event) {
    if (event is WaitingTimeEndedSplashState) _handleWaitingTImeEnded();
  }

  ///
  void _handleWaitingTImeEnded() {
    Navigator.of(context).pushReplacementNamed(Routes.homePath);
  }

  /// Simulating a data loading, useful for any purpose
  void _initFakeLoading() {
    widget._bloc.fakeLoading();
  }
}
