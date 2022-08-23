class NodeAux {
  final String? key;
  final String? value;

  // TODO: add NodeAux

  NodeAux({this.key, this.value});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [NodeAux]
  factory NodeAux.fromJson(Map<String, dynamic> json) {
    return NodeAux(
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, String> toJson() => {
        'key': key.toString(),
        'value': value.toString(),
      };
}
