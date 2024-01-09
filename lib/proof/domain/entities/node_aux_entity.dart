class NodeAuxEntity {
  final String key;
  final String value;

  NodeAuxEntity({required this.key, required this.value});

  @override
  String toString() => "[NodeAuxEntity] {key: $key, value: $value}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeAuxEntity &&
          runtimeType == other.runtimeType &&
          key.toString() == other.key.toString() &&
          value.toString() == other.value.toString();

  @override
  int get hashCode => runtimeType.hashCode;

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };
}
