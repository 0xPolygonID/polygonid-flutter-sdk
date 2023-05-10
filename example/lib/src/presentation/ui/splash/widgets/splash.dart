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
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _changeStateStreamSubscription;
  SplashBloc _bloc = getIt<SplashBloc>();

  @override
  void initState() {
    super.initState();
    _startDownload();
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
      bloc: _bloc,
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
      bloc: _bloc,
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
                  _bloc.add(const SplashEvent.cancelDownloadEvent());
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
                  _bloc.add(const SplashEvent.startDownload());
                },
                style: CustomButtonStyle.outlinedPrimaryButtonStyle,
                child: FittedBox(
                  child: Text(
                    "Retry",
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.primaryButtonTextStyle
                        .copyWith(color: CustomColors.primaryButton),
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

  ///
  void _startDownload() {
    _bloc.add(const SplashEvent.startDownload());
  }
}
