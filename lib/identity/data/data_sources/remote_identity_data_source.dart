import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/common/http.dart';

class RemoteIdentityDataSource{
  Future<Response> authWithToken(String token,AuthRequest request){
    String endpoint = request.body!.callbackUrl!;//TODO maybe is not right choice to force null safety
    return postRawMsg(endpoint,body: token);
  }
}