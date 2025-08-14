import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/credential_offer_data.dart';

@Deprecated('Use CredentialOfferMessageEntity instead')
typedef CredentialOfferMessageEntity<T extends CredentialOfferBody>
    = BaseCredentialOfferMessage<T>;

abstract class BaseCredentialOfferMessage<T extends CredentialOfferBody>
    extends Iden3Message<T> {
  BaseCredentialOfferMessage({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required super.body,
    super.to,
    super.nextRequest,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  });
}

abstract class CredentialOfferBody {
  final List<CredentialOffer> credentials;

  CredentialOfferBody({required this.credentials});
}
