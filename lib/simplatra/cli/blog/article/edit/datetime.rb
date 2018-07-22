require 'simplatra/cli/error'
require 'simplatra/cli/blog/helpers'
require 'front_matter_parser'
require 'thor'

module Simplatra
  class Edit < Thor
    include Thor::Actions

    desc "datetime [URLTITLE]", "Edits the datetime of a blog post"
    def datetime(urltitle = nil)
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

        current_datetime = article[:front_matter]['time']
        puts "\n\tCurrent datetime: \e[1m#{current_datetime}\e[0m"

        new_datetime = ''
        loop do
          new_datetime = ask("\nEnter the new datetime (format YYYY-MM-DD HH:MM:SS):")
          valid = false
          begin
            DateTime.strptime(new_datetime, "%Y-%m-%d %H:%M:%S").tap do |output|
              valid = output.strftime("%Y-%m-%d %H:%M:%S") == new_datetime
            end
          rescue ArgumentError
            puts "\e[1;91mERROR\e[0m: Incorrect datetime format."
          end
          break if valid
        end

        new_date, new_time = new_datetime.split
        current_date, current_time = current_datetime.split

        update = ask("\e[1;93mWARNING\e[0m: Change datetime from \e[1m#{current_datetime}\e[0m to \e[1m#{new_datetime}\e[0m?", limited_to: %w[y Y Yes YES n N No NO])
        return unless %w[y Y Yes YES].include? update

        Dir.chdir(File.join article_base, article[:date]) do
          new_content = File.read(article[:base_name]).dup
          new_content.sub! /time\:.*\n/, "time: \"#{new_datetime}\"\n"
          new_content.gsub!(
            "/assets/blog/#{current_date.gsub(?-,?/)}/#{article[:front_matter]['urltitle']}",
            "/assets/blog/#{new_date.gsub(?-,?/)}/#{article[:front_matter]['urltitle']}"
          )
          File.open(article[:base_name], "w") {|file| file.puts new_content}
        end

        Dir.chdir(article_asset_base) do
          relative_from_urltitle = File.join
          asset_files = Dir[File.join article[:identifier], '**/*']
          asset_files.each do |file|
            next unless File.file? file
            path_to_urltitle = File.join article_asset_base, article[:identifier]
            full_file_path = File.join article_asset_base, file
            relative_to_urltitle = full_file_path.split(path_to_urltitle.gsub(/\/$/,'')<<?/).last
            destination_date = File.join article_asset_base, new_date.gsub(?-,?/)
            destination = File.join destination_date, article[:front_matter]['urltitle'], relative_to_urltitle

            reset = Simplatra::Edit.source_root
            Simplatra::Edit.source_root(article_asset_base)
            copy_file file, destination
            Simplatra::Edit.source_root(reset)
            remove_file(full_file_path)
          end
          FileUtils.mkdir_p File.join(new_date.gsub(?-,?/), File.basename(article[:base_name], '.md'))
          FileUtils.rm_rf article[:identifier]
        end

        clean_directory(article_asset_base)

        Dir.chdir(article_base) do
          destination_directory = File.join new_date.gsub(?-,?/)
          FileUtils.mkdir_p(destination_directory)
          FileUtils.mv(article[:identifier] << '.md', destination_directory)
        end

        clean_directory(article_base)

      else
        Simplatra::Error.wrong_directory
      end
    end

    no_tasks do
      include Simplatra::Blog::Helpers
    end

  end
end