import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class ProblemReportMessageEntity extends Iden3MessageEntity<ProblemReportBody> {
  ProblemReportMessageEntity({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required super.body,
  }) : super(messageType: Iden3MessageType.problemReport);

  factory ProblemReportMessageEntity.fromJson(Map<String, dynamic> json) {
    ProblemReportBody body = ProblemReportBody.fromJson(json['body']);

    return ProblemReportMessageEntity(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      from: "",
      body: body,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['body'] = body.toJson();
    return data;
  }

  @override
  String toString() => "[ProblemReportMessageEntity] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is ProblemReportMessageEntity;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ProblemReportBody {
  final String code;
  final String comment;

  ProblemReportBody({
    required this.code,
    required this.comment,
  });

  factory ProblemReportBody.fromJson(Map<String, dynamic> json) {
    return ProblemReportBody(
      code: json['code'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'comment': comment,
    };
  }

  @override
  String toString() => "[ProblemReportBody] {code: $code, comment: $comment}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProblemReportBody &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          comment == other.comment;

  @override
  int get hashCode => runtimeType.hashCode;
}
