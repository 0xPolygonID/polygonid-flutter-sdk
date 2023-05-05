class TreeStateEntity {
  final String state;
  final String claimsTreeRoot;
  final String revocationTreeRoot;
  final String rootOfRoots;

  TreeStateEntity(
      {required this.state,
      required this.claimsTreeRoot,
      required this.revocationTreeRoot,
      required this.rootOfRoots});

  @override
  String toString() =>
      "[TreeStateEntity] {state: $state, claimsTreeRoot: $claimsTreeRoot, revocationTreeRoot: $revocationTreeRoot, rootOfRoots: $rootOfRoots}";

  @override
  Map<String, dynamic> toJson() => {
        'state': state,
        'claimsTreeRoot': claimsTreeRoot,
        'revocationTreeRoot': revocationTreeRoot,
        'rootOfRoots': rootOfRoots,
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TreeStateEntity &&
          runtimeType == other.runtimeType &&
          state == other.state &&
          claimsTreeRoot == other.claimsTreeRoot &&
          revocationTreeRoot == other.revocationTreeRoot &&
          rootOfRoots == other.rootOfRoots;

  @override
  int get hashCode => runtimeType.hashCode;
}
