import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';

abstract class ClaimsState {
  List<ClaimModel> claimList = [];

  ClaimsState({this.claimList = const []});

  factory ClaimsState.init() => InitialClaimsState();

  factory ClaimsState.loading() => LoadingDataClaimsState();

  factory ClaimsState.loaded(List<ClaimModel> claimList) => LoadedDataClaimsState(claimList);

  factory ClaimsState.error(String message) => ErrorClaimsState(message: message);
}

///
class InitialClaimsState extends ClaimsState {
  InitialClaimsState();
}

///
class LoadingDataClaimsState extends ClaimsState {
  LoadingDataClaimsState();
}

///
class LoadedDataClaimsState extends ClaimsState {
  LoadedDataClaimsState(claimList) : super(claimList: claimList);
}

///
class ErrorClaimsState extends ClaimsState {
  final String message;

  ErrorClaimsState({required this.message});
}
