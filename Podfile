# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'ML Kit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ML Kit
  pod 'GoogleMLKit/BarcodeScanning', '4.0.0'
  pod 'GoogleMLKit/TextRecognition', '4.0.0'
  pod 'GoogleMLKit/ImageLabeling', '4.0.0'
  pod 'GoogleMLKit/LanguageID', '4.0.0'
  pod 'GoogleMLKit/Translate', '4.0.0'
  
  post_install do |installer|
      installer.generated_projects.each do |project|
            project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
                 end
            end
     end
  end
  
end
