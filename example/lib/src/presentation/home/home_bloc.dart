import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk_example/src/common/bloc/bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/create_identity_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/get_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/home/home_state.dart';

class HomeBloc extends Bloc<HomeState> {
  final GetIdentifierUseCase _getIdentifierUseCase;
  final CreateIdentityUseCase _createIdentityUseCase;

  HomeBloc(
    this._getIdentifierUseCase,
    this._createIdentityUseCase,
  ) {
    changeState(HomeState.init());
  }

  ///
  Future<void> getIdentifier() async {
    changeState(HomeState.loading());
    String? identifier = await _getIdentifierUseCase.execute();
    changeState(HomeState.loaded(identifier));
  }

  ///
  Future<void> createIdentity() async {
    changeState(HomeState.loading());

    String? identifier;
    try {
      identifier = await _createIdentityUseCase.execute();
    } on IdentityException catch (identityException) {
      changeState(HomeState.error(identityException.error));
    } catch (_) {
      changeState(HomeState.error("A generic error occurred, try again"));
    } finally {
      changeState(HomeState.loaded(identifier));
    }
  }
}
