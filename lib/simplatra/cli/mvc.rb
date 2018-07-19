require_relative '../generators/mvc'
require_relative 'error'
require 'thor'

module Simplatra
    class MVC < Thor
        option :spec, type: :boolean, default: true, desc: "Include a model spec file"
        desc "model [NAME]", "Generates a model"
        def model(name)
            directory = File.expand_path ?.
            if File.exist? File.join(directory, '.simplatra')
                generator = Simplatra::Generators::MVC.new
                generator.destination_root = directory
                generator.model(name: name, spec: options[:spec])
            else
                Simplatra::Error.wrong_directory
            end
        end

        option :helper, type: :boolean, default: true, desc: "Include a controller helper file"
        option :spec, type: :boolean, default: true, desc: "Include a controller spec file"
        option :rest, aliases: '-r', type: :boolean, default: false,  desc: "Generate REST routes for the controller"
        desc "controller [NAME]", "Generates a controller"
        def controller(name)
            directory = File.expand_path ?.
            if File.exist? File.join(directory, '.simplatra')
                generator = Simplatra::Generators::MVC.new
                generator.destination_root = directory
                generator.controller(
                    name: name,
                    helper: options[:helper],
                    spec: options[:spec],
                    rest: options[:rest]
                )
            else
                Simplatra::Error.wrong_directory
            end
        end

        option :spec, type: :boolean, default: true, desc: "Include a helper spec file"
        desc "helper [NAME]", "Generates a helper"
        def helper(name)
            directory = File.expand_path ?.
            if File.exist? File.join(directory, '.simplatra')
                generator = Simplatra::Generators::MVC.new
                generator.destination_root = directory
                generator.helper(spec: options[:spec], name: name)
            else
                Simplatra::Error.wrong_directory
            end
        end

        option :helper, type: :boolean, default: true, desc: "Include a helper"
        option :helper_spec, type: :boolean, default: true, desc: "Include a helper spec"
        option :model, type: :boolean, default: true, desc: "Include a model"
        option :model_spec, type: :boolean, default: true, desc: "Include a model spec"
        option :controller, type: :boolean, default: true, desc: "Include a controller"
        option :controller_spec, type: :boolean, default: true, desc: "Include a controller spec"
        option :rest, aliases: '-r', type: :boolean, default: false,  desc: "Generate REST routes for the controller"
        desc "scaffold [NAME]", "Generates a scaffold"
        def scaffold(name)
            directory = File.expand_path ?.
            if File.exist? File.join(directory, '.simplatra')
                generator = Simplatra::Generators::MVC.new
                generator.destination_root = directory
                generator.scaffold(
                    name: name,
                    helper: options[:helper],
                    helper_spec: options[:helper_spec],
                    model: options[:model],
                    model_spec: options[:model_spec],
                    controller: options[:controller],
                    controller_spec: options[:controller_spec],
                    rest: options[:rest]
                )
            else
                Simplatra::Error.wrong_directory
            end

        end

        def self.banner(task, namespace = false, subcommand = true)
            task.formatted_usage(self, true, subcommand).split(':').join(' ')
        end
    end

    class CLI < Thor
        register(MVC, 'mvc', 'mvc [COMMAND]', 'Generating models, controllers and helpers')
    end
end