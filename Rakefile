require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'active_support/core_ext'
require './app.rb'

desc 'Sets up the application. (parameters: NAME, GITKEEP=true/false)'
task :setup do
    unless ENV.has_key? 'NAME'
        puts "\n\e[91mERR\e[0m » Application name must be specified e.g. rake setup NAME=my-application"
        next
    end

    remove_gitkeeps = ENV['GITKEEP'] ? ENV['GITKEEP'].downcase == 'true' : false
    current_directory_name = File.basename File.dirname(__FILE__)
    parent_directory = File.dirname File.dirname(__FILE__)
    new_directory_path = parent_directory+"/#{ENV['NAME']}"

    if File.directory? new_directory_path
        puts "\n\e[91mERR\e[0m » '#{new_directory_path}' already exists"
    else
        sh %(rm -rf .git)
        sh %(find . -name ".gitkeep" -exec rm -rf {} \\;) if remove_gitkeeps
        sh %(rm README.md) if File.exist? 'README.md'
        Dir.chdir '..'
        sh %(mv #{current_directory_name} #{ENV['NAME']})
        Dir.chdir ENV['NAME']
        len = current_directory_name.length+ENV['NAME'].length+2
        puts "\e[37m*#{?-*(len)}*\e[0m"
        puts "\e[32m#{"Setup ✔".center(len+2)}\e[0m"
    end
end

namespace :generate do
    desc 'Generates a model file (parameters: NAME)'
    task :model do
        unless ENV.has_key? 'NAME'
            puts "\n\e[91mERR\e[0m » Model name must be specified e.g. rake generate:model NAME=User"
            next
        end

        name = ENV['NAME'].camelize
        file_name = ENV['NAME'].underscore+'.rb'
        file_path = File.dirname(__FILE__)+'/app/models/'+file_name

        if File.exist? file_path
            puts "\n\e[91mERR\e[0m » Model file 'app/models/#{file_name}' already exists."
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    class #{name} < ActiveRecord::Base
                        # Add your model methods here...
                    end
                EOF
            end
            puts "\n\e[90mCreated a new model file at\e[0m \e[32mapp/models/#{file_name}\e[0m"
        end
    end

    desc 'Generates a controller file (parameters: NAME)'
    task :controller do
        unless ENV.has_key? 'NAME'
            puts "\n\e[91mERR\e[0m » Controller name must be specified e.g. rake generate:controller NAME=User"
            next
        end

        file_name = ENV['NAME'].underscore+'.rb'
        file_path = File.dirname(__FILE__)+'/app/controllers/'+file_name

        if File.exist? file_path
            puts "\n\e[91mERR\e[0m » Controller file 'app/controllers/#{file_name}' already exists."
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    class Application < Sinatra::Base
                        # Add your routes here...
                    end
                EOF
            end
            puts "\n\e[90mCreated a new controller file at\e[0m \e[32mapp/controllers/#{file_name}\e[0m"
        end
    end

    desc 'Generates a helper file (parameters: NAME)'
    task :helper do
        unless ENV.has_key? 'NAME'
            puts "\n\e[91mERR\e[0m » Helper name must be specified e.g. rake generate:helper NAME=User"
            next
        end

        file_name = ENV['NAME'].underscore+'.rb'
        file_path = File.dirname(__FILE__)+'/app/helpers/'+file_name

        if File.exist? file_path
            puts "\n\e[91mERR\e[0m » Helper file 'app/helpers/#{file_name}' already exists."
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    class Application < Sinatra::Base
                        module Helpers
                            # Add your helper methods here...
                        end
                    end
                EOF
            end
            puts "\n\e[90mCreated a new helper file at\e[0m \e[32mapp/helpers/#{file_name}\e[0m"
        end
    end
end