import 'package:polygonid_flutter_sdk_example/src/common/bloc/bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/splash/splash_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_dimensions.dart';

class SplashBloc extends Bloc<SplashState> {
  SplashBloc() {
    changeState(SplashState.init());
  }

  /// Simulation of a possible loading time
  Future<void> fakeLoading() async {
    await Future.delayed(CustomDimensions.splashDuration);
    changeState(SplashState.waitingTimeEnded());
  }
}
