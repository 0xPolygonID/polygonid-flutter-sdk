import 'dart:io';

import 'package:ffigen/ffigen.dart';

void main() {
  final packageRoot = Directory.current.uri;
  FfiGenerator(
    output: Output(
      dartFile: packageRoot.resolve(
        'lib/common/libs/polygonidcore/native_polygonidcore.dart',
      ),
      style: DynamicLibraryBindings(
        wrapperName: 'NativePolygonIdCoreLib',
        wrapperDocComment: 'Bindings to `ios/Classes/libpolygonid.h`.',
      ),
      preamble:
          '// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_element, unused_field, unused_local_variable',
    ),
    headers: Headers(
      entryPoints: [
        packageRoot.resolve(
          'ios/polygonid_flutter_sdk/Frameworks/libpolygonid.xcframework/libpolygonid.h',
        ),
      ],
    ),
    functions: Functions(
      include: _isPolygon,
    ),
    globals: Globals.includeSet({
      'PLGNSTATUSCODE_ERROR',
      'PLGNSTATUSCODE_NIL_POINTER',
      'PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_EXTRACTION_ERROR',
      'PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_RESOLVE_ERROR',
      'PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_MT_BUILD_ERROR',
      'PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_MT_STATE_ERROR',
      'PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_REVOKED_ERROR',
      'PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_EXTRACTION_ERROR',
      'PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_RESOLVE_ERROR',
      'PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_MT_BUILD_ERROR',
      'PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_MT_STATE_ERROR',
      'PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_REVOKED_ERROR',
      'PLGNSTATUSCODE_INVALID_AADHAAR_SIGNATURE',
    }),
    structs: Structs(
      include: _isPolygon,
      rename: (Declaration decl) {
        final name = decl.originalName;
        return name.startsWith('_') ? name.substring(1) : name;
      },
    ),
    enums: Enums(
      include: _isPolygon,
    ),
  ).generate();
}

bool _isPolygon(Declaration decl) =>
    decl.originalName.startsWith('PLGN') ||
    decl.originalName.startsWith('_PLGN');
