import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';

class CheckProfileValidityParam {
  final BigInt profileNonce;

  CheckProfileValidityParam({required this.profileNonce});
}

class CheckProfileValidityUseCase
    extends FutureUseCase<CheckProfileValidityParam, void> {
  @override
  Future<void> execute({required CheckProfileValidityParam param}) {
    BigInt base = BigInt.parse('2');
    int exponent = 248;
    final maxVal = base.pow(exponent) - BigInt.one;
    return Future(() {
      if (param.profileNonce.isNegative || (param.profileNonce >= maxVal)) {
        throw InvalidProfileException(param.profileNonce);
      }
    }).then((_) {
      logger().i("[CheckProfileValidityUseCase] Profile is valid");
    }).catchError((error) {
      logger().e("[CheckValidProfileUseCase] Error: $error");

      throw error;
    });
  }
}
