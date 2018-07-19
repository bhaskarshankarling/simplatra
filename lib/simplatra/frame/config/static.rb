# Prepare YAML data accessors
class Static
  class << self
    FILES = Dir.entries("#{Simplatra::ROOT}/app/yaml").select{|f|!File.directory?(f)}
    YML = FILES.select{|f|f.end_with?('.yml','.yaml')}
    YML.map{|f|{name: File.basename(f,'.*'),ext: File.extname(f)}}.each do |f|
      if /[@$"]/ !~ f[:name].to_sym.inspect
        define_method(f[:name].to_sym) do
          data = YAML.load_file("#{Simplatra::ROOT}/app/yaml/#{f[:name]+f[:ext]}")
          data.is_a?(Hash) ? data.deep_symbolize_keys : data
        end
      else
        raise NameError.new("YAML file name '#{f[:name]}' must be a valid Ruby method name.")
      end
    end
  end
end