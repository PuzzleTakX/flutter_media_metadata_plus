#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_media_metadata_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_media_metadata_plus'
  s.version          = '1.2.0'
  s.summary          = 'A high-performance Flutter plugin to read metadata and album art of media files.'
  s.description      = <<-DESC
A high-performance Flutter plugin to read metadata and album art of media files across all platforms.
                       DESC
  s.homepage         = 'https://github.com/PuzzleTakX/flutter_media_metadata_plus'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bahman Teymouri Nezhad (PuzzleTakX)' => 'https://github.com/PuzzleTakX' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.14'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
