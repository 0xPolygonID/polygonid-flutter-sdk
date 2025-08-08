import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/base.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/credential_offer_data.dart';

@Deprecated('Use CredentialsOfferMessageBody instead')
typedef OfferBodyRequest = CredentialsOfferMessageBody;

class CredentialsOfferMessageBody extends CredentialOfferBody {
  final String url;

  CredentialsOfferMessageBody({
    required super.credentials,
    required this.url,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialsOfferMessageBody]
  factory CredentialsOfferMessageBody.fromJson(Map<String, dynamic> json) {
    List<CredentialOffer> credentials = (json['credentials'] as List)
        .map((item) => CredentialOffer.fromJson(item))
        .toList();
    return CredentialsOfferMessageBody(
      url: json['url'],
      credentials: credentials,
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'credentials': credentials.map((item) => item.toJson()).toList(),
      };

  @override
  String toString() =>
      "[CredentialsOfferMessageBody] {url: $url, credentials: $credentials}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialsOfferMessageBody &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          listEquals(credentials, other.credentials);

  @override
  int get hashCode => runtimeType.hashCode;
}
