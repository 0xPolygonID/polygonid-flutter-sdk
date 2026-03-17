import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/native_polygonidcore.dart';

class PolygonIdSDKException implements Exception {
  final dynamic error;
  final String errorMessage;

  PolygonIdSDKException({
    this.error,
    required this.errorMessage,
  });

  @override
  String toString() {
    return errorMessage;
  }
}

class CoreLibraryException extends PolygonIdSDKException {
  final String coreLibraryName;
  final String methodName;
  final PLGNStatusCode? statusCode;

  CoreLibraryException({
    required this.coreLibraryName,
    required this.methodName,
    required super.errorMessage,
    this.statusCode,
    super.error,
  });

  @override
  String toString() {
    return "[$coreLibraryName] [$methodName] [$statusCode] $errorMessage";
  }
}

/// Thrown when the native core library reports a credential status resolve
/// error (status codes 2–11).
///
/// These cover user/issuer credential status extraction, resolve, merkle-tree
/// build, merkle-tree state, and revocation errors.
class CredentialStatusResolveException extends CoreLibraryException {
  CredentialStatusResolveException({
    required super.coreLibraryName,
    required super.methodName,
    required super.errorMessage,
    required super.statusCode,
    super.error,
  });

  @override
  String toString() {
    return "CredentialStatusResolveException: [$coreLibraryName] [$methodName] [$statusCode] $errorMessage";
  }
}

