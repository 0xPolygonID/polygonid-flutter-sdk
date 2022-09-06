import 'package:polygonid_flutter_sdk_example/src/domain/identity/auth.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/models/auth_type_model_mapper.dart';

class Iden3Message {
  final String? id;
  final String? typ;
  final AuthType type;
  final String? thid;
  final Map<String, dynamic>? body;
  final String? from;
  final String? to;

  Iden3Message(
      {this.id,
        this.typ,
        this.type = AuthType.unknown,
        this.thid,
        this.body,
        this.from,
        this.to});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [Iden3Message]
  factory Iden3Message.fromJson(Map<String, dynamic> json) {
    return Iden3Message(
      id: json['id'],
      typ: json['typ'],
      type: AuthTypeModelMapper().mapTo(json['type']),
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'typ': typ,
    'type': AuthTypeModelMapper().mapFrom(type),
    'thid': thid,
    'from': from,
    'to': to,
    'body': body,
  };
}