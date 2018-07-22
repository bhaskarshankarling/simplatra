require 'simplatra/cli/error'
require 'simplatra/cli/blog/helpers'
require 'front_matter_parser'
require 'thor'

module Simplatra
  class Edit < Thor
    include Thor::Actions

    desc "urltitle [URLTITLE]", "Edits the urltitle of a blog post"
    def urltitle(urltitle = nil)
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')

        article_base = File.join directory, 'app', 'views', 'blog', 'markdown'
        article_asset_base = File.join directory, 'app', 'assets', 'images', 'blog'
        articles = Dir[File.join article_base, '**/*.md']

        if articles.empty?
          Simplatra::Error.no_articles
          return
        end

        if urltitle
          urltitle = urltitle.downcase
          if articles.any? {|a| File.basename(a, '.md') == urltitle}
            articles = articles.select {|a| File.basename(a, '.md') == urltitle}
          else
            Simplatra::Error.no_articles
            return
          end
        end

        articles_hash = build_article_hash(articles, article_base)
        article_number = ask("\nEnter the number of the article to edit:", limited_to: articles_hash.keys.map(&:to_s))
        article = articles_hash[article_number.to_sym]

        current_urltitle = article[:front_matter]['urltitle']
        new_urltitle = ask("Enter new urltitle:").parameterize
        update = ask("\e[1;93mWARNING\e[0m: Change urltitle from \e[1m#{current_urltitle}\e[0m to \e[1m#{new_urltitle}\e[0m?", limited_to: %w[y Y Yes YES n N No NO])

        return unless %w[y Y Yes YES].include? update

        Dir.chdir(File.join article_base, article[:date]) do
          new_content = File.read(article[:base_name]).dup
          new_content.sub! /urltitle\:.*\n/, "urltitle: \"#{new_urltitle}\"\n"
          new_content.gsub! /\/assets\/blog\/#{article[:date]}\/#{current_urltitle}/, "/assets/blog/#{article[:date]}/#{new_urltitle}"

          File.open(article[:base_name], "w") {|file| file.puts new_content}
          FileUtils.mv(article[:base_name], "#{new_urltitle}.md")
        end

        Dir.chdir(File.join article_asset_base, article[:date]) do
          FileUtils.mv(File.basename(article[:base_name], '.md'), new_urltitle)
        end

      else
        Simplatra::Error.wrong_directory
      end
    end

    no_tasks do
      include Simplatra::Blog::Helpers
    end

  end
end