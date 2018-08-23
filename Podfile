platform:ios, '11.4'
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

target 'Workers' do
    project 'Workers/Workers.xcodeproj'
    target 'WorkersTests' do
        inherit! :search_paths
    end
end

target 'Utility' do
    project 'Utility/Utility.xcodeproj'
    target 'UtilityTests' do
        inherit! :search_paths
    end
end
