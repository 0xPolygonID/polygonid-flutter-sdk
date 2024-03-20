import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/credential_offer_data.dart';

abstract class CredentialOfferMessageEntity<T extends CredentialOfferBody>
    extends Iden3MessageEntity<T> {
  CredentialOfferMessageEntity({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required super.body,
    super.to,
    super.nextRequest,
    super.messageType,
  });
}

abstract class CredentialOfferBody {
  final List<CredentialOfferData> credentials;

  CredentialOfferBody({required this.credentials});
}
