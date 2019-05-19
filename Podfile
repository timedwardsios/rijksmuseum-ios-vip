
platform:ios, '12.2'

ENV['COCOAPODS_DISABLE_STATS'] = 'true'

use_frameworks!

workspace 'Rijksmuseum'

target 'MuseumiOS' do

    pod "SDWebImage"

    project 'MuseumiOS/MuseumiOS.xcodeproj'

    target 'MuseumiOSTests' do
        inherit! :search_paths
    end
end

target 'MuseumKit' do
    project 'MuseumKit/MuseumKit.xcodeproj'

    target 'MuseumKitTests' do
        inherit! :search_paths
    end
end
