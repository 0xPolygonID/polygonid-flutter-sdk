import 'package:fast_base58/fast_base58.dart';
import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:web3dart/crypto.dart';

class StateIdentifierMapper extends ToMapper<String, String> {
  @override
  String mapTo(String to) {
    return bytesToHex(Uint8ArrayUtils.bigIntToBytes(BigInt.parse(to)));
  }
}
