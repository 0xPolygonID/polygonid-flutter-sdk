#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run 'pod lib lint polygonid_flutter_sdk.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'polygonid_flutter_sdk'
  s.version          = '2.3.6'
  s.summary          = 'Flutter plugin for PolygonID SDK'
  s.description      = <<-DESC
PolygonID SDK flutter plugin project.
                       DESC
  s.homepage         = 'https://polygon.technology/polygon-id'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Polygon ID' => 'raulj@polygon.technology' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.static_framework = true
  s.vendored_libraries = "**/*.a"
  s.dependency 'Flutter'
  s.dependency 'CryptoSwift'
  s.platform = :ios, '9.0'
  s.libraries = ["c++", "z"]
  # s.ios.deployment_target = '9.0'
  # s.ios.vendored_frameworks = 'Frameworks/Core.xcframework'
  # Flutter.framework does not contain a i386 nor arm64 slice.
  s.pod_target_xcconfig = { "OTHER_LDFLAGS" => "-force_load $(PODS_TARGET_SRCROOT)/Frameworks/libbabyjubjub.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libpolygonid.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libwitnesscalc_authV2.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libwitnesscalc_credentialAtomicQueryMTPV2.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libwitnesscalc_credentialAtomicQuerySigV2.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libwitnesscalc_credentialAtomicQuerySigV2OnChain.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libwitnesscalc_credentialAtomicQueryMTPV2OnChain.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libwitnesscalc_credentialAtomicQueryV3.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libwitnesscalc_credentialAtomicQueryV3OnChain.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libwitnesscalc_linkedMultiQuery10.a -lc++ -lz" }
  # s.vendored_libraries = "Frameworks/**/*.a"
  s.pod_target_xcconfig = {
    'STRIP_STYLE' => 'non-global',
    'DEAD_CODE_STRIPPING' => 'NO',
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'armv7 armv7s'
  }
  s.swift_version = '5.0'
end
