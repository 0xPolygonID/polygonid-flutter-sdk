import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

class GetCurrentEnvDidIdentifierParam {
  final String privateKey;
  final BigInt profileNonce;

  GetCurrentEnvDidIdentifierParam({
    required this.privateKey,
    required this.profileNonce,
  });
}

class GetCurrentEnvDidIdentifierUseCase
    extends FutureUseCase<GetCurrentEnvDidIdentifierParam, String> {
  final GetSelectedChainUseCase _getSelectedChainUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final StacktraceManager _stacktraceManager;

  GetCurrentEnvDidIdentifierUseCase(
    this._getSelectedChainUseCase,
    this._getDidIdentifierUseCase,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required GetCurrentEnvDidIdentifierParam param}) {
    return _getSelectedChainUseCase
        .execute()
        .then((chain) => _getDidIdentifierUseCase.execute(
                param: GetDidIdentifierParam(
              privateKey: param.privateKey,
              blockchain: chain.blockchain,
              network: chain.network,
              profileNonce: param.profileNonce,
              method: chain.method,
            )))
        .then((did) {
      logger().i("[GetCurrentEnvDidIdentifierUseCase] did: $did");
      _stacktraceManager
          .addTrace("[GetCurrentEnvDidIdentifierUseCase] did: $did");

      return did;
    }).catchError((error) {
      _stacktraceManager
          .addError("[GetCurrentEnvDidIdentifierUseCase] Error: $error");
      _stacktraceManager
          .addTrace("[GetCurrentEnvDidIdentifierUseCase] Error: $error");
      logger().e("[GetCurrentEnvDidIdentifierUseCase] Error: $error");

      throw error;
    });
  }
}
