require 'simplatra/generators/blog'
require 'simplatra/cli/error'
require 'simplatra/cli/blog_article'
require 'front_matter_parser'
require 'thor'

module Simplatra
  class Blog < Thor
    include Thor::Actions

    method_option :route, type: :string, aliases: '-r', default: 'blog'
    desc "setup", "Sets up the blog-aware environment"
    def setup
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        generator = Simplatra::Generators::Blog.new
        generator.destination_root = directory
        generator.helper
        generator.controller(route: options[:route])
        generator.views
      else
        Simplatra::Error.wrong_directory
      end
    end

    def self.banner(task, namespace = false, subcommand = true)
      basename + ' ' + task.formatted_usage(self, true, subcommand).split(':').join(' ')
    end

    register(Article, 'article', 'article [COMMAND]', 'Create, edit and destroy blog articles')
  end

  class CLI < Thor
    register(Blog, 'blog', 'blog [COMMAND]', 'Blog/article related commands')
  end
end