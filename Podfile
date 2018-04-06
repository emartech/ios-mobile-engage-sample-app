platform :ios, '9.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'
source 'git@github.com:emartech/pod-private.git'

target "mobile-engage-sample-app-ios" do
    if ENV["DEV"] then
        puts '[SAMPLE] Running in DEV mode'
        pod 'CoreSDK', :path => '../ios-core-sdk/'
        pod 'MobileEngageSDK', :path => '../ios-mobile-engage-sdk/'
    else
        pod 'MobileEngageSDK'
    end
end

target "MESServiceExtension" do
    if ENV["DEV"] then
        pod 'MobileEngageRichExtension', :path => '../ios-mobile-engage-sdk/'
    elsif ENV["BLEEDING_EDGE"] then
        pod 'MobileEngageRichExtension', :git => 'git@github.com:emartech/ios-mobile-engage-sdk.git'
    else
        pod 'MobileEngageRichExtension'
    end
end

target "mobile-engage-sample-app-iosTests" do
  pod 'Kiwi'
end
