require 'simplatra/generators/blog'
require 'simplatra/cli/error'
require 'simplatra/cli/blog/article/edit'
require 'simplatra/cli/blog/helpers'
require 'front_matter_parser'
require 'thor'

module Simplatra
  class Article < Thor
    include Thor::Actions
    include Simplatra::Blog::Helpers

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

    desc "generate [URLTITLE]", "Create a new blog article"
    def generate(urltitle)
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        generator = Simplatra::Generators::Blog.new
        generator.destination_root = directory
        generator.article(urltitle: urltitle)
      else
        Simplatra::Error.wrong_directory
      end
    end

    desc "destroy [URLTITLE]", "Destroys a blog article"
    def destroy(urltitle = nil)
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        markdown_base = File.join directory, 'app', 'views', 'blog', 'markdown'
        articles_path = urltitle ? "**/#{urltitle}.md" : "**/*.md"

        articles = Dir[File.join markdown_base, articles_path]
        if articles.empty?
          Simplatra::Error.no_articles
          return
        end

        Simplatra::Error.delete_article_warning; puts

        asset_base = File.join directory, 'app', 'assets', 'images', 'blog'
        articles_hash = {}
        article_numbers = []
        articles.each_with_index do |article, i|
          article_numbers << (i+1).to_s
          identifier = article.split(markdown_base.gsub(/\/$/,'')<<?/).last.split('.md').first
          articles_hash[(i+1).to_s.to_sym] = identifier
          title = FrontMatterParser::Parser.parse_file(article).front_matter['title']
          puts title ? "\e[1m#{i+1}\e[0m: #{identifier} - #{title}" : "\e[1m#{i+1}\e[0m: #{identifier}"
        end

        article_number = ask("\nEnter the number of the article to delete:", limited_to: article_numbers)
        article = articles_hash[article_number.to_sym]
        delete_article = ask("\e[1;93mWARNING\e[0m: Delete article \e[1m#{article}\e[0m?", limited_to: %w[y Y Yes YES n N No NO])
        return unless %w[y Y Yes YES].include? delete_article
        remove_file File.join(markdown_base, "#{article}.md")
        paths = article.rpartition ?/
        Dir.chdir(File.join asset_base, paths.first) { FileUtils.rm_rf paths.last }

        clean_directory(asset_base)
        clean_directory(markdown_base)
      else
        Simplatra::Error.wrong_directory
      end
    end

    def self.banner(task, namespace = false, subcommand = true)
      "#{basename} blog #{task.formatted_usage(self, true, subcommand).split(':').join(' ')}"
    end

    register(Edit, 'edit', 'edit [COMMAND]', 'Edit blog articles')
  end
end