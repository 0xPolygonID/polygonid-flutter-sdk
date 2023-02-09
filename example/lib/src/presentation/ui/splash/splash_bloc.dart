import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/splash/splash_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/splash/splash_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_dimensions.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.init()) {
    on<FakeLoadingSplashEvent>(onFakeLoadingSplashEvent);
    on<DownloadProgressSplashEvent>(onDownloadProgressSplashEvent);
  }

  StreamSubscription? _subscription;

  /// Simulation of a possible loading time
  Future<void> onFakeLoadingSplashEvent(
      FakeLoadingSplashEvent event, Emitter<SplashState> emit) async {
    Stream<DownloadInfo> stream =
        await PolygonIdSdk.I.proof.initCircuitsDownloadAndGetInfoStream;
    _subscription = stream.listen((downloadInfo) {
      add(DownloadProgressSplashEvent(downloadInfo));
    });
  }

  Future<void> onDownloadProgressSplashEvent(
      DownloadProgressSplashEvent event, Emitter<SplashState> emit) async {
    if (event.downloadInfo.completed) {
      _subscription?.cancel();
      emit(SplashState.waitingTimeEnded());
    } else {
      emit(SplashState.downloadProgress(event.downloadInfo));
    }
  }
}
