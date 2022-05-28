#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run 'pod lib lint privadoid_sdk.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'privadoid_sdk'
  s.version          = '1.0.0'
  s.summary          = 'Flutter plugin for PrivadoID SDK'
  s.description      = <<-DESC
Privadoid library flutter plugin project.
                       DESC
  s.homepage         = 'http://iden3.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Iden3' => 'info@iden3.io' }
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
  s.pod_target_xcconfig = { "OTHER_LDFLAGS" => "-force_load $(PODS_TARGET_SRCROOT)/Frameworks/librapidsnark.a -force_load $(PODS_TARGET_SRCROOT)/Frameworks/libwitnesscalc.a -lc++ -lz" }
  # s.vendored_libraries = "Frameworks/**/*.a"
  s.pod_target_xcconfig = { 'STRIP_STYLE' => 'non-global', 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
