import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';

class FetchIdentityStateUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepo;
  final GetSelectedChainUseCase _getSelectedChainUseCase;
  final GetDidUseCase _getDidUseCase;
  final StacktraceManager _stacktraceManager;

  FetchIdentityStateUseCase(
    this._identityRepo,
    this._getSelectedChainUseCase,
    this._getDidUseCase,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required String param}) async {
    return Future(() async {
      final chain = await _getSelectedChainUseCase.execute();
      final did = await _getDidUseCase.execute(param: param);
      final id = await _identityRepo.convertIdToBigInt(id: did.identifier);
      final state = await _identityRepo.getState(
        identifier: id,
        contractAddress: chain.stateContractAddr,
      );

      _stacktraceManager.addTrace(
          "[FetchIdentityStateUseCase] Fetched state for identifier $param");
      logger().i(
          "[FetchIdentityStateUseCase] Fetched state $state for identifier $param");

      return state;
    }).catchError((error) {
      _stacktraceManager.addTrace("[FetchIdentityStateUseCase] Error: $error");
      _stacktraceManager.addError("[FetchIdentityStateUseCase] Error: $error");
      logger().e("[FetchIdentityStateUseCase] Error: $error");
      throw error;
    });
  }
}
