import 'dart:typed_data';

import 'package:bip39/bip39.dart';
import 'package:privadoid_sdk/data/data_sources/local_identity_data_source.dart';
import 'package:privadoid_sdk/domain/repositories/identity_repository.dart';

import '../../domain/common/tuples.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../privadoid_sdk.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final LocalIdentityDataSource _localIdentityDataSource;

  IdentityRepositoryImpl(this._localIdentityDataSource);

  /// Get a private key and an identity from a key
  /// or create new ones if seed phrase is null
  @override
  Future<Pair<String, String>> getIdentity({String? key}) async {
    return _localIdentityDataSource
        .generatePrivateKey(
          privateKey: key != null ? Uint8List.fromList(key.codeUnits) : null,
        )
        .then((privateKey) => _localIdentityDataSource
            .generateIdentifier(privateKey: privateKey)
            .then((identifier) => Pair(privateKey, identifier)))
        .catchError((error) => throw IdentityException(error));
  }

  /// Checks if the seed phrase is valid.
  ///
  /// Throws [InvalidSeedPhraseException] if the seed phrase is not valid.
  @override
  Future<void> checkSeedPhraseValidity({required String seedPhrase}) {
    List<String> normalizedWords = _getNormalizedWords(seedPhrase);

    if (normalizedWords.length == 12) {
      final String normalized = _normalizeSeedPhrase(seedPhrase);
      final String cryptMnemonic = mnemonicToEntropy(normalized);

      if (cryptMnemonic.isNotEmpty) {
        final Uint8List key = Uint8List.fromList(cryptMnemonic.codeUnits);

        // TODO: move this to a DS
        return PrivadoIdSdk.createNewIdentity(privateKey: key)
            .then((privateKey) {
          // All good
          if (privateKey != null && privateKey.isNotEmpty) {
            return;
          }

          throw InvalidSeedPhraseException(seedPhrase);
        });
      }
    }

    return Future.error(InvalidSeedPhraseException(seedPhrase));
  }

  String _normalizeSeedPhrase(String mnemonic) {
    return _getNormalizedWords(mnemonic).join(" ");
  }

  List<String> _getNormalizedWords(String seedPhrase) {
    return seedPhrase
        .split(" ")
        .where((item) => item.trim().isNotEmpty)
        .map((item) => item.trim())
        .toList();
  }
}
