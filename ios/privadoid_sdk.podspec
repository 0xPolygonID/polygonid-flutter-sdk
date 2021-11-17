#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint privadoid_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'privadoid_sdk'
  s.version          = '1.0.0'
  s.summary          = 'Flutter plugin for PrivadoID SDK'
  s.description      = <<-DESC
Privadoid flutter sdk plugin
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = 'iden3'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.static_framework = true
  s.vendored_libraries = "**/*.a"
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'STRIP_STYLE' => 'non-global', 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
