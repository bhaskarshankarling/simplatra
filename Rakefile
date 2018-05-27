require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'active_support/core_ext'
require './app.rb'

task :default => [:spec]

desc 'Run specs'
task :spec do
  sh 'rspec -fd spec'
end

desc 'Sets up the application. (parameters: NAME, GITKEEP=true/false)'
task :setup do
    unless ENV.has_key? 'NAME'
        puts "\n\e[91mERR\e[0m » Application name must be specified e.g. rake setup NAME=my-application", ?=*76
        next
    end

    remove_gitkeeps = ENV['GITKEEP'] ? ENV['GITKEEP'].downcase == 'true' : false
    current_directory_name = File.basename File.dirname(__FILE__)
    parent_directory = File.dirname File.dirname(__FILE__)
    new_directory_path = "#{parent_directory}/#{ENV['NAME']}"

    if File.directory? new_directory_path
        puts "\n\e[91mERR\e[0m » '#{new_directory_path}' already exists", ?=*(24+new_directory_path.length)
    else
        sh %(rm -rf .git)
        sh %(find . -name ".gitkeep" -exec rm -rf {} \\;) if remove_gitkeeps
        sh %(rm README.md) if File.exist? 'README.md'
        Dir.chdir '..'
        sh %(mv #{current_directory_name} #{ENV['NAME']})
        Dir.chdir ENV['NAME']
        len = current_directory_name.length+ENV['NAME'].length+2
        puts "\e[37m*#{?=*(len)}*\e[0m"
        puts "\e[32m#{"Setup complete".center(len+2)}\e[0m"
    end
end

namespace :generate do
    desc 'Generates a model file (parameters: NAME)'
    task :model do
        unless ENV.has_key? 'NAME'
            puts "\n\e[91mERR\e[0m » Model name must be specified e.g. rake generate:model NAME=User", ?=*69
            next
        end

        name = ENV['NAME'].singularize.camelize
        file_name = "#{ENV['NAME'].singularize.underscore}.rb"
        file_path = "#{File.dirname(__FILE__)}/app/models/#{file_name}"
        spec_name = "#{file_name.gsub('.rb','')}_spec.rb"
        spec_path = "#{File.dirname(__FILE__)}/spec/models/#{spec_name}"

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
        if File.exist? spec_path
            puts "\n\e[91mERR\e[0m » Model spec 'spec/models/#{spec_name}' already exists.", ?=*(47+spec_name.length)
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
            puts "\n\e[90mCreated a new model spec at\e[0m \e[32mspec/models/#{spec_name}\e[0m", ?=*(40+spec_name.length)
        end
    end

    desc 'Generates a controller file (parameters: NAME)'
    task :controller do
        unless ENV.has_key? 'NAME'
            puts "\n\e[91mERR\e[0m » Controller name must be specified e.g. rake generate:controller NAME=User", ?=*79
            next
        end

        file_name = ENV['NAME'].downcase.include?('controller') ? "#{ENV['NAME'].underscore}.rb" : "#{ENV['NAME'].singularize.underscore}_controller.rb"
        file_path = "#{File.dirname(__FILE__)}/app/controllers/#{file_name}"
        class_name = ENV['NAME'].downcase.include?('controller') ? ENV['NAME'].camelize : "#{ENV['NAME'].singularize.camelize}Controller"
        spec_name = "#{file_name.gsub('.rb','')}_spec.rb"
        spec_path = "#{File.dirname(__FILE__)}/spec/controllers/#{spec_name}"

        if File.exist? file_path
            puts "\n\e[91mERR\e[0m » Controller file 'app/controllers/#{file_name}' already exists."
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    require_relative 'application_controller'
                    class #{class_name} < ApplicationController
                        helpers #{class_name.gsub 'Controller', 'Helper'}
                    end
                EOF
            end
            puts "\n\e[90mCreated a new controller file at\e[0m \e[32mapp/controllers/#{file_name}\e[0m"
        end
        if File.exist? spec_path
            puts "\n\e[91mERR\e[0m » Controller spec 'spec/controllers/#{spec_name}' already exists.", ?=*(57+spec_name.length)
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
            puts "\n\e[90mCreated a new controller spec at\e[0m \e[32mspec/controllers/#{spec_name}\e[0m", ?=*(50+spec_name.length)
        end
    end

    desc 'Generates a helper file (parameters: NAME)'
    task :helper do
        unless ENV.has_key? 'NAME'
            puts "\n\e[91mERR\e[0m » Helper name must be specified e.g. rake generate:helper NAME=User", ?=*71
            next
        end

        file_name = ENV['NAME'].downcase.include?('helper') ? "#{ENV['NAME'].underscore}.rb" : "#{ENV['NAME'].singularize.underscore}_helper.rb"
        file_path = File.dirname(__FILE__)+'/app/helpers/'+file_name
        module_name = ENV['NAME'].downcase.include?('helper') ? ENV['NAME'].camelize : "#{ENV['NAME'].singularize.camelize}Helper"

        if File.exist? file_path
            puts "\n\e[91mERR\e[0m » Helper file 'app/helpers/#{file_name}' already exists.", ?=*(48+file_name.length)
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    module #{module_name}
                        # Add your methods...
                    end
                EOF
            end
            puts "\n\e[90mCreated a new helper file at\e[0m \e[32mapp/helpers/#{file_name}\e[0m", ?=*(41+file_name.length)
        end
    end

    desc 'Generates a scaffold (parameters: NAME, CONTROLLER, HELPER, MODEL)'
    task :scaffold do
        unless ENV.has_key? 'NAME'
            puts "\n\e[91mERR\e[0m » Scaffold name must be specified e.g. rake generate:scaffold NAME=User", ?=*75
            next
        end
        sh "rake generate:helper NAME=#{ENV['NAME']}" if ENV['HELPER'].nil? || ENV['HELPER'].downcase == 'true'
        sh "rake generate:controller NAME=#{ENV['NAME']}" if ENV['CONTROLLER'].nil? || ENV['CONTROLLER'].downcase == 'true'
        sh "rake generate:model NAME=#{ENV['NAME']}" if ENV['MODEL'].nil? || ENV['MODEL'].downcase == 'true'
    end
end