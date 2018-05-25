# Prepare YAML data accessors
class Static
    @all_files = Dir.entries('./app/yaml').select{|f|!File.directory?(f)}
    @yml_files = @all_files.select{|f|f.end_with?('.yml','.yaml')}
    @yml_files.map{|f|{name: File.basename(f,'.*'),ext: File.extname(f)}}.each do |f|
        if /[@$"]/ !~ f[:name].to_sym.inspect
            define_method(f[:name].to_sym){YAML.load_file "./app/yaml/#{f[:name]+f[:ext]}"}
        else
            raise NameError.new("YAML file name '#{f[:name]}' must be a valid Ruby method name.")
        end
    end
end
$static = Static.new