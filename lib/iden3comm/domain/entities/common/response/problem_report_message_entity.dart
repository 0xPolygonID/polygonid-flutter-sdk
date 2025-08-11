import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

@Deprecated('Use ProblemReportMessage instead')
typedef ProblemReportMessageEntity = ProblemReportMessage;

class ProblemReportMessage extends Iden3Message<ProblemReportBody> {
  // Parent thread
  final String pthid;

  // List of IDs of previous messages that triggered this one
  final List<String>? ack;

  ProblemReportMessage({
    required super.id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    super.thid = '',
    required this.pthid,
    required this.ack,
    required super.from,
    required super.body,
    super.to,
    super.nextRequest,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(type: Iden3MessageType.problemReport);

  factory ProblemReportMessage.fromJson(Map<String, dynamic> json) {
    ProblemReportBody body = ProblemReportBody.fromJson(json['body']);

    return ProblemReportMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'] ?? '',
      pthid: json['pthid'],
      ack: (json['ack'] as List?)?.map((e) => e.toString()).toList(),
      from: json['from'] ?? "",
      body: body,
      to: json['to'],
    );
  }

  /// Creates a new ProblemReportMessage with predefined fields
  ///
  /// [code] - Required problem code
  /// [threadId] - Thread ID for the message
  /// [parentThreadId] - Parent thread ID
  /// [acknowledgements] - Optional list of previous message IDs that triggered this one
  /// [comment] - Optional human-friendly text describing the problem
  /// [args] - Optional list of arguments for placeholders in comment field
  /// [escalateTo] - Optional URI where more help could be received
  static ProblemReportMessage createProblemReport({
    required String from,
    String? to = "",
    required String code,
    String? threadId,
    String? parentThreadId,
    List<String>? acknowledgements,
    String? comment,
    List<String>? args,
    String? escalateTo,
  }) {
    // Generate a unique message ID (this could be improved with a proper UUID generator)
    final String messageId = const Uuid().v4();

    // Use the provided threadId or generate a new one if not provided
    final String tId = threadId ?? const Uuid().v4();

    // Use the provided parentThreadId or use the threadId value if not provided
    final String parentTId = parentThreadId ?? tId;

    // Create the problem report body
    final body = ProblemReportBody(
      code: code,
      comment: comment,
      args: args,
      escalateTo: escalateTo,
    );

    return ProblemReportMessage(
      id: messageId,
      typ: 'application/iden3comm-plain-json',
      thid: tId,
      pthid: parentTId,
      ack: acknowledgements,
      from: from,
      to: to,
      body: body,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['body'] = body.toJson();
    data['pthid'] = pthid;
    data['ack'] = ack;
    return data;
  }

  @override
  String toString() => "[ProblemReportMessage] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is ProblemReportMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ProblemReportBody {
  // (optional) List of arguments matching the placeholders in comment field
  final List<String>? args;

  // (required) Problem code (See Problem Codes section)
  final String code;

  // (optional) Human-friendly text describing the problem. Can include {1} placeholders {2}
  final String? comment;

  // (optional) URI where more help about the problem could be received
  final String? escalateTo;

  ProblemReportBody({
    this.args,
    required this.code,
    this.comment,
    this.escalateTo,
  });

  factory ProblemReportBody.fromJson(Map<String, dynamic> json) {
    return ProblemReportBody(
      args: (json['args'] as List?)?.map((e) => e.toString()).toList(),
      code: json['code'],
      comment: json['comment'],
      escalateTo: json['escalate_to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      if (args != null) 'args': args,
      if (escalateTo != null) 'escalate_to': escalateTo,
      if (comment != null) 'comment': comment,
    };
  }

  @override
  String toString() =>
      "[ProblemReportBody] {code: $code, comment: $comment, args: $args, escalateTo: $escalateTo}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProblemReportBody &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          escalateTo == other.escalateTo &&
          args == other.args &&
          comment == other.comment;

  @override
  int get hashCode => runtimeType.hashCode;
}
