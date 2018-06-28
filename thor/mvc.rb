require './config/root'
require 'colorize'
require 'active_support'
require 'active_support/core_ext'
require 'bundler'
Bundler.require :thor

module Simplatra
    class MVC < Thor
        method_options :"no-spec" => false
        map %w[--no-spec] => :"no-spec"
        desc "model [NAME]", "Generates a model"
        def model(name)
            Simplatra::Generators::MVC.new.model(name: name, spec: !options[:"no-spec"])
        end

        method_options :"no-helper" => false, :"no-spec" => false
        map %w[--no-helper] => :"no-helper", %w[--no-spec] => :"no-spec"
        desc "controller [NAME]", "Generates a controller"
        def controller(name)
            Simplatra::Generators::MVC.new.controller(
                name: name,
                helper: !options[:"no-helper"],
                spec: !options[:"no-spec"]
            )
        end

        desc "helper [NAME]", "Generates a helper"
        def helper(name)
            Simplatra::Generators::MVC.new.helper(name: name)
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
            Simplatra::Generators::MVC.new.scaffold(
                name: name,
                helper: !options[:"no-helper"],
                model: !options[:"no-model"],
                model_spec: !options[:"no-model-spec"],
                controller: !options[:"no-controller"],
                controller_spec: !options[:"no-controller-spec"]
            )
        end

        def self.banner(task, namespace = false, subcommand = true)
            task.formatted_usage(self, true, subcommand).split(':').join(' ')
        end
    end

    class CLI < Thor
        register(MVC, 'mvc', 'mvc [COMMAND]', 'Generating models, controllers and helpers')
    end
end