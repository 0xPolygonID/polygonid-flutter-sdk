import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';

import 'remote_claim_data_source_test.mocks.dart';

// Data
const url = "theUrl";
const issuer = "theIssuer";
const identifier = "theIdentifier";
Response response = Response("body", 200);
Response errorResponse = Response("body", 444);

final exception = Exception();

// Dependencies
MockClient client = MockClient();
MockStacktraceStreamManager stacktraceStreamManager =
    MockStacktraceStreamManager();

// Tested instance
RemoteClaimDataSource dataSource = RemoteClaimDataSource(
  client,
  stacktraceStreamManager,
);

@GenerateMocks([
  Client,
  StacktraceStreamManager,
])
void main() {}
