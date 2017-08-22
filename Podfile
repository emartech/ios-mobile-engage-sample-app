platform :ios, '9.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

def pods
    if ENV["DEV"] then
        puts 'Running in DEV mode'
        pod 'MobileEngageSDK', :path => '../ios-mobile-engage-sdk/'
    elsif ENV["BLEEDING_EDGE"] then
        puts 'Running in BLEEDING_EDGE mode'
        pod 'MobileEngageSDK', :git => 'git@github.com:emartech/ios-mobile-engage-sdk.git'
    else
        pod 'MobileEngageSDK'
    end
end

target "mobile-engage-sample-app-ios" do
    pods
end

target "MESServiceExtension" do
    pods
end

target "mobile-engage-sample-app-iosTests" do
  pod 'Kiwi'
end
