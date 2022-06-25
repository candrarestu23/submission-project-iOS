# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!
workspace 'submissionProject'
def shared_pods
  # Pods for dicoding-expert
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Cosmos'
  pod 'Alamofire'
  pod 'SDWebImage', '~> 5.0'
  pod 'SwiftLint'
  pod 'Swinject', '2.6.0'
  pod 'SwinjectStoryboard'
  pod 'RealmSwift'

end

target 'submissionProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  # Pods for submissionProject
	shared_pods

end

target 'submissionProjectTests' do
  inherit! :search_paths
  shared_pods
end

target 'Home' do
  shared_pods
  project 'Home/Home'
end

target 'Core' do
  shared_pods
  project 'Core/Core'
end

target 'Detail' do
  shared_pods
  project 'Detail/Detail'
end
