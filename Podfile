platform :ios, '9.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

def pods
    if ENV["DEV"] then
        puts '[SAMPLE] Running in DEV mode'
	pod 'CoreSDK', :path => '../ios-core-sdk/'
        pod 'MobileEngageSDK', :path => '../ios-mobile-engage-sdk/'
    elsif ENV["BLEEDING_EDGE"] then
        puts '[SAMPLE] Running in BLEEDING_EDGE mode'
	pod 'CoreSDK', :git => 'https://github.com/emartech/ios-core-sdk.git'
        pod 'MobileEngageSDK', :git => 'git@github.com:emartech/ios-mobile-engage-sdk.git'
    else
        pod 'MobileEngageSDK'
    end
end

target "mobile-engage-sample-app-ios" do
    pods
end

target "MESServiceExtension" do
    pod 'MobileEngageRichExtension', :path => '../ios-mobile-engage-sdk/'
end

target "mobile-engage-sample-app-iosTests" do
  pod 'Kiwi'
end
