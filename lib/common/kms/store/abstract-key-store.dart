/// KeyStore that allows to import and get keys by alias.
///
/// @abstract
/// @public
/// @class AbstractPrivateKeyStore
abstract class AbstractPrivateKeyStore {
  /// imports key by alias
  ///
  /// @abstract
  /// @param {{ alias: string; key: string }} args - key alias and hex representation
  /// @returns `Promise<void>`
  Future<void> importKey({required String alias, required String key});

  /// get key by alias
  ///
  /// @abstract
  /// @param {{ alias: string }} args -key alias
  /// @returns `Promise<string>`
  Future<String> get({required String alias});
}
