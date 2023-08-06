import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_genesis_state_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/identity_mocks.dart';

import 'get_did_identifier_use_case_test.mocks.dart';

MockIdentityRepository identityRepository = MockIdentityRepository();
MockGetGenesisStateUseCase getGenesisStateUseCase =
    MockGetGenesisStateUseCase();
MockStacktraceStreamManager stacktraceStreamManager =
    MockStacktraceStreamManager();

// Data
GetDidIdentifierParam param = GetDidIdentifierParam(
  privateKey: CommonMocks.privateKey,
  blockchain: CommonMocks.blockchain,
  network: CommonMocks.network,
  profileNonce: CommonMocks.genesisNonce,
);

GetDidIdentifierUseCase useCase = GetDidIdentifierUseCase(
  identityRepository,
  getGenesisStateUseCase,
  stacktraceStreamManager,
);

@GenerateMocks([
  IdentityRepository,
  GetGenesisStateUseCase,
  StacktraceStreamManager,
])
void main() {
  setUp(() {
    reset(identityRepository);
    reset(getGenesisStateUseCase);

    // Given
    when(getGenesisStateUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(IdentityMocks.treeState));
    when(identityRepository.getDidIdentifier(
      blockchain: anyNamed('blockchain'),
      network: anyNamed('network'),
      claimsRoot: anyNamed('claimsRoot'),
      profileNonce: anyNamed('profileNonce'),
    )).thenAnswer((realInvocation) => Future.value(CommonMocks.did));
  });

  test(
    'Given a param, when I call execute, then I expect an list of String to be returned',
    () async {
      // When
      expect(await useCase.execute(param: param), CommonMocks.did);

      // Then
      expect(
          verify(getGenesisStateUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first,
          CommonMocks.privateKey);

      var authClaimCapture = verify(identityRepository.getDidIdentifier(
        blockchain: captureAnyNamed('blockchain'),
        network: captureAnyNamed('network'),
        claimsRoot: captureAnyNamed('claimsRoot'),
        profileNonce: captureAnyNamed('profileNonce'),
      )).captured;
      expect(authClaimCapture[0], CommonMocks.blockchain);
      expect(authClaimCapture[1], CommonMocks.network);
      expect(authClaimCapture[2], IdentityMocks.treeState.claimsTree.data);
      expect(authClaimCapture[3], CommonMocks.genesisNonce);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(getGenesisStateUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(
          useCase.execute(param: param), throwsA(CommonMocks.exception));

      // Then
      expect(
          verify(getGenesisStateUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first,
          CommonMocks.privateKey);

      verifyNever(identityRepository.getDidIdentifier(
        blockchain: captureAnyNamed('blockchain'),
        network: captureAnyNamed('network'),
        claimsRoot: captureAnyNamed('claimsRoot'),
        profileNonce: captureAnyNamed('profileNonce'),
      ));
    },
  );
}
