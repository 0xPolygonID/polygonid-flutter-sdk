import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/splash/splash_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/splash/splash_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/splash/splash_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';
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
    super.initState();
    _initFakeLoading();
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
    return BlocListener(
      bloc: widget._bloc,
      listener: (BuildContext context, SplashState state) {
        if (state is WaitingTimeEndedSplashState) _handleWaitingTimeEnded();
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              ImageResources.logo,
              width: 180,
            ),
            _buildDownloadProgress(),
          ],
        ),
      ),
    );
  }

  ///
  Widget _buildDownloadProgress() {
    return BlocBuilder(
      bloc: widget._bloc,
      builder: (BuildContext context, SplashState state) {
        if (state is DownloadProgressSplashState) {
          // return percentage
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Downloading circuits..."),
              const SizedBox(height: 2),
              Text(
                  "${(state.downloaded / state.contentLength * 100).toStringAsFixed(2)} %"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget._bloc.add(const SplashEvent.cancelDownloadEvent());
                },
                style: CustomButtonStyle.primaryButtonStyle,
                child: const FittedBox(
                  child: Text(
                    "Cancel download",
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.primaryButtonTextStyle,
                  ),
                ),
              ),
            ],
          );
        } else if (state is ErrorSplashState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Error downloading circuits"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget._bloc.add(const SplashEvent.startDownload());
                },
                style: CustomButtonStyle.outlinedPrimaryButtonStyle,
                child: const FittedBox(
                  child: Text(
                    "Retry",
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.primaryButtonTextStyle,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  ///
  void _handleWaitingTimeEnded() {
    Navigator.of(context).pushReplacementNamed(Routes.homePath);
  }

  /// Simulating a data loading, useful for any purpose
  void _initFakeLoading() {
    widget._bloc.add(const SplashEvent.startDownload());
  }
}
