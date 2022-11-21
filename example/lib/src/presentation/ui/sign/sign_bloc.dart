import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/data/secure_storage.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/sign/sign_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/sign/sign_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/secure_storage_keys.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  final PolygonIdSdk _polygonIdSdk;

  SignBloc(this._polygonIdSdk) : super(const SignState.initial()) {
    on<SignMessageEvent>(_signMessage);
  }

  ///
  Future<void> _signMessage(
      SignMessageEvent event, Emitter<SignState> emit) async {
    emit(const SignState.loading());

    String? privateKey =
        await SecureStorage.read(key: SecureStorageKeys.privateKey);

    if (privateKey == null) {
      emit(const SignState.error(message: "no private key found"));
      return;
    }
    try {
      if (event.message.trim().isEmpty) {
        emit(const SignState.error(message: "message cannot be empty"));
        return;
      }

      String signature = await _polygonIdSdk.identity.sign(
        privateKey: privateKey,
        message: event.message,
      );
      emit(SignState.loaded(signature: signature));
    } on IdentityException catch (identityException) {
      emit(SignState.error(message: identityException.error));
    } on FormatException catch (identityException) {
      emit(SignState.error(message: identityException.message));
    } catch (_) {
      emit(const SignState.error(message: CustomStrings.genericError));
    }
  }
}
