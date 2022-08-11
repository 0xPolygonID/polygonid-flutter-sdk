import '../../identity/entities/circuit_data_entity.dart';

class CredentialRequestEntity {
  final String identifier;
  final CircuitDataEntity circuitData;
  final String url;
  final String id;
  final String thid;
  final String from;

  CredentialRequestEntity(this.identifier, this.circuitData, this.url, this.id,
      this.thid, this.from);
}
