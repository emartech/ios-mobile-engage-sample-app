platform :ios, '9.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

target "mobile-engage-sample-app-ios" do
  if ENV["DEV"] then
    puts 'Running in DEV mode'
    pod 'MobileEngageSDK', :path => '../ios-mobile-engage-sdk/'
  elsif ENV["BLEEDING_EDGE"] then
    puts 'Running in BLEEDING_EDGE mode'
    pod 'MobileEngageSDK', :git => 'https://github.com/emartech/ios-mobile-engage-sdk.git'
  else
    pod 'MobileEngageSDK', '0.7.0'
  end
end

target "mobile-engage-sample-app-iosTests" do
  pod 'Kiwi'
end
