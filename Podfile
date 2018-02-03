# Podfile
platform :ios, '9.0'

def include_testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'FeedbackApp' do
  use_frameworks!

  pod 'Kingfisher', '~> 4.6'
end

target 'FeedbackAppTests' do
    use_frameworks!

    include_testing_pods
end

target 'FeedbackAppUITests' do
    use_frameworks!

    include_testing_pods
end

target 'FeedbackAppDomain' do
    use_frameworks!
end

target 'FeedbackAppDomainTests' do
  use_frameworks!

  include_testing_pods
end

target 'FeedbackAppFileStore' do
    use_frameworks!

    pod 'Marshal', '~> 1.2'
end

target 'FeedbackAppFileStoreTests' do
    use_frameworks!

    include_testing_pods
end
