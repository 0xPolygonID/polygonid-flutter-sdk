import 'package:equatable/equatable.dart';

/// Represents an identity.
/// An identity is a pair of an identifier and an auth claim.
class Identity extends Equatable {
  final String identifier;
  final String authClaim;

  const Identity({required this.identifier, required this.authClaim});

  @override
  List<Object?> get props => [identifier, authClaim];
}
