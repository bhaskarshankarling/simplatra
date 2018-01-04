require 'yaml'
class ApplicationData
    FILES = Dir.entries("./app/yaml").select{|f| !File.directory?(f)}
    YML_FILES = FILES.select{|f|f.end_with?(".yml",".yaml")}
    YML_FILES.map{|f|{name: File.basename(f,'.*'), ext: File.extname(f)}}.each do |f|
        if /[@$"]/ !~ f[:name].to_sym.inspect
            define_method f[:name].to_sym do
                YAML.load_file "./app/yaml/#{f[:name]+f[:ext]}"
            end
        end
    end
    module Helpers
        def data
            settings.app_data
        end
    end
end