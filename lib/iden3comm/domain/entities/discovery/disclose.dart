import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

class DiscoverFeatureDiscloseMessage extends Iden3Message {
  DiscoverFeatureDiscloseMessage({
    String? id,
    super.typ,
    String? thid,
    required super.body,
    super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    List<Attachment>? attachments,
  }) : super(
         type: Iden3MessageType.discoveryDisclose,
         id: id ?? const Uuid().v4(),
         thid: thid ?? const Uuid().v4(),
         attachments: attachments ?? [],
       );

  factory DiscoverFeatureDiscloseMessage.fromJson(Map<String, dynamic> json) {
    return DiscoverFeatureDiscloseMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: DiscoverFeatureDiscloseMessageBody.fromJson(json['body']),
      from: json['from'],
      to: json['to'],
      createdTime: json['created_time'],
      expiresTime: json['expires_time'],
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class DiscoverFeatureDiscloseMessageBody {
  final List<DiscoverFeatureDisclosure> disclosures;

  DiscoverFeatureDiscloseMessageBody({required this.disclosures});

  factory DiscoverFeatureDiscloseMessageBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return DiscoverFeatureDiscloseMessageBody(
      disclosures: (json['disclosures'] as List<dynamic>)
          .map((e) => DiscoverFeatureDisclosure.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'disclosures': disclosures.map((e) => e.toJson()).toList()};
  }
}

class DiscoverFeatureDisclosure {
  final String featureType;
  final String id;

  DiscoverFeatureDisclosure({required this.featureType, required this.id});

  DiscoverFeatureDisclosure.fromJson(Map<String, dynamic> json)
    : featureType = json['feature_type'],
      id = json['id'];

  Map<String, dynamic> toJson() {
    return {'feature_type': featureType, 'id': id};
  }
}
