import 'revocation_status_issuer.dart';
import 'revocation_status_mtp.dart';

class RevocationStatus {
  final RevocationStatusIssuer? issuer;
  final RevocationStatusMtp? mtp;
  final Map<String, dynamic>? mtpRaw;

  RevocationStatus({this.issuer, this.mtp, this.mtpRaw});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [RevocationStatus]
  factory RevocationStatus.fromJson(Map<String, dynamic> json) {
    RevocationStatusIssuer? issuer;
    RevocationStatusMtp? mtp;
    Map<String, dynamic>? mtpRaw;
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
    try {
      mtpRaw = json['mtp'];
    } catch (e) {
      mtpRaw = null;
    }

    return RevocationStatus(
      issuer: issuer,
      mtp: mtp,
      mtpRaw: mtpRaw,
    );
  }

  Map<String, dynamic> toJson() => {
        'issuer': issuer!.toJson(),
        'mtp': mtp!.toJson(),
      };
}
