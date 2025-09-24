#
# Be sure to run `pod lib lint FlutterwaveSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'FlutterwaveSDK'
    s.version          = '1.5.0'
    s.summary          = 'FlutterwaveSDK'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/Flutterwave/FlutterwaveSDK'
    s.screenshots     = 'https://github.com/Flutterwave/FlutterwaveSDK/blob/master/FlutterwaveSDK/Assets/Assets.xcassets/FlutterwaveScreenshot.imageset/FlutterwaveScreenshot.png'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Flutterwave Developers' => 'developers@flutterwavego.com' }
    s.source           = { :git => 'https://github.com/Flutterwave/FlutterwaveSDK.git', :tag => '1.5.0'}
    s.social_media_url = 'https://twitter.com/FlutterwaveEng'
    
    s.ios.deployment_target = '11.0'
    s.swift_versions = '5.0'
    
    s.source_files = 'FlutterwaveSDK/**/*.{h,m,swift}'
    s.resources =  'FlutterwaveSDK/**/*.{xcassets,json,png}'
   
    s.public_header_files = 'Classes/*.h'
    
    s.frameworks = 'UIKit'
    s.dependency 'lottie-ios'
    s.dependency 'RxSwift'
    s.dependency 'RxCocoa'
    s.dependency 'SwinjectAutoregistration'
    s.dependency 'Swinject'
    s.dependency 'MaterialComponents/TextControls+OutlinedTextAreas'
    s.dependency 'MaterialComponents/TextControls+OutlinedTextFields'
    s.dependency 'IQKeyboardManagerSwift'
end

