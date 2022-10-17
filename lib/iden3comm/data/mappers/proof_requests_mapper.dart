import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

import '../../domain/entities/proof_request_entity.dart';
import 'auth_request_mapper.dart';
import 'contract_request_mapper.dart';
import 'fetch_request_mapper.dart';
import 'offer_request_mapper.dart';
import 'proof_query_param_mapper.dart';

class ProofRequestsMapper
    extends FromMapper<Iden3MessageEntity, List<ProofRequestEntity>> {
  final AuthRequestMapper _authRequestMapper;
  final FetchRequestMapper _fetchRequestMapper;
  final OfferRequestMapper _offerRequestMapper;
  final ContractRequestMapper _contractRequestMapper;
  final ProofQueryParamMapper _proofQueryParamMapper;

  ProofRequestsMapper(
      this._authRequestMapper,
      this._fetchRequestMapper,
      this._offerRequestMapper,
      this._contractRequestMapper,
      this._proofQueryParamMapper);

  @override
  List<ProofRequestEntity> mapFrom(Iden3MessageEntity from) {
    List<ProofRequestEntity> proofRequests = [];
    var request;

    switch (from.type) {
      case Iden3MessageType.auth:
        request = _authRequestMapper.mapTo(from);
        break;
      case Iden3MessageType.contractFunctionCall:
        request = _contractRequestMapper.mapTo(from);
        break;
      default:
        throw UnsupportedIden3MsgTypeException(from.type);
    }

    request.body.scope?.forEach((request) {
      if (request.circuit_id != null && request.rules != null) {
        proofRequests.add(ProofRequestEntity(
            request.id.toString(),
            request.circuit_id!,
            request.optional ?? false,
            request.rules!.toJson(),
            _proofQueryParamMapper.mapFrom(request)));
      }
    });

    return proofRequests;
  }
}
