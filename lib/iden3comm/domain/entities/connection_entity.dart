class ConnectionEntity {
  final String from;
  final String to;
  final List<dynamic> interactions;

  ConnectionEntity({
    required this.from,
    required this.to,
    required this.interactions,
  });

  @override
  String toString() => "[ConnectionEntity] {"
      "from: $from, to: $to, interactions: $interactions}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectionEntity &&
          runtimeType == other.runtimeType &&
          from == other.from &&
          to == other.to &&
          interactions.toString() == other.interactions.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
