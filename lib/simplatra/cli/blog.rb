require_relative '../generators/blog'
require_relative 'error'
require 'thor'

module Simplatra
  class Blog < Thor
    desc "article [URLTITLE]", "Generates a blog article"
    def article(urltitle)
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        generator = Simplatra::Generators::Blog.new
        generator.destination_root = directory
        generator.article(urltitle: urltitle)
      else
        Simplatra::Error.wrong_directory
      end
    end

    desc "setup [ROUTE]", "Sets up the blogging environment (controller, spec and helper)"
    def setup(route = '/blog')
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        generator = Simplatra::Generators::Blog.new
        generator.destination_root = directory
        generator.helper
        generator.controller(route: route)
        generator.views
      else
        Simplatra::Error.wrong_directory
      end
    end

    desc "list", "Pretty-print the metadata of all blog articles"
    def list
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        generator = Simplatra::Generators::Blog.new
        generator.destination_root = directory
        generator.list
      else
        Simplatra::Error.wrong_directory
      end
    end

    def self.banner(task, namespace = false, subcommand = true)
      task.formatted_usage(self, true, subcommand).split(':').join(' ')
    end
  end

  class CLI < Thor
    register(Blog, 'blog', 'blog [COMMAND]', 'Configure blog environment and generate articles')
  end
end