#
# Be sure to run `pod lib lint FitDataProtocol.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FitDataProtocol'
  s.version          = '0.16.0'
  s.summary          = 'Garmin Flexible and Interoperable Data Transfer Protocol.'


  s.description      = <<-DESC
Swift version of the Garmin Flexible and Interoperable Data Transfer Protocol.
                       DESC

  s.homepage            = 'https://github.com/FitnessKit/FitDataProtocol'
  s.documentation_url   = 'https://fitnesskit.github.io/FitDataProtocol/'
  s.license             = { :type => 'MIT', :file => 'LICENSE' }
  s.author              = { 'Kevin A. Hoogheem' => 'kevin@hoogheem.net' }
  s.source              = { :git => 'https://github.com/FitnessKit/FitDataProtocol.git', :tag => s.version.to_s }

#Targets
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

#Source
  s.source_files = 'Sources/FitDataProtocol/**/*'

#Required Frameworks
#  s.ios.framework       = [ 'Dispatch' ]

#Dependancy
  s.dependency 'DataDecoder', '>= 4.3.1'
  s.dependency 'FitnessUnits', '>= 2.1.0'
  s.dependency 'AntMessageProtocol', '>= 0.2.7'

end
