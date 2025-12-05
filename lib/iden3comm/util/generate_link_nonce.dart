import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:ninja_prime/ninja_prime.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

/// We generate a random linkNonce for each groupId
String generateLinkNonce() {
  final BigInt safeMaxVal = BigInt.parse(
    "21888242871839275222246405745257275088548364400416034343698204186575808495617",
  );
  // get max value of 2 ^ 248
  BigInt base = BigInt.parse('2');
  int exponent = 248;
  final maxVal = base.pow(exponent) - BigInt.one;
  final random = Random.secure();
  BigInt randomNumber;
  do {
    randomNumber = randomBigInt(248, max: maxVal, random: random);
    if (kDebugMode) {
      logger().i("random number $randomNumber");
      logger().i("less than safeMax ${randomNumber < safeMaxVal}");
    }
  } while (randomNumber >= safeMaxVal);

  return randomNumber.toString();
}