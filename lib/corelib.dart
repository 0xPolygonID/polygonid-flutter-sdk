import 'dart:async';

import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';

class Corelib {
  static const MethodChannel _channel = MethodChannel('corelib');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /*static Future<bool> newIdentity(String alias, String pass) async {
    dynamic result;

    var path = await _localPath;
    var sharedPath = path + "/shared";
    var arguments = <String, dynamic>{
         'pass': pass,
         'alias': alias,
         'path': path,
         'shared': sharedPath
    };
    //var fullPath = arguments["path"] + "/" + alias;
    //bool exists = FileSystemEntity.typeSync(fullPath) != FileSystemEntityType.notFound;
    //if (exists == true) {
    //   result = await _channel.invokeMethod('loadIdentity', arguments);
    //} else {
       result = await _channel.invokeMethod('newIdentity', arguments);
    //}

    return result;
  }

  static Future<bool> loadIdentity(String alias, String pass) async {
    var path = await _localPath;
    var sharedPath = path + "/shared";
    var arguments = <String, dynamic>{
      'pass': pass,
      'alias': alias,
      'path': path,
      'shared': sharedPath
    };
    bool result = await _channel.invokeMethod('loadIdentity', arguments);
    return result;
  }

  // Stop Identity
  static Future<bool> stop() async {
    var arguments = Map();
    final bool result = await _channel.invokeMethod("stopIdentity", arguments);
    return result;
  }

  // Request Claim
  static Future<Map> requestClaim(String issuer, String formData) async {
    Map ticket;
    var arguments = Map();
    arguments["issuer"] = issuer;
    arguments["formData"] = formData;
    try {
      ticket = await _channel.invokeMethod("requestClaim", arguments);
    } on PlatformException catch (e) {
      throw(e);
    }

    if (ticket != null) {
      return ticket;
    }
    throw("Unsuccessful request");
  }

  // LIST CLAIMS
  static Future<List<dynamic>> listClaims() async {
    var claims;
    try {
      claims = await _channel.invokeMethod("listCreds", Map());
    } on PlatformException catch (e) {
      throw(e);
    }
    return claims;
  }

  static Future<bool> proveClaim(String verifier, String claimDBKey) async {
    bool result = false;
    var arguments = Map();
    arguments["verifier"] = verifier;
    arguments["claimDBKey"] = claimDBKey;
    result = await _channel.invokeMethod("proveClaim", arguments);
    return result;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }*/
}
