require './config/root'
require 'colorize'
require 'active_support'
require 'active_support/core_ext'
require 'bundler'
Bundler.require :thor

module Simplatra
    class CLI < Thor
        method_options :"no-gitkeep" => false
        map %w[--no-gitkeep] => :"no-gitkeep"

        desc "setup [NAME]", "Sets up the application"
        def setup(name)
            current_directory_name = File.basename Simplatra::ROOT
            parent_directory = File.dirname Simplatra::ROOT
            new_directory_path = "#{parent_directory}/#{name}"

            if File.directory? new_directory_path
                message = "\n#{"ERR".colorize(:light_red)} » '#{new_directory_path}' already exists"
                puts message, ?=*(message.uncolorize.length-1)
            else
                %x(rm -rf .git)
                %x(find . -name ".gitkeep" -exec rm -rf {} \\;) if options[:"no-gitkeep"]
                %x(rm README.md) if File.exist? 'README.md'
                Dir.chdir '..'
                %x(mv #{current_directory_name} #{name})
                Dir.chdir name
                puts "#{"Setup complete, refresh directory with `cd .`".colorize(:green)}"
            end
        end
    end
end