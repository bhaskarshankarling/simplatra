require 'front_matter_parser'

module Simplatra
  class Blog < Thor
    module Helpers
      def clean_directory(base)
        Dir.chdir base do
          years = Dir[?*]
          years.each do |year|
            Dir.chdir year do
              months = Dir[?*]
              months.each do |month|
                Dir.chdir month do
                  days = Dir[?*]
                  days.each do |day|
                    FileUtils.rm_rf day if Dir.empty? day
                  end
                end
                FileUtils.rm_rf month if Dir.empty? month
              end
            end
            FileUtils.rm_rf year if Dir.empty? year
          end
        end
      end

      def build_article_hash(articles, article_base)
        articles_hash = Hash.new
        articles.each_with_index do |article,i|
          index_key = (i+1).to_s.to_sym
          articles_hash[index_key] = {}
          articles_hash[index_key][:path] = article
          articles_hash[index_key][:markdown] = article.split(article_base.gsub(/\/$/,'')<<?/).last
          articles_hash[index_key][:identifier] = articles_hash[index_key][:markdown].rpartition(?.).first
          articles_hash[index_key][:base_name] = File.basename articles_hash[index_key][:markdown]
          articles_hash[index_key][:date] = articles_hash[index_key][:identifier].rpartition(?/).first
          articles_hash[index_key][:front_matter] = FrontMatterParser::Parser.parse_file(
            articles_hash[index_key][:path]
          ).front_matter
          title = articles_hash[index_key][:front_matter]['title']
          output = "\e[1m#{index_key}\e[0m: #{articles_hash[index_key][:identifier]}"
          output << " - #{title}" if title
          puts output
        end
        articles_hash
      end
    end
  end
end