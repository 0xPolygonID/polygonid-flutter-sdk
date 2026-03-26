import 'dart:async';

import 'package:dio/dio.dart';
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
      await registry.register('id', source);
      expect(await registry.resolveCircuit('id'), same(source));
    });

    test('does not call downloader for LocalPathCircuitFileSource', () async {
      var called = false;
      registry.setDownloader(
        (id, url, {forceDownload = false, cancelToken}) async => called = true,
      );
      await registry.register('id', LocalPathCircuitFileSource(directoryPath: '/x'));
      expect(called, isFalse);
    });

    test('does not call downloader when downloadImmediately is false', () async {
      var called = false;
      registry.setDownloader(
        (id, url, {forceDownload = false, cancelToken}) async => called = true,
      );
      await registry.register('id', UrlCircuitFileSource(zipUrl: 'http://x'));
      expect(called, isFalse);
    });

    test('does not call downloader for AssetCircuitFileSource', () async {
      var called = false;
      registry.setDownloader(
        (id, url, {forceDownload = false, cancelToken}) async => called = true,
      );
      await registry.register(
        'id',
        AssetCircuitFileSource(wcdAssetPath: 'assets/circuit.wcd'),
      );
      expect(called, isFalse);
    });

    test('calls downloader with correct circuitId and zipUrl when downloadImmediately=true', () async {
      String? capturedId, capturedUrl;
      registry.setDownloader((id, url, {forceDownload = false, cancelToken}) async {
        capturedId = id;
        capturedUrl = url;
      });
      await registry.register(
        'myCircuit',
        UrlCircuitFileSource(zipUrl: 'http://z.zip', downloadImmediately: true),
      );
      expect(capturedId, 'myCircuit');
      expect(capturedUrl, 'http://z.zip');
    });

    test('forwards forceDownload=false (default) to downloader', () async {
      bool? capturedForce;
      registry.setDownloader(
        (id, url, {forceDownload = false, cancelToken}) async => capturedForce = forceDownload,
      );
      await registry.register(
        'id',
        UrlCircuitFileSource(zipUrl: 'http://x', downloadImmediately: true),
      );
      expect(capturedForce, isFalse);
    });

    test('forwards forceDownload=true to downloader', () async {
      bool? capturedForce;
      registry.setDownloader(
        (id, url, {forceDownload = false, cancelToken}) async => capturedForce = forceDownload,
      );
      await registry.register(
        'id',
        UrlCircuitFileSource(
          zipUrl: 'http://x',
          downloadImmediately: true,
          forceDownload: true,
        ),
      );
      expect(capturedForce, isTrue);
    });

    test('forwards cancelToken to downloader', () async {
      CancelToken? capturedToken;
      registry.setDownloader(
        (id, url, {forceDownload = false, cancelToken}) async => capturedToken = cancelToken,
      );
      final token = CancelToken();
      await registry.register(
        'id',
        UrlCircuitFileSource(zipUrl: 'http://x', downloadImmediately: true),
        cancelToken: token,
      );
      expect(capturedToken, same(token));
    });

    test('does not throw when downloadImmediately=true but no downloader is set', () async {
      await expectLater(
        registry.register(
          'id',
          UrlCircuitFileSource(zipUrl: 'http://x', downloadImmediately: true),
        ),
        completes,
      );
      // Source was still stored
      expect(await registry.resolveCircuit('id'), isNotNull);
    });

    test('awaits downloader before returning', () async {
      final completer = Completer<void>();
      var downloaderFinished = false;
      registry.setDownloader((id, url, {forceDownload = false, cancelToken}) async {
        await completer.future;
        downloaderFinished = true;
      });

      var registerDone = false;
      final registerFuture = registry
          .register('id', UrlCircuitFileSource(zipUrl: 'http://x', downloadImmediately: true))
          .then((_) => registerDone = true);

      // Not yet done — downloader is blocked.
      await Future.microtask(() {});
      expect(downloaderFinished, isFalse);
      expect(registerDone, isFalse);

      completer.complete();
      await registerFuture;
      expect(downloaderFinished, isTrue);
      expect(registerDone, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // unregister
  // ---------------------------------------------------------------------------

  group('unregister', () {
    test('removes a previously registered source', () async {
      await registry.register('id', LocalPathCircuitFileSource(directoryPath: '/x'));
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
      await registry.register('id', source);
      expect(await registry.resolveCircuit('id'), same(source));
    });

    test('does not call resolver when circuit is registered', () async {
      var resolverCalled = false;
      await registry.register('id', LocalPathCircuitFileSource(directoryPath: '/a'));
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
  // setDownloader
  // ---------------------------------------------------------------------------

  group('setDownloader', () {
    test('setting null disables immediate download', () async {
      var called = false;
      registry.setDownloader(
        (id, url, {forceDownload = false, cancelToken}) async => called = true,
      );
      registry.setDownloader(null);
      await registry.register(
        'id',
        UrlCircuitFileSource(zipUrl: 'http://x', downloadImmediately: true),
      );
      expect(called, isFalse);
    });
  });
}
