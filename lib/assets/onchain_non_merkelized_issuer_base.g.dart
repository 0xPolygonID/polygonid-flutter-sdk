// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"name":"CREDENTIAL_ADAPTER_VERSION","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"claimIndexHash","type":"uint256"}],"name":"getClaimProof","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct SmtLib.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"claimIndexHash","type":"uint256"},{"internalType":"uint256","name":"root","type":"uint256"}],"name":"getClaimProofByRoot","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct SmtLib.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"claimIndexHash","type":"uint256"}],"name":"getClaimProofWithStateInfo","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct SmtLib.Proof","name":"","type":"tuple"},{"components":[{"internalType":"uint256","name":"state","type":"uint256"},{"internalType":"uint256","name":"claimsRoot","type":"uint256"},{"internalType":"uint256","name":"revocationsRoot","type":"uint256"},{"internalType":"uint256","name":"rootsRoot","type":"uint256"}],"internalType":"struct IdentityLib.StateInfo","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getClaimsTreeRoot","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_userId","type":"uint256"},{"internalType":"uint256","name":"_credentialId","type":"uint256"}],"name":"getCredential","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string[]","name":"context","type":"string[]"},{"internalType":"string","name":"_type","type":"string"},{"internalType":"uint64","name":"issuanceDate","type":"uint64"},{"components":[{"internalType":"string","name":"id","type":"string"},{"internalType":"string","name":"_type","type":"string"}],"internalType":"struct INonMerklizedIssuer.CredentialSchema","name":"credentialSchema","type":"tuple"},{"components":[{"internalType":"string","name":"id","type":"string"},{"internalType":"string","name":"_type","type":"string"}],"internalType":"struct INonMerklizedIssuer.DisplayMethod","name":"displayMethod","type":"tuple"}],"internalType":"struct INonMerklizedIssuer.CredentialData","name":"","type":"tuple"},{"internalType":"uint256[8]","name":"","type":"uint256[8]"},{"components":[{"internalType":"string","name":"key","type":"string"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bytes","name":"rawValue","type":"bytes"}],"internalType":"struct INonMerklizedIssuer.SubjectField[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getCredentialAdapterVersion","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"pure","type":"function"},{"inputs":[],"name":"getId","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getIsOldStateGenesis","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getLatestPublishedClaimsRoot","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getLatestPublishedRevocationsRoot","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getLatestPublishedRootsRoot","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getLatestPublishedState","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint64","name":"revocationNonce","type":"uint64"}],"name":"getRevocationProof","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct SmtLib.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint64","name":"revocationNonce","type":"uint64"},{"internalType":"uint256","name":"root","type":"uint256"}],"name":"getRevocationProofByRoot","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct SmtLib.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint64","name":"revocationNonce","type":"uint64"}],"name":"getRevocationProofWithStateInfo","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct SmtLib.Proof","name":"","type":"tuple"},{"components":[{"internalType":"uint256","name":"state","type":"uint256"},{"internalType":"uint256","name":"claimsRoot","type":"uint256"},{"internalType":"uint256","name":"revocationsRoot","type":"uint256"},{"internalType":"uint256","name":"rootsRoot","type":"uint256"}],"internalType":"struct IdentityLib.StateInfo","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint64","name":"nonce","type":"uint64"}],"name":"getRevocationStatus","outputs":[{"components":[{"components":[{"internalType":"uint256","name":"state","type":"uint256"},{"internalType":"uint256","name":"claimsTreeRoot","type":"uint256"},{"internalType":"uint256","name":"revocationTreeRoot","type":"uint256"},{"internalType":"uint256","name":"rootOfRoots","type":"uint256"}],"internalType":"struct IOnchainCredentialStatusResolver.IdentityStateRoots","name":"issuer","type":"tuple"},{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct IOnchainCredentialStatusResolver.Proof","name":"mtp","type":"tuple"}],"internalType":"struct IOnchainCredentialStatusResolver.CredentialStatus","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"state","type":"uint256"},{"internalType":"uint64","name":"nonce","type":"uint64"}],"name":"getRevocationStatusByIdAndState","outputs":[{"components":[{"components":[{"internalType":"uint256","name":"state","type":"uint256"},{"internalType":"uint256","name":"claimsTreeRoot","type":"uint256"},{"internalType":"uint256","name":"revocationTreeRoot","type":"uint256"},{"internalType":"uint256","name":"rootOfRoots","type":"uint256"}],"internalType":"struct IOnchainCredentialStatusResolver.IdentityStateRoots","name":"issuer","type":"tuple"},{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct IOnchainCredentialStatusResolver.Proof","name":"mtp","type":"tuple"}],"internalType":"struct IOnchainCredentialStatusResolver.CredentialStatus","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getRevocationsTreeRoot","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"rootsTreeRoot","type":"uint256"}],"name":"getRootProof","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct SmtLib.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"claimsTreeRoot","type":"uint256"},{"internalType":"uint256","name":"root","type":"uint256"}],"name":"getRootProofByRoot","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct SmtLib.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"rootsTreeRoot","type":"uint256"}],"name":"getRootProofWithStateInfo","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[]","name":"siblings","type":"uint256[]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct SmtLib.Proof","name":"","type":"tuple"},{"components":[{"internalType":"uint256","name":"state","type":"uint256"},{"internalType":"uint256","name":"claimsRoot","type":"uint256"},{"internalType":"uint256","name":"revocationsRoot","type":"uint256"},{"internalType":"uint256","name":"rootsRoot","type":"uint256"}],"internalType":"struct IdentityLib.StateInfo","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"state","type":"uint256"}],"name":"getRootsByState","outputs":[{"components":[{"internalType":"uint256","name":"claimsRoot","type":"uint256"},{"internalType":"uint256","name":"revocationsRoot","type":"uint256"},{"internalType":"uint256","name":"rootsRoot","type":"uint256"}],"internalType":"struct IdentityLib.Roots","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getRootsTreeRoot","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getSmtDepth","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"pure","type":"function"},{"inputs":[{"internalType":"uint256","name":"_userId","type":"uint256"}],"name":"getUserCredentialIds","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_stateContractAddr","type":"address"}],"name":"initialize","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"}]',
  'Onchain_non_merkelized_issuer_base',
);

