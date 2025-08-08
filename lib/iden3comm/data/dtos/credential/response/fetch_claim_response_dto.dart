import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/protocol_message_type.dart';

import '../../../../../credential/data/dtos/claim_info_dto.dart';

part 'fetch_claim_response_dto.g.dart';

@JsonEnum()
enum FetchClaimResponseType {
  @JsonValue("")
  unknown,
  @JsonValue(ProtocolMessageType.authorizationRequestMessageType)
  auth,
  @JsonValue(ProtocolMessageType.credentialOfferMessageType)
  offer,
  @JsonValue(ProtocolMessageType.credentialOnchainOfferMessageType)
  onchainOffer,
  @JsonValue(ProtocolMessageType.credentialIssuanceResponseMessageType)
  issuance,
  @JsonValue(ProtocolMessageType.contractInvokeRequestMessageType)
  contractFunctionCall,
  @JsonValue(ProtocolMessageType.contractInvokeResponseMessageType)
  contractFunctionCallResponse,
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class FetchClaimResponseDTO {
  @JsonKey(unknownEnumValue: FetchClaimResponseType.unknown)
  final FetchClaimResponseType type;
  final String from;
  @FetchClaimResponseCredentialConverter()
  @JsonKey(name: 'body')
  final ClaimInfoDTO credential;

  FetchClaimResponseDTO(this.type, this.from, this.credential);

  factory FetchClaimResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$FetchClaimResponseDTOFromJson(json);
}

class FetchClaimResponseCredentialConverter
    extends JsonConverter<ClaimInfoDTO, Map<String, dynamic>> {
  const FetchClaimResponseCredentialConverter();

  @override
  ClaimInfoDTO fromJson(Map<String, dynamic> json) {
    return ClaimInfoDTO.fromJson(json['credential']);
  }

  @override
  Map<String, dynamic> toJson(ClaimInfoDTO object) {
    return object.toJson();
  }
}
