require 'simplatra/generators/mvc'
require 'simplatra/cli/error'
require 'thor'

module Simplatra
  class Generate < Thor
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

    option :no, aliases: '-n', type: :array, default: [], desc: "Omit specified scaffold files"
    option :rest, aliases: '-r', type: :boolean, default: false,  desc: "Generate REST routes for the controller"
    desc "scaffold [NAME]", "Generates a scaffold"
    def scaffold(name)
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        allowed = %i[
          helper h
          helper_spec hs
          model m
          model_spec ms
          controller c
          controller_spec cs
        ]
        opts = options[:no].map{|opt|opt.gsub(?-,?_).to_sym}
        legal = opts & allowed

        generator = Simplatra::Generators::MVC.new
        generator.destination_root = directory
        generator.scaffold(
          name: name,
          helper: !(legal & %i[helper h]).present?,
          helper_spec: !(legal & %i[helper_spec hs]).present?,
          model: !(legal & %i[model m]).present?,
          model_spec: !(legal & %i[model_spec ms]).present?,
          controller: !(legal & %i[controller c]).present?,
          controller_spec: !(legal & %i[controller_spec cs]).present?,
          rest: options[:rest]
        )
      else
        Simplatra::Error.wrong_directory
      end
    end

    def self.banner(task, namespace = false, subcommand = true)
      basename + ' ' + task.formatted_usage(self, true, subcommand).split(':').join(' ')
    end
  end

  class CLI < Thor
    register(Generate, 'generate', 'generate [COMMAND]', 'Generate models, controllers and helpers')
  end
end