import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_file_source.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_registry.dart';

void main() {
  late CircuitRegistry registry;

  setUp(() {
    registry = CircuitRegistry();
  });

  // ---------------------------------------------------------------------------
  // register
  // ---------------------------------------------------------------------------

  group('register', () {
    test('stores the source so resolveCircuit returns it', () async {
      final source = LocalPathCircuitFileSource(directoryPath: '/x');
      registry.register('id', source);
      expect(await registry.resolveCircuit('id'), same(source));
    });

    test('overwrites a previous registration for the same circuitId', () async {
      final first = LocalPathCircuitFileSource(directoryPath: '/a');
      final second = LocalPathCircuitFileSource(directoryPath: '/b');
      registry.register('id', first);
      registry.register('id', second);
      expect(await registry.resolveCircuit('id'), same(second));
    });

    test('registering multiple different ids works independently', () async {
      final s1 = LocalPathCircuitFileSource(directoryPath: '/a');
      final s2 = UrlCircuitFileSource(zipUrl: 'http://b.zip');
      registry.register('id1', s1);
      registry.register('id2', s2);
      expect(await registry.resolveCircuit('id1'), same(s1));
      expect(await registry.resolveCircuit('id2'), same(s2));
    });
  });

  // ---------------------------------------------------------------------------
  // unregister
  // ---------------------------------------------------------------------------

  group('unregister', () {
    test('removes a previously registered source', () async {
      registry.register('id', LocalPathCircuitFileSource(directoryPath: '/x'));
      registry.unregister('id');
      expect(await registry.resolveCircuit('id'), isNull);
    });

    test('does not throw when circuitId is unknown', () {
      expect(() => registry.unregister('unknown'), returnsNormally);
    });
  });

  // ---------------------------------------------------------------------------
  // resolveCircuit
  // ---------------------------------------------------------------------------

  group('resolveCircuit', () {
    test('returns null when no registration and no resolver', () async {
      expect(await registry.resolveCircuit('x'), isNull);
    });

    test('returns the registered source', () async {
      final source = LocalPathCircuitFileSource(directoryPath: '/a');
      registry.register('id', source);
      expect(await registry.resolveCircuit('id'), same(source));
    });

    test('does not call resolver when circuit is registered', () async {
      var resolverCalled = false;
      registry.register('id', LocalPathCircuitFileSource(directoryPath: '/a'));
      registry.setCircuitResolver((_) async {
        resolverCalled = true;
        return null;
      });
      await registry.resolveCircuit('id');
      expect(resolverCalled, isFalse);
    });

    test('falls back to resolver for an unregistered circuit', () async {
      final source = LocalPathCircuitFileSource(directoryPath: '/b');
      registry.setCircuitResolver((id) async => id == 'dynamic' ? source : null);
      expect(await registry.resolveCircuit('dynamic'), same(source));
    });

    test('returns null when resolver returns null', () async {
      registry.setCircuitResolver((_) async => null);
      expect(await registry.resolveCircuit('unknown'), isNull);
    });

    test('returns null after resolver is cleared with setCircuitResolver(null)', () async {
      registry.setCircuitResolver(
        (_) async => LocalPathCircuitFileSource(directoryPath: '/c'),
      );
      registry.setCircuitResolver(null);
      expect(await registry.resolveCircuit('id'), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // setCircuitResolver
  // ---------------------------------------------------------------------------

  group('setCircuitResolver', () {
    test('resolver is called with the correct circuitId', () async {
      String? receivedId;
      registry.setCircuitResolver((id) async {
        receivedId = id;
        return null;
      });
      await registry.resolveCircuit('myCircuit');
      expect(receivedId, 'myCircuit');
    });

    test('resolver result is returned', () async {
      final source = AssetCircuitFileSource(wcdAssetPath: 'assets/c.wcd');
      registry.setCircuitResolver((_) async => source);
      expect(await registry.resolveCircuit('any'), same(source));
    });

    test('replacing resolver replaces the callback', () async {
      registry.setCircuitResolver(
        (_) async => LocalPathCircuitFileSource(directoryPath: '/first'),
      );
      final second = LocalPathCircuitFileSource(directoryPath: '/second');
      registry.setCircuitResolver((_) async => second);
      expect(await registry.resolveCircuit('id'), same(second));
    });
  });
}
