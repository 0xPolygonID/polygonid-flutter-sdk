import 'package:json_annotation/json_annotation.dart';

import 'mtp_node_aux.dart';

// @JsonSerializable()
class RevocationStatusMtp {
//  @JsonKey(ignore: true)
  final String? type;
  final bool? existence;
  final List<dynamic>? siblings;
  final NodeAux? nodeAux;

  // TODO: add NodeAux

  RevocationStatusMtp({this.type, this.existence, this.siblings, this.nodeAux});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [RevocationStatusMtp]
  factory RevocationStatusMtp.fromJson(Map<String, dynamic> json) {
    NodeAux? nodeAux;
    try {
      nodeAux = NodeAux.fromJson(json['node_aux']);
    } catch (e) {
      nodeAux = null;
    }

    return RevocationStatusMtp(
      type: json['@type'],
      existence: json['existence'],
      siblings: json['siblings'],
      nodeAux: nodeAux,
    );
  }

  Map<String, dynamic> toJson() => {
        '@type': type?.toString(),
        'existence': existence,
        'siblings': siblings,
        'node_aux': nodeAux?.toJson(),
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);
}
