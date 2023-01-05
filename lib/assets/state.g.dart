// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint8","name":"version","type":"uint8"}],"name":"Initialized","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"blockN","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"timestamp","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"state","type":"uint256"}],"name":"StateUpdated","type":"event"},{"inputs":[],"name":"ID_HISTORY_RETURN_LIMIT","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"getGISTProof","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[32]","name":"siblings","type":"uint256[32]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct Smt.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"blockNumber","type":"uint256"}],"name":"getGISTProofByBlock","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[32]","name":"siblings","type":"uint256[32]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct Smt.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"root","type":"uint256"}],"name":"getGISTProofByRoot","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[32]","name":"siblings","type":"uint256[32]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct Smt.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"timestamp","type":"uint256"}],"name":"getGISTProofByTime","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"bool","name":"existence","type":"bool"},{"internalType":"uint256[32]","name":"siblings","type":"uint256[32]"},{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bool","name":"auxExistence","type":"bool"},{"internalType":"uint256","name":"auxIndex","type":"uint256"},{"internalType":"uint256","name":"auxValue","type":"uint256"}],"internalType":"struct Smt.Proof","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getGISTRoot","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"start","type":"uint256"},{"internalType":"uint256","name":"length","type":"uint256"}],"name":"getGISTRootHistory","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"uint256","name":"replacedByRoot","type":"uint256"},{"internalType":"uint256","name":"createdAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"replacedAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"createdAtBlock","type":"uint256"},{"internalType":"uint256","name":"replacedAtBlock","type":"uint256"}],"internalType":"struct Smt.RootInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getGISTRootHistoryLength","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"root","type":"uint256"}],"name":"getGISTRootInfo","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"uint256","name":"replacedByRoot","type":"uint256"},{"internalType":"uint256","name":"createdAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"replacedAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"createdAtBlock","type":"uint256"},{"internalType":"uint256","name":"replacedAtBlock","type":"uint256"}],"internalType":"struct Smt.RootInfo","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"blockNumber","type":"uint256"}],"name":"getGISTRootInfoByBlock","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"uint256","name":"replacedByRoot","type":"uint256"},{"internalType":"uint256","name":"createdAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"replacedAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"createdAtBlock","type":"uint256"},{"internalType":"uint256","name":"replacedAtBlock","type":"uint256"}],"internalType":"struct Smt.RootInfo","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"timestamp","type":"uint256"}],"name":"getGISTRootInfoByTime","outputs":[{"components":[{"internalType":"uint256","name":"root","type":"uint256"},{"internalType":"uint256","name":"replacedByRoot","type":"uint256"},{"internalType":"uint256","name":"createdAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"replacedAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"createdAtBlock","type":"uint256"},{"internalType":"uint256","name":"replacedAtBlock","type":"uint256"}],"internalType":"struct Smt.RootInfo","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"getStateInfoById","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"state","type":"uint256"},{"internalType":"uint256","name":"replacedByState","type":"uint256"},{"internalType":"uint256","name":"createdAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"replacedAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"createdAtBlock","type":"uint256"},{"internalType":"uint256","name":"replacedAtBlock","type":"uint256"}],"internalType":"struct StateV2.StateInfo","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"state","type":"uint256"}],"name":"getStateInfoByState","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"state","type":"uint256"},{"internalType":"uint256","name":"replacedByState","type":"uint256"},{"internalType":"uint256","name":"createdAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"replacedAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"createdAtBlock","type":"uint256"},{"internalType":"uint256","name":"replacedAtBlock","type":"uint256"}],"internalType":"struct StateV2.StateInfo","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"startIndex","type":"uint256"},{"internalType":"uint256","name":"length","type":"uint256"}],"name":"getStateInfoHistoryById","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"state","type":"uint256"},{"internalType":"uint256","name":"replacedByState","type":"uint256"},{"internalType":"uint256","name":"createdAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"replacedAtTimestamp","type":"uint256"},{"internalType":"uint256","name":"createdAtBlock","type":"uint256"},{"internalType":"uint256","name":"replacedAtBlock","type":"uint256"}],"internalType":"struct StateV2.StateInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"getStateInfoHistoryLengthById","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getVerifier","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"idExists","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"contract IVerifier","name":"verifierContractAddr","type":"address"}],"name":"initialize","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newVerifierAddr","type":"address"}],"name":"setVerifier","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"state","type":"uint256"}],"name":"stateExists","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"oldState","type":"uint256"},{"internalType":"uint256","name":"newState","type":"uint256"},{"internalType":"bool","name":"isOldStateGenesis","type":"bool"},{"internalType":"uint256[2]","name":"a","type":"uint256[2]"},{"internalType":"uint256[2][2]","name":"b","type":"uint256[2][2]"},{"internalType":"uint256[2]","name":"c","type":"uint256[2]"}],"name":"transitState","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
  'State',
);

