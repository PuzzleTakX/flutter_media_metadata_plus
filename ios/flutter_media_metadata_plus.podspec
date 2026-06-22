#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_media_metadata_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_media_metadata_plus'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin to read metadata of media files.'
  s.description      = <<-DESC
A Flutter plugin to read metadata of media files.
                       DESC
  s.homepage         = 'https://github.com/PuzzleTakX/flutter_media_metadata_plus'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bahman Teynouri Nezhad (PuzzleTakX)' => 'https://github.com/PuzzleTakX' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
