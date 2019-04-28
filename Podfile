
platform:ios, '12.2'
ENV['COCOAPODS_DISABLE_STATS'] = 'true'
use_frameworks!

workspace 'Rijksmuseum'

pod 'SwiftLint'

target 'App' do
    pod "SDWebImage"
    project 'App/App.xcodeproj'
    target 'AppTests' do
        inherit! :search_paths
    end
end

target 'Services' do
    project 'Services/Services.xcodeproj'
    target 'ServicesTests' do
        inherit! :search_paths
    end
end

target 'Utils' do
    project 'Utils/Utils.xcodeproj'
    target 'UtilsTests' do
        inherit! :search_paths
    end
end

target 'TestTools' do
    project 'TestTools/TestTools.xcodeproj'
    target 'TestToolsTests' do
        inherit! :search_paths
    end
end
