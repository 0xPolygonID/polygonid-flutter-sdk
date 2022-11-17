class HashEntity {
  final String data;

  HashEntity({required this.data});

  @override
  String toString() => "[HashEntity] {data: $data}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HashEntity &&
          runtimeType == other.runtimeType &&
          data.toString() == other.data.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
