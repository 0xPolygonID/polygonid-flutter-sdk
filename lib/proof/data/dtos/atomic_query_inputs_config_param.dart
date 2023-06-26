class AtomicQueryInputsConfigParam {
  final String ethereumUrl;
  final String stateContractAddr;

  AtomicQueryInputsConfigParam({
    required this.ethereumUrl,
    required this.stateContractAddr,
  });

  Map<String, dynamic> toJson() => {
        "ethereumUrl": ethereumUrl,
        "stateContractAddr": stateContractAddr,
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  factory AtomicQueryInputsConfigParam.fromJson(Map<String, dynamic> json) {
    return AtomicQueryInputsConfigParam(
      ethereumUrl: json['ethereumUrl'],
      stateContractAddr: json['stateContractAddr'],
    );
  }
}
