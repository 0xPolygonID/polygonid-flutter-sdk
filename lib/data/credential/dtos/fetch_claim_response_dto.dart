import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/credential_dto.dart';

part 'fetch_claim_response_dto.g.dart';

@JsonEnum()
enum FetchClaimResponseType {
  @JsonValue("")
  unknown,
  @JsonValue("https://iden3-communication.io/authorization/1.0/request")
  auth,
  @JsonValue("https://iden3-communication.io/credentials/1.0/offer")
  offer,
  @JsonValue("https://iden3-communication.io/credentials/1.0/issuance-response")
  issuance;
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class FetchClaimResponseDTO {
  @JsonKey(unknownEnumValue: FetchClaimResponseType.unknown)
  final FetchClaimResponseType type;
  final String from;
  @FetchClaimResponseCredentialConverter()
  @JsonKey(name: 'body')
  final CredentialDTO credential;

  FetchClaimResponseDTO(this.type, this.from, this.credential);

  factory FetchClaimResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$FetchClaimResponseDTOFromJson(json);
}

class FetchClaimResponseCredentialConverter
    extends JsonConverter<CredentialDTO, Map<String, dynamic>> {
  const FetchClaimResponseCredentialConverter();

  @override
  CredentialDTO fromJson(Map<String, dynamic> json) {
    return CredentialDTO.fromJson(json['credential']);
  }

  @override
  Map<String, dynamic> toJson(CredentialDTO object) {
    return object.toJson();
  }
}
