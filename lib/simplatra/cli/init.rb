require 'colorize'
require 'thor'

module Simplatra
    class CLI < Thor
        include Thor::Actions
        desc "init [NAME]", "Sets up the application"
        def init(name)
            current_directory = File.expand_path ?.

            if Dir.exist? File.join(current_directory, name)
                puts "#{"ERROR".colorize(:light_red).colorize(mode: :bold)}: Directory #{name.colorize(mode: :bold)} already exists."
                return
            end

            if Dir.exist? File.join(current_directory, 'frame')
                puts "#{"ERROR".colorize(:light_red).colorize(mode: :bold)}: Directory #{'frame'.colorize(mode: :bold)} already exists."
                return
            else
                Simplatra::CLI.source_root(File.dirname(File.dirname(__FILE__)))
                directory 'frame', File.join(current_directory, name)
            end
        end
    end
end