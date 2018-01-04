require 'sprockets'
module Assets
    def self.set_paths(env)
        env.append_path "./app/assets/stylesheets"
        env.append_path "./app/assets/scripts"
        env.append_path "./app/assets/images"
        env.append_path "./app/assets/fonts"
        env.css_compressor = :scss
    end
end