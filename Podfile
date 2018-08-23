platform:ios, '11.4'
ENV['COCOAPODS_DISABLE_STATS'] = 'true'
use_frameworks!

workspace 'Rijksmuseum'

target 'App' do
    project 'App/App.xcodeproj'
    pod "TinyConstraints"
    pod "SDWebImage"
    target 'AppTests' do
        inherit! :search_paths
    end
end

target 'Utility' do
    project 'Utility/Utility.xcodeproj'
    pod "TinyConstraints"
    pod "SDWebImage"
    target 'UtilityTests' do
        inherit! :search_paths
    end
end
