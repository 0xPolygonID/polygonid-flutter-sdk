import 'package:polygonid_flutter_sdk/model/revocation_status_issuer.dart';
import 'package:polygonid_flutter_sdk/model/revocation_status_mtp.dart';

class RevocationStatus {
  final RevocationStatusIssuer? issuer;
  final RevocationStatusMtp? mtp;

  RevocationStatus({this.issuer, this.mtp});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [RevocationStatus]
  factory RevocationStatus.fromJson(Map<String, dynamic> json) {
    RevocationStatusIssuer? issuer;
    RevocationStatusMtp? mtp;
    try {
      issuer = RevocationStatusIssuer.fromJson(json['issuer']);
    } catch (e) {
      issuer = null;
    }
    try {
      mtp = RevocationStatusMtp.fromJson(json['mtp']);
    } catch (e) {
      mtp = null;
    }
    return RevocationStatus(
      issuer: issuer,
      mtp: mtp,
    );
  }

  Map<String, dynamic> toJson() => {
        'issuer': issuer!.toJson(),
        'mtp': mtp!.toJson(),
      };
}
