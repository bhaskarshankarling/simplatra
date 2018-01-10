require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'active_support/core_ext'
require './app.rb'

desc 'Sets up the application. (parameters: NAME, GITKEEP=true/false)'
task :setup do
    unless ENV.has_key? 'NAME'
        raise "ERR » Application name must be specified e.g. rake setup NAME=my-application"
    end

    remove_gitkeeps = ENV['GITKEEP'] ? ENV['GITKEEP'].downcase == 'true' : false
    current_directory_name = File.basename File.dirname(__FILE__)
    parent_directory = File.dirname File.dirname(__FILE__)
    new_directory_path = parent_directory+"/#{ENV['NAME']}"

    if File.directory? new_directory_path
        raise "ERR » '#{new_directory_path}' already exists"
    else
        sh %(rm -rf .git)
        sh %(find . -name ".gitkeep" -exec rm -rf {} \\;) if remove_gitkeeps
        sh %(rm README.md) if File.exist? 'README.md'
        Dir.chdir '..'
        sh %(mv #{current_directory_name} #{ENV['NAME']})
        Dir.chdir ENV['NAME']
        # Done
        len = current_directory_name.length+ENV['NAME'].length+2
        puts "\e[37m*#{?-*(len)}*\e[0m"
        puts "\e[32m#{"Setup ✔".center(len+2)}\e[0m"
    end
end

namespace :generate do
    desc 'Generates a new model class file in app/models (parameters: NAME)'
    task :model do
        unless ENV.has_key? 'NAME'
          raise "ERR » Model name must be specified e.g. rake generate:model NAME=User"
        end

        name = ENV['NAME'].camelize
        file_name = ENV['NAME'].underscore+'.rb'
        file_path = File.dirname(__FILE__)+'/app/models/'+file_name

        if File.exist? file_path
          raise "ERR » Model file '#{file_path}' already exists."
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    class #{name} < ActiveRecord::Base
                        # Add your model methods here...
                    end
                EOF
            end
        end
    end

    desc 'Generates a new controller class file in app/controllers (parameters: NAME)'
    task :controller do
        unless ENV.has_key? 'NAME'
            raise "ERR » Controller name must be specified e.g. rake generate:controller NAME=User"
        end

        file_name = ENV['NAME'].underscore+'.rb'
        file_path = File.dirname(__FILE__)+'/app/controllers/'+file_name

        if File.exist? file_path
            raise "ERR » Controller file '#{file_path}' already exists."
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    class Application < Sinatra::Base
                        # Add your routes here...
                    end
                EOF
            end
        end
    end

    desc 'Generates a new helper class file in app/helpers (parameters: NAME)'
    task :helper do
        unless ENV.has_key? 'NAME'
            raise "ERR » Helper name must be specified e.g. rake generate:helper NAME=User"
        end

        file_name = ENV['NAME'].underscore+'.rb'
        file_path = File.dirname(__FILE__)+'/app/helpers/'+file_name

        if File.exist? file_path
            raise "ERR » Helper file '#{file_path}' already exists."
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
        end
    end
end