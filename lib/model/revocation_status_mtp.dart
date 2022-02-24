class RevocationStatusMtp {
  final String? type;
  final bool? existence;
  final List<dynamic>? siblings;

  RevocationStatusMtp({this.type, this.existence, this.siblings});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [RevocationStatusMtp]
  factory RevocationStatusMtp.fromJson(Map<String, dynamic> json) {
    return RevocationStatusMtp(
      type: json['@type'],
      existence: json['existence'],
      siblings: json['siblings'],
    );
  }

  Map<String, String> toJson() => {
        '@type': type.toString(),
        'userReference': existence.toString(),
        'siblings': siblings.toString(),
      };
}
