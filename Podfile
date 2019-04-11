# Uncomment the next line to define a global platform for your project
# platform :ios, '6.0'

target 'Insta Clone Firebase' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Insta Clone Firebase

  target 'Insta Clone FirebaseTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Insta Clone FirebaseUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
# get set of Firebase infrastructure
pod 'SDWebImage'
# from https://github.com/SDWebImage/SDWebImage  

# PJ to try to use firebase in XCode 8.3, try https://github.com/firebase/firebase-ios-sdk/pull/1519  - https://github.com/firebase/firebase-ios-sdk/blob/master/README.md
# pod 'FirebaseCore', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
# pod 'FirebaseFirestore', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'

#  https://stackoverflow.com/q/47037713    https://stackoverflow.com/a/54296051
# pod 'Firebase/Core', '2.1.3'

# https://github.com/invertase/react-native-firebase/issues/1764#issuecomment-452178852
post_install do |installer|
  system("mkdir -p Pods/Headers/Public/FirebaseCore && cp Pods/FirebaseCore/Firebase/Core/Public/* Pods/Headers/Public/FirebaseCore/")
end