class Onchain_non_merkelized_issuer_base extends _i1.GeneratedContract {
  Onchain_non_merkelized_issuer_base({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<String> CREDENTIAL_ADAPTER_VERSION({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, 'de353972'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as String);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getClaimProof(
    BigInt claimIndexHash, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'b57a40cb'));
    final params = [claimIndexHash];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getClaimProofByRoot(
    BigInt claimIndexHash,
    BigInt root, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '310d0d5b'));
    final params = [
      claimIndexHash,
      root,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetClaimProofWithStateInfo> getClaimProofWithStateInfo(
    BigInt claimIndexHash, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'b37feda4'));
    final params = [claimIndexHash];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetClaimProofWithStateInfo(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getClaimsTreeRoot({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '3df432fc'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetCredential> getCredential(
    BigInt _userId,
    BigInt _credentialId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '37c1d9ff'));
    final params = [
      _userId,
      _credentialId,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetCredential(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<String> getCredentialAdapterVersion({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '09cb9b62'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as String);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getId({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '5d1ca631'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> getIsOldStateGenesis({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, 'f84c7c1e'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getLatestPublishedClaimsRoot({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '523b8136'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getLatestPublishedRevocationsRoot(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '9674cfa4'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getLatestPublishedRootsRoot({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, 'c6365a3b'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getLatestPublishedState({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, '3d59ec60'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRevocationProof(
    BigInt revocationNonce, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '26485063'));
    final params = [revocationNonce];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRevocationProofByRoot(
    BigInt revocationNonce,
    BigInt root, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, 'e26ecb0b'));
    final params = [
      revocationNonce,
      root,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetRevocationProofWithStateInfo> getRevocationProofWithStateInfo(
    BigInt revocationNonce, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '0033058d'));
    final params = [revocationNonce];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetRevocationProofWithStateInfo(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRevocationStatus(
    BigInt id,
    BigInt nonce, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, '110c96a7'));
    final params = [
      id,
      nonce,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRevocationStatusByIdAndState(
    BigInt id,
    BigInt state,
    BigInt nonce, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, 'aad72921'));
    final params = [
      id,
      state,
      nonce,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getRevocationsTreeRoot({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, '01c85c77'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRootProof(
    BigInt rootsTreeRoot, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, 'c1e32733'));
    final params = [rootsTreeRoot];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRootProofByRoot(
    BigInt claimsTreeRoot,
    BigInt root, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[20];
    assert(checkSignature(function, '2d5c4f25'));
    final params = [
      claimsTreeRoot,
      root,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetRootProofWithStateInfo> getRootProofWithStateInfo(
    BigInt rootsTreeRoot, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[21];
    assert(checkSignature(function, '443d7534'));
    final params = [rootsTreeRoot];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetRootProofWithStateInfo(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRootsByState(
    BigInt state, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[22];
    assert(checkSignature(function, 'b8db6871'));
    final params = [state];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getRootsTreeRoot({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[23];
    assert(checkSignature(function, 'da68a0b1'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getSmtDepth({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[24];
    assert(checkSignature(function, '3f0c6648'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<BigInt>> getUserCredentialIds(
    BigInt _userId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[25];
    assert(checkSignature(function, '668d0bd4'));
    final params = [_userId];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<BigInt>();
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> initialize(
    _i1.EthereumAddress _stateContractAddr, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[26];
    assert(checkSignature(function, 'c4d66de8'));
    final params = [_stateContractAddr];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> supportsInterface(
    _i2.Uint8List interfaceId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[27];
    assert(checkSignature(function, '01ffc9a7'));
    final params = [interfaceId];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }
}

class GetClaimProofWithStateInfo {
  GetClaimProofWithStateInfo(List<dynamic> response)
      : var1 = (response[0] as dynamic),
        var2 = (response[1] as dynamic);

  final dynamic var1;

  final dynamic var2;
}

class GetCredential {
  GetCredential(List<dynamic> response)
      : var1 = (response[0] as dynamic),
        var2 = (response[1] as List<dynamic>).cast<BigInt>(),
        var3 = (response[2] as List<dynamic>).cast<dynamic>();

  final dynamic var1;

  final List<BigInt> var2;

  final List<dynamic> var3;
}

class GetRevocationProofWithStateInfo {
  GetRevocationProofWithStateInfo(List<dynamic> response)
      : var1 = (response[0] as dynamic),
        var2 = (response[1] as dynamic);

  final dynamic var1;

  final dynamic var2;
}

class GetRootProofWithStateInfo {
  GetRootProofWithStateInfo(List<dynamic> response)
      : var1 = (response[0] as dynamic),
        var2 = (response[1] as dynamic);

  final dynamic var1;

  final dynamic var2;
}
