require_relative '../generators/mvc'
require_relative 'error'
require 'thor'

module Simplatra
    class MVC < Thor
        method_options :"no-spec" => false
        map %w[--no-spec] => :"no-spec"
        desc "model [NAME]", "Generates a model"
        def model(name)
            directory = File.expand_path ?.
            if File.exist? File.join(directory, '.simplatra')
                generator = Simplatra::Generators::MVC.new
                generator.destination_root = directory
                generator.model(name: name, spec: !options[:"no-spec"])
            else
                Simplatra::Error.wrong_directory
            end
        end

        method_options :"no-helper" => false, :"no-spec" => false
        map %w[--no-helper] => :"no-helper", %w[--no-spec] => :"no-spec"
        desc "controller [NAME]", "Generates a controller"
        def controller(name)
            directory = File.expand_path ?.
            if File.exist? File.join(directory, '.simplatra')
                generator = Simplatra::Generators::MVC.new
                generator.destination_root = directory
                generator.controller(
                    name: name,
                    helper: !options[:"no-helper"],
                    spec: !options[:"no-spec"]
                )
            else
                Simplatra::Error.wrong_directory
            end
        end

        desc "helper [NAME]", "Generates a helper"
        def helper(name)
            directory = File.expand_path ?.
            if File.exist? File.join(directory, '.simplatra')
                generator = Simplatra::Generators::MVC.new
                generator.destination_root = directory
                generator.helper(name: name)
            else
                Simplatra::Error.wrong_directory
            end
        end

        method_options(
            :"no-model" => false,
            :"no-model-spec" => false,
            :"no-controller" => false,
            :"no-controller-spec" => false,
            :"no-helper" => false
        )
        map(
            %w[--no-model] => :"no-model",
            %w[--no-model-spec] => :"no-model-spec",
            %w[--no-controller] => :"no-controller",
            %w[--no-controller-spec] => :"no-controller-spec",
            %w[--no-helper] => :"no-helper"
        )
        desc "scaffold [NAME]", "Generates a scaffold"
        def scaffold(name)
            directory = File.expand_path ?.
            if File.exist? File.join(directory, '.simplatra')
                generator = Simplatra::Generators::MVC.new
                generator.destination_root = directory
                generator.scaffold(
                    name: name,
                    helper: !options[:"no-helper"],
                    model: !options[:"no-model"],
                    model_spec: !options[:"no-model-spec"],
                    controller: !options[:"no-controller"],
                    controller_spec: !options[:"no-controller-spec"]
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