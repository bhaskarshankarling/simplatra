require './config/root'
require 'active_support'
require 'active_support/core_ext'
require 'bundler'
Bundler.require :thor

module Simplatra
    class Blog < Thor
        desc "post [URLTITLE]", "Generates a blog post"
        def post(urltitle)
            Simplatra::Generators::Blog.new.post(urltitle: urltitle)
        end

        desc "setup [ROUTE]", "Sets up the blogging environment (controller, spec and helper)"
        def setup(route = '/blog')
            generator = Simplatra::Generators::Blog.new
            generator.helper
            generator.controller(route: route)
            generator.views
        end

        desc "list", "Pretty-print the metadata of all blog posts"
        def list
            Simplatra::Generators::Blog.new.list
        end

        def self.banner(task, namespace = false, subcommand = true)
            task.formatted_usage(self, true, subcommand).split(':').join(' ')
        end
    end

    class CLI < Thor
        register(Blog, 'blog', 'blog [COMMAND]', 'Configure blog environment and generate posts')
    end
end