import 'package:json_annotation/json_annotation.dart';

part 'credential_fetch_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CredentialFetchRequest {
  final String id;
  final String typ;
  final String type;
  final String thid;
  final CredentialFetchRequestBody body;
  final String from;
  final String to;

  CredentialFetchRequest(
      {required this.id,
      required this.typ,
      required this.type,
      required this.thid,
      required this.body,
      required this.from,
      required this.to});

  factory CredentialFetchRequest.fromJson(Map<String, dynamic> json) =>
      _$CredentialFetchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialFetchRequestToJson(this);
}

@JsonSerializable()
class CredentialFetchRequestBody {
  final String id;

  CredentialFetchRequestBody({required this.id});

  factory CredentialFetchRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CredentialFetchRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialFetchRequestBodyToJson(this);
}
