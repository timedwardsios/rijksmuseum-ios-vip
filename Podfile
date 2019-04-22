platform:ios, '12.2'
ENV['COCOAPODS_DISABLE_STATS'] = 'true'
use_frameworks!

workspace 'Rijksmuseum'

target 'App' do
    pod "TinyConstraints"
    pod "SDWebImage"
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
