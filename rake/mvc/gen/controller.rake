namespace :mvc do
    namespace :gen do

        desc 'Generates a controller file (parameters: NAME)'
        task :controller do
            unless ENV.has_key? 'NAME'
                message = "\n#{"ERR".colorize(:light_red)} » Controller name must be specified e.g. rake generate:controller NAME=User"
                puts message, ?=*(message.uncolorize.length-1)
                next
            end

            file_name = ENV['NAME'].downcase.include?('controller') ? "#{ENV['NAME'].underscore}.rb" : "#{ENV['NAME'].singularize.underscore}_controller.rb"
            file_path = "#{Simplatra::ROOT}/app/controllers/#{file_name}"
            class_name = ENV['NAME'].downcase.include?('controller') ? ENV['NAME'].camelize : "#{ENV['NAME'].singularize.camelize}Controller"
            spec_name = file_name.gsub('.rb','_spec.rb')
            spec_path = "#{Simplatra::ROOT}/spec/controllers/#{spec_name}"

            if File.exist? file_path
                puts "\n#{"ERR".colorize(:light_red)} » Controller file '#{file_path}' already exists."
            else
                File.open(file_path, 'w+') do |f|
                    f.write(<<-EOF.strip_heredoc)
                        require_relative 'application_controller'
                        class #{class_name} < ApplicationController
                            helpers #{class_name.gsub 'Controller', 'Helper'}
                        end
                    EOF
                end
                puts "\n#{"Created a controller file at".colorize(:light_black)} #{file_path.colorize(:green)}"
            end
            if File.exist? spec_path
                message = "\n#{"ERR".colorize(:light_red)} » Controller spec '#{spec_path}' already exists."
                puts message, ?=*(message.uncolorize.length-1)
            else
                File.open(spec_path, 'w+') do |f|
                    f.write(<<-EOF.strip_heredoc)
                        require_relative '../spec_helper'
                        describe #{class_name} do
                            def app() #{class_name} end

                            it "should expect true to be true" do
                                expect(true).to be true
                            end

                        end
                    EOF
                end
                message = "\n#{"Created a controller spec at".colorize(:light_black)} #{spec_path.colorize(:green)}"
                puts message, ?=*(message.uncolorize.length-1)
            end
        end

    end
end