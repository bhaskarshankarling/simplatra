namespace :mvc do
    namespace :gen do

        desc 'Generates a helper file (parameters: NAME)'
        task :helper do
            unless ENV.has_key? 'NAME'
                message = "\n#{"ERR".colorize(:light_red)} » Helper name must be specified e.g. rake generate:helper NAME=User"
                puts message, ?=*(message.uncolorize.length-1)
                next
            end

            file_name = ENV['NAME'].downcase.include?('helper') ? "#{ENV['NAME'].underscore}.rb" : "#{ENV['NAME'].singularize.underscore}_helper.rb"
            file_path = "#{Simplatra::ROOT}/app/helpers/#{file_name}"
            module_name = ENV['NAME'].downcase.include?('helper') ? ENV['NAME'].camelize : "#{ENV['NAME'].singularize.camelize}Helper"

            if File.exist? file_path
                message = "\n#{"ERR".colorize(:light_red)} » Helper file '#{file_path}' already exists."
                puts message, ?=*(message.uncolorize.length-1)
            else
                File.open(file_path, 'w+') do |f|
                    f.write(<<-EOF.strip_heredoc)
                        module #{module_name}
                            # Add your methods...
                        end
                    EOF
                end
                message = "\n#{"Created a helper file at".colorize(:light_black)} #{file_path.colorize(:green)}"
                puts message, ?=*(message.uncolorize.length-1)
            end
        end

    end
end