platform:ios, '11.4'
ENV['COCOAPODS_DISABLE_STATS'] = 'true'
use_frameworks!

workspace 'Rijksmuseum'

pod 'TinyConstraints', :git => 'https://github.com/timedwardsios/TinyConstraints'
pod "SDWebImage"

target 'App' do
    project 'App/App.xcodeproj'
    target 'AppTests' do
        inherit! :search_paths
    end
end

target 'Service' do
    project 'Service/Service.xcodeproj'
    target 'ServiceTests' do
        inherit! :search_paths
    end
end

target 'Utils' do
    project 'Utils/Utils.xcodeproj'
    target 'UtilsTests' do
        inherit! :search_paths
    end
end
