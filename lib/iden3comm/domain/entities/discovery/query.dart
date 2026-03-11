import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

class DiscoverFeatureQueriesMessage
    extends Iden3Message<DiscoverFeatureQueriesMessageBody> {
  DiscoverFeatureQueriesMessage({
    String? id,
    super.typ,
    String? thid,
    required super.body,
    super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
         type: Iden3MessageType.discoveryQueries,
         id: id ?? const Uuid().v4(),
         thid: thid ?? const Uuid().v4(),
       );

  factory DiscoverFeatureQueriesMessage.fromJson(Map<String, dynamic> json) {
    return DiscoverFeatureQueriesMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: DiscoverFeatureQueriesMessageBody.fromJson(json['body']),
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

class DiscoverFeatureQueriesMessageBody implements JsonEncodable {
  final List<DiscoverFeatureQuery> queries;

  DiscoverFeatureQueriesMessageBody({required this.queries});

  factory DiscoverFeatureQueriesMessageBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return DiscoverFeatureQueriesMessageBody(
      queries: (json['queries'] as List<dynamic>)
          .map((e) => DiscoverFeatureQuery.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'queries': queries.map((e) => e.toJson()).toList()};
  }
}

class DiscoverFeatureQuery {
  final String featureType;
  final String? match;

  const DiscoverFeatureQuery({required this.featureType, this.match});

  factory DiscoverFeatureQuery.fromJson(Map<String, dynamic> json) {
    return DiscoverFeatureQuery(
      featureType: json['feature-type'],
      match: json['match'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'feature-type': featureType, if (match != null) 'match': match};
  }
}
