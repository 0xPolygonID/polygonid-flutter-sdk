import 'package:polygonid_flutter_sdk/common/common.dart';
import 'package:polygonid_flutter_sdk/common/message_handler.dart';
import 'package:polygonid_flutter_sdk/common/package_manager/package_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/discovery/consts.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/discovery/disclose.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/discovery/query.dart';

/// DiscoveryProtocolOptions contains options for DiscoveryProtocolHandler
class DiscoveryProtocolOptions {
  final IPackageManager packageManager;
  final List<Iden3MessageType>? protocols;
  final List<String>? goalCodes;
  final List<String>? headers;

  const DiscoveryProtocolOptions({
    required this.packageManager,
    this.protocols,
    this.goalCodes,
    this.headers,
  });
}

/// Options to pass to discovery-protocol handler
class DiscoveryProtocolHandlerOptions extends BasicHandlerOptions {
  final DateTime? disclosureExpiresDate;

  DiscoveryProtocolHandlerOptions({
    this.disclosureExpiresDate,
    super.allowExpiredMessages,
    super.messageProvingMethodAlg,
    super.headers,
  });
}

/// Interface for handling discovery protocol messages
abstract interface class IDiscoveryProtocolHandler {
  /// Handle discovery query message
  ///
  /// [message] - discover feature queries message
  /// [opts] - discover feature handle options
  /// Returns a [Future] that resolves to [DiscoverFeatureDiscloseMessage]
  Future<DiscoverFeatureDiscloseMessage> handleDiscoveryQuery(
    DiscoverFeatureQueriesMessage message,
    DiscoveryProtocolHandlerOptions? opts,
  );
}

class DiscoveryProtocolHandler extends AbstractMessageHandler
    implements IDiscoveryProtocolHandler, IProtocolMessageHandler {
  final DiscoveryProtocolOptions _options;

  static const _defaultHeaders = [
    'id',
    'typ',
    'type',
    'thid',
    'body',
    'from',
    'to',
    'created_time',
    'expires_time',
  ];

  DiscoveryProtocolHandler(DiscoveryProtocolOptions options)
    : _options = options.headers != null
          ? options
          : DiscoveryProtocolOptions(
              packageManager: options.packageManager,
              protocols: options.protocols,
              goalCodes: options.goalCodes,
              headers: _defaultHeaders,
            ),
      super();

  @override
  Future<Iden3Message?> handle(
    Iden3Message message,
    BasicHandlerOptions? context,
  ) {
    if (message is DiscoverFeatureQueriesMessage) {
      return handleDiscoveryQuery(
        message,
        context as DiscoveryProtocolHandlerOptions?,
      );
    }
    return super.handle(message, context);
  }

  @override
  Future<DiscoverFeatureDiscloseMessage> handleDiscoveryQuery(
    DiscoverFeatureQueriesMessage message,
    DiscoveryProtocolHandlerOptions? opts,
  ) async {
    if (opts?.allowExpiredMessages != true) {
      verifyExpiresTime(message);
    }

    final disclosures = <DiscoverFeatureDisclosure>[];
    for (final query in message.body.queries) {
      final disclosure = handleQuery(query);
      disclosures.addAll(disclosure);
    }

    final expiresDate = opts?.disclosureExpiresDate;

    return createDiscoveryFeatureDiscloseMessage(
      disclosures,
      to: message.from,
      from: message.to,
      thid: message.thid,
      expiresTime: expiresDate != null ? getUnixTimestamp(expiresDate) : null,
    );
  }

  List<DiscoverFeatureDisclosure> handleQuery(DiscoverFeatureQuery query) {
    final List<DiscoverFeatureDisclosure> result;

    switch (query.featureType) {
      case DiscoveryProtocolFeatureType.accept:
        result = _handleAcceptQuery();
        break;
      case DiscoveryProtocolFeatureType.protocol:
        result = _handleProtocolQuery();
        break;
      case DiscoveryProtocolFeatureType.goalCode:
        result = _handleGoalCodeQuery();
        break;
      case DiscoveryProtocolFeatureType.header:
        result = _handleHeaderQuery();
        break;
      default:
        result = [];
        break;
    }

    return _handleMatch(result, query.match);
  }

  List<DiscoverFeatureDisclosure> _handleAcceptQuery() {
    final acceptProfiles = _options.packageManager.getSupportedProfiles();
    return acceptProfiles
        .map(
          (profile) => DiscoverFeatureDisclosure(
            featureType: DiscoveryProtocolFeatureType.accept,
            id: profile,
          ),
        )
        .toList();
  }

  List<DiscoverFeatureDisclosure> _handleProtocolQuery() {
    return _options.protocols
            ?.map(
              (protocol) => DiscoverFeatureDisclosure(
                featureType: DiscoveryProtocolFeatureType.protocol,
                id: protocol.type,
              ),
            )
            .toList() ??
        [];
  }

  List<DiscoverFeatureDisclosure> _handleGoalCodeQuery() {
    return _options.goalCodes
            ?.map(
              (goalCode) => DiscoverFeatureDisclosure(
                featureType: DiscoveryProtocolFeatureType.goalCode,
                id: goalCode,
              ),
            )
            .toList() ??
        [];
  }

  List<DiscoverFeatureDisclosure> _handleHeaderQuery() {
    return _options.headers
            ?.map(
              (header) => DiscoverFeatureDisclosure(
                featureType: DiscoveryProtocolFeatureType.header,
                id: header,
              ),
            )
            .toList() ??
        [];
  }

  List<DiscoverFeatureDisclosure> _handleMatch(
    List<DiscoverFeatureDisclosure> disclosures,
    String? match,
  ) {
    if (match == null || match == '*') {
      return disclosures;
    }
    final regExp = _wildcardToRegExp(match);
    return disclosures
        .where((disclosure) => regExp.hasMatch(disclosure.id))
        .toList();
  }

  RegExp _wildcardToRegExp(String match) {
    // Escape special regex characters, then replace `*` with `.*`
    final regexPattern = match
        .replaceAllMapped(RegExp(r'[.+^${}()|[\]\\]'), (m) => '\\${m.group(0)}')
        .replaceAll('*', '.*');
    return RegExp('^$regexPattern\$');
  }
}

DiscoverFeatureDiscloseMessage createDiscoveryFeatureDiscloseMessage(
  List<DiscoverFeatureDisclosure> disclosures, {
  String? from,
  String? to,
  String? thid,
  int? expiresTime,
}) {
  return DiscoverFeatureDiscloseMessage(
    typ: messageTypePlain,
    thid: thid,
    body: DiscoverFeatureDiscloseMessageBody(disclosures: disclosures),
    from: from,
    to: to,
    createdTime: getUnixTimestamp(DateTime.now()),
    expiresTime: expiresTime,
    attachments: [],
  );
}