class State extends _i1.GeneratedContract {
  State({
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
  Future<BigInt> ID_HISTORY_RETURN_LIMIT({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, 'eaa6b26c'));
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
  Future<dynamic> getGISTProof(
    BigInt id, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '3025bb8c'));
    final params = [id];
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
  Future<dynamic> getGISTProofByBlock(
    BigInt id,
    BigInt blockNumber, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '046ff140'));
    final params = [
      id,
      blockNumber,
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
  Future<dynamic> getGISTProofByRoot(
    BigInt id,
    BigInt root, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'e12a36c0'));
    final params = [
      id,
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
  Future<dynamic> getGISTProofByTime(
    BigInt id,
    BigInt timestamp, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'd51afebf'));
    final params = [
      id,
      timestamp,
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
  Future<BigInt> getGISTRoot({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '2439e3a6'));
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
  Future<List<dynamic>> getGISTRootHistory(
    BigInt start,
    BigInt length, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '2f7670e4'));
    final params = [
      start,
      length,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getGISTRootHistoryLength({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, 'dccbd57a'));
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
  Future<dynamic> getGISTRootInfo(
    BigInt root, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '7c1a66de'));
    final params = [root];
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
  Future<dynamic> getGISTRootInfoByBlock(
    BigInt blockNumber, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '5845e530'));
    final params = [blockNumber];
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
  Future<dynamic> getGISTRootInfoByTime(
    BigInt timestamp, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '0ef6e65b'));
    final params = [timestamp];
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
  Future<dynamic> getStateInfoById(
    BigInt id, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, 'b4bdea55'));
    final params = [id];
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
  Future<dynamic> getStateInfoByState(
    BigInt state, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, '3622b0bc'));
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
  Future<List<dynamic>> getStateInfoHistoryById(
    BigInt id,
    BigInt startIndex,
    BigInt length, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, 'e99858fe'));
    final params = [
      id,
      startIndex,
      length,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getStateInfoHistoryLengthById(
    BigInt id, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '676d5b5a'));
    final params = [id];
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
  Future<_i1.EthereumAddress> getVerifier({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '46657fe9'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> idExists(
    BigInt id, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, '0b8a295a'));
    final params = [id];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> initialize(
    _i1.EthereumAddress verifierContractAddr, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, 'c4d66de8'));
    final params = [verifierContractAddr];
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
  Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, '8da5cb5b'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> renounceOwnership({
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, '715018a6'));
    final params = [];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setVerifier(
    _i1.EthereumAddress newVerifierAddr, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[20];
    assert(checkSignature(function, '5437988d'));
    final params = [newVerifierAddr];
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
  Future<bool> stateExists(
    BigInt state, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[21];
    assert(checkSignature(function, '08fd3b76'));
    final params = [state];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> transferOwnership(
    _i1.EthereumAddress newOwner, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[22];
    assert(checkSignature(function, 'f2fde38b'));
    final params = [newOwner];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> transitState(
    BigInt id,
    BigInt oldState,
    BigInt newState,
    bool isOldStateGenesis,
    List<BigInt> a,
    List<List<BigInt>> b,
    List<BigInt> c, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[23];
    assert(checkSignature(function, '28f88a65'));
    final params = [
      id,
      oldState,
      newState,
      isOldStateGenesis,
      a,
      b,
      c,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all Initialized events emitted by this contract.
  Stream<Initialized> initializedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Initialized');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return Initialized(decoded);
    });
  }

  /// Returns a live stream of all OwnershipTransferred events emitted by this contract.
  Stream<OwnershipTransferred> ownershipTransferredEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('OwnershipTransferred');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return OwnershipTransferred(decoded);
    });
  }

  /// Returns a live stream of all StateUpdated events emitted by this contract.
  Stream<StateUpdated> stateUpdatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('StateUpdated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return StateUpdated(decoded);
    });
  }
}

class Initialized {
  Initialized(List<dynamic> response) : version = (response[0] as BigInt);

  final BigInt version;
}

class OwnershipTransferred {
  OwnershipTransferred(List<dynamic> response)
      : previousOwner = (response[0] as _i1.EthereumAddress),
        newOwner = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress previousOwner;

  final _i1.EthereumAddress newOwner;
}

class StateUpdated {
  StateUpdated(List<dynamic> response)
      : id = (response[0] as BigInt),
        blockN = (response[1] as BigInt),
        timestamp = (response[2] as BigInt),
        state = (response[3] as BigInt);

  final BigInt id;

  final BigInt blockN;

  final BigInt timestamp;

  final BigInt state;
}
