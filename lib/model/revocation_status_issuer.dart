class RevocationStatusIssuer {
  final String? state;
  final String? claimsTreeRoot;
  final String? revocationTreeRoot;
  final String? rootOfRoots;

  RevocationStatusIssuer(
      {this.state, this.claimsTreeRoot, this.revocationTreeRoot, this.rootOfRoots});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [RevocationStatusIssuer]
  factory RevocationStatusIssuer.fromJson(Map<String, dynamic> json) {
    return RevocationStatusIssuer(
      state: json['state'],
      claimsTreeRoot: json['claims_tree_root'],
      revocationTreeRoot: json['revocation_tree_root'],
      rootOfRoots: json['root_of_roots'],
    );
  }

  Map<String, String> toJson() => {
        'state': state.toString(),
        'claims_tree_root': claimsTreeRoot.toString(),
        'revocation_tree_root': revocationTreeRoot.toString(),
        'root_of_roots': rootOfRoots.toString(),
      };
}
