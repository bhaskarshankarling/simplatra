namespace :mvc do
    namespace :gen do

        desc 'Generates a model file (parameters: NAME)'
        task :model do
            unless ENV.has_key? 'NAME'
                puts "\n\e[91mERR\e[0m » Model name must be specified e.g. rake generate:model NAME=User", ?=*69
                next
            end

            name = ENV['NAME'].singularize.camelize
            file_name = "#{ENV['NAME'].singularize.underscore}.rb"
            file_path = "#{Simplatra::ROOT}/app/models/#{file_name}"
            spec_name = file_name.gsub('.rb','_spec.rb')
            spec_path = "#{Simplatra::ROOT}/spec/models/#{spec_name}"

            if File.exist? file_path
                puts "\n#{"ERR".colorize(:light_red)} » Model file '#{file_path}' already exists."
            else
                File.open(file_path, 'w+') do |f|
                    f.write(<<-EOF.strip_heredoc)
                        class #{name} < ActiveRecord::Base
                            # Add your model methods here...
                        end
                    EOF
                end
                puts "\n#{"Created a model file at".colorize(:light_black)} #{"app/models/#{file_name}".colorize(:green)}"
            end
            if File.exist? spec_path
                message = "\n#{"ERR".colorize(:light_red)} » Model spec '#{file_path}' already exists."
                puts message, ?=*(message.uncolorize.length-1)
            else
                File.open(spec_path, 'w+') do |f|
                    f.write(<<-EOF.strip_heredoc)
                        require_relative '../spec_helper'
                        describe #{name}, type: :model do

                            it "should expect true to be true" do
                                expect(true).to be true
                            end

                        end
                    EOF
                end
                message = "\n#{"Created a model spec at".colorize(:light_black)} #{spec_path.colorize(:green)}"
                puts message, ?=*(message.uncolorize.length-1)
            end
        end

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

        desc 'Generates a scaffold (parameters: NAME, CONTROLLER, HELPER, MODEL)'
        task :scaffold do
            unless ENV.has_key? 'NAME'
                message = "\n#{"ERR".colorize(:light_red)} » Scaffold name must be specified e.g. rake generate:scaffold NAME=User"
                puts message, ?=*(message.uncolorize.length-1)
                next
            end
            sh "rake mvc:gen:helper NAME=#{ENV['NAME']}" if ENV['HELPER'].nil? || ENV['HELPER'].downcase == 'true'
            sh "rake mvc:gen:controller NAME=#{ENV['NAME']}" if ENV['CONTROLLER'].nil? || ENV['CONTROLLER'].downcase == 'true'
            sh "rake mvc:gen:model NAME=#{ENV['NAME']}" if ENV['MODEL'].nil? || ENV['MODEL'].downcase == 'true'
        end

    end
end