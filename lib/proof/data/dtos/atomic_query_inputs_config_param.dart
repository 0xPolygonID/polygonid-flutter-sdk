class AtomicQueryInputsConfigParam {
  final String ethereumUrl;
  final String stateContractAddr;
  final String ipfsNodeURL;

  AtomicQueryInputsConfigParam({
    required this.ethereumUrl,
    required this.stateContractAddr,
    required this.ipfsNodeURL,
  });

  Map<String, dynamic> toJson() => {
        "ethereumUrl": ethereumUrl,
        "stateContractAddr": stateContractAddr,
        "IPFSNodeURL": ipfsNodeURL,
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  factory AtomicQueryInputsConfigParam.fromJson(Map<String, dynamic> json) {
    return AtomicQueryInputsConfigParam(
      ethereumUrl: json['ethereumUrl'],
      stateContractAddr: json['stateContractAddr'],
      ipfsNodeURL: json['IPFSNodeURL'],
    );
  }
}
