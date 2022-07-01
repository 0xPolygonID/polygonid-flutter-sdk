import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:polygonid_flutter_sdk/http.dart' show extractJSON, get, post;

import 'model/onboard_request.dart';
import 'model/onboard_response.dart';

var baseApiUrl = '';

const VERIFICATIONS_URL = "/verifications";
const START_URL = "/start";
const STATUS_URL = "/status";
const CONTINUE_URL = "/continue";

const ONBOARDED_USERS_URL = "/onboarded-users";
const CHECK_PIN_URL = "/checkpin";

const EVENTS_URL = "/events";

const TRANSACTIONS_POOL_URL = "/transactions-pool";
const TRANSACTIONS_HISTORY_URL = "/transactions-history";

const TOKENS_URL = "/tokens";
const RECOMMENDED_FEES_URL = "/recommendedFee";
const COORDINATORS_URL = "/coordinators";

const BATCHES_URL = "/batches";
const SLOTS_URL = "/slots";
const BIDS_URL = "/bids";
const ACCOUNT_CREATION_AUTH_URL = "/account-creation-authorization";

enum PaginationOrder { ASC, DESC }

/// Sets the query parameters related to pagination
///
/// @param [int] fromItem - Item from where to start the request
/// @param [PaginationOrder] order - order of pagination selected
/// @param [int] limit - number of items to receive with the request
/// @returns [Map<String, String>] Includes the values [fromItem] and [limit]
/// @private
Map<String, String> _getPageData(
    int fromItem, PaginationOrder order, int limit) {
  Map<String, String> params = {};
  if (fromItem > 0) {
    params.putIfAbsent('fromItem', () => fromItem.toString());
  }
  params.putIfAbsent('order', () => order.toString().split(".")[1]);
  params.putIfAbsent('limit', () => limit.toString());
  return params;
}

/// Sets the current coordinator API URL
///
/// @param [String] url - The current coordinator
void setBaseApiUrl(String url) {
  baseApiUrl = url;
}

/// Returns current coordinator API URL
///
/// @returns [String] The currently set Coordinator
String getBaseApiUrl() {
  return baseApiUrl;
}

/// Checks a list of responses from one same POST request to different coordinators
/// If all responses are errors, throw the error
/// If at least 1 was successful, return it
///
/// @param [Set<http.Response>] responsesArray - An set of responses, including errors
/// @returns [Set<http.Response>] response
/// @throws Error
http.Response filterResponses(Set<http.Response> responsesArray) {
  Set<http.Response> invalidResponses = Set.from(responsesArray);
  invalidResponses.removeWhere((res) => res.statusCode == 200);
  if (invalidResponses.length == responsesArray.length) {
    return responsesArray.first;
  } else {
    return responsesArray.firstWhere((res) => res.statusCode == 200);
  }
}

/// Onboard User into PolygonID
/// POST https://api.internal.privadoid.com/v1/verifications/start
///
Future<OnboardResponse> onboardUser(OnboardRequest request) async {
  final response = await post(baseApiUrl, VERIFICATIONS_URL + START_URL,
      body: request.toJson());
  if (response.statusCode == 200) {
    final jsonResponse = await extractJSON(response);
    final OnboardResponse onboardResponse =
        OnboardResponse.fromJson(json.decode(jsonResponse));
    return onboardResponse;
  } else {
    throw ('Error: $response.statusCode');
  }
}

/// Check Process Status
/// GET https://api.internal.privadoid.com/v1/verifications/status/2
///
/// TODO: DOCUMENTATION
Future<OnboardResponse> checkOnboardUserStatus() async {
  final response = await get(baseApiUrl, VERIFICATIONS_URL + START_URL);
  if (response.statusCode == 200) {
    final jsonResponse = await extractJSON(response);
    final OnboardResponse onboardResponse =
        OnboardResponse.fromJson(json.decode(jsonResponse));
    return onboardResponse;
  } else {
    throw ('Error: $response.statusCode');
  }
}
