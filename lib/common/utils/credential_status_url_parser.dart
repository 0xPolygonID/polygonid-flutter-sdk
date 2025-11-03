class CredentialStatusUrlParts {
  final String raw;
  final String did; // full did:...:identifier
  final String method; // polygonid
  final String protocol; // polygon
  final String network; // mumbai
  final String identifier; // 2qCU58...
  final String pathSegment; // credentialStatus
  final BigInt? revocationNonce;
  final String? contractChainId; // 80001
  final String? contractAddress; // 0x2fCE...
  final BigInt? state;

  CredentialStatusUrlParts({
    required this.raw,
    required this.did,
    required this.method,
    required this.protocol,
    required this.network,
    required this.identifier,
    required this.pathSegment,
    required this.revocationNonce,
    required this.contractChainId,
    required this.contractAddress,
    required this.state,
  });

  @override
  String toString() {
    return 'CredentialStatusUrlParts(did=$did, method=$method, protocol=$protocol, network=$network, identifier=$identifier, path=$pathSegment, revocationNonce=$revocationNonce, contractChainId=$contractChainId, contractAddress=$contractAddress, state=$state)';
  }
}

class CredentialStatusUrlParser {
  static CredentialStatusUrlParts parse(String input) {
    final raw = input.trim();
    final qIndex = raw.indexOf('?');
    final base = qIndex == -1 ? raw : raw.substring(0, qIndex);
    final query = qIndex == -1 ? '' : raw.substring(qIndex + 1);

    // Split base into DID part and path
    final slashIndex = base.indexOf('/');
    if (slashIndex == -1) {
      throw FormatException('Missing path segment after DID');
    }
    final didPart = base.substring(0, slashIndex);
    final pathSegment = base.substring(slashIndex + 1);

    final didSegments = didPart.split(':');
    if (didSegments.length < 5 || didSegments[0] != 'did') {
      throw FormatException('Invalid DID portion');
    }
    final method = didSegments[1];
    final protocol = didSegments[2];
    final network = didSegments[3];
    final identifier = didSegments
        .sublist(4)
        .join(':'); // in case identifier itself contains :
    final fullDid = 'did:$method:$protocol:$network:$identifier';

    BigInt? revocationNonce;
    String? contractChainId;
    String? contractAddress;
    BigInt? state;

    if (query.isNotEmpty) {
      for (final pair in query.split('&')) {
        if (pair.isEmpty) continue;
        final eqIndex = pair.indexOf('=');
        final key = eqIndex == -1 ? pair : pair.substring(0, eqIndex);
        final value = eqIndex == -1 ? '' : pair.substring(eqIndex + 1);
        switch (key) {
          case 'revocationNonce':
            revocationNonce = BigInt.parse(value);
            break;
          case 'contractAddress':
            final parts = value.split(':');
            if (parts.length == 2) {
              contractChainId = parts[0];
              contractAddress = parts[1];
            } else {
              contractAddress = value;
            }
            break;
          case 'state':
            state = BigInt.parse(value, radix: 16);
            break;
        }
      }
    }

    return CredentialStatusUrlParts(
      raw: raw,
      did: fullDid,
      method: method,
      protocol: protocol,
      network: network,
      identifier: identifier,
      pathSegment: pathSegment,
      revocationNonce: revocationNonce,
      contractChainId: contractChainId!,
      contractAddress: contractAddress!,
      state: state,
    );
  }
}
