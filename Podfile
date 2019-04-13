platform:ios, '12.2'
ENV['COCOAPODS_DISABLE_STATS'] = 'true'
use_frameworks!

workspace 'Rijksmuseum'

pod "TinyConstraints"
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
