require 'active_support'
require 'active_support/core_ext'
require 'string/builder'
require 'front_matter_parser'
require 'simplatra/cli/blog/helpers'
require 'thor'

module Simplatra
  module Generators
    class Blog < Thor::Group
      using String::Builder
      include Simplatra::Blog::Helpers
      using Array::DateSort
      include Thor::Actions
      TEMPLATES = "#{File.dirname(__FILE__)}/templates"

      def self.source_root() TEMPLATES end

      def article(urltitle:)
        dt = Hash.new
        dt[:full] = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        dt[:date] = dt[:full].split(' ').first

        # Assets path generation
        asset_base = "app/assets/images/blog"
        asset_path = asset_base.build do |s|
          s << "/#{dt[:date].gsub(?-,?/)}"
          s << "/#{urltitle}"
        end

        empty_directory(asset_path)

        # Markdown file and path generation
        article_base = "app/views/blog/markdown"
        article_path = article_base.build do |s|
          s << "/#{dt[:date].gsub(?-,?/)}"
          s << "/#{urltitle}.md"
        end

        config = {datetime: dt[:full], date: dt[:date], urltitle: urltitle}
        template("blog/article_md.tt", article_path, config)
      end

      def views
        config = {erb: ["<%= application :css, :js %>","<%= yield %>"]}
        template("blog/article_layout.erb", "app/views/layouts/blog/article.erb", config)
        template("blog/articles_layout.erb", "app/views/layouts/blog/articles.erb", config)

        config = {erb: "<%= content %>"}
        template("blog/article.erb", "app/views/blog/article.erb", config)

        config = {erb: "<%= @articles %>"}
        template("blog/articles.erb", "app/views/blog/articles.erb", config)
        template("blog/search.erb", "app/views/blog/search.erb", config)
      end

      def helper
        template("blog/helper.tt", "app/helpers/blog_helper.rb")
        template("blog/helper_spec.tt", "spec/helpers/blog_helper_spec.rb")
      end

      def controller(route:)
        route = route[0] == ?/ ? route : "/#{route}"
        config = {route: route}
        template("blog/controller.tt", "app/controllers/blog_controller.rb", config)
        template("blog/controller_spec.tt", "spec/controllers/blog_controller_spec.rb", config)
      end

      def list(order:)
        chars = {corner: ?+, vertical: ?║, horizontal: ?═}

        files = Dir.glob(File.join(self.destination_root,"app/views/blog/markdown/**/*.md"))
        return if files.empty?

        metadata = files.map{|md|FrontMatterParser::Parser.parse_file(md).front_matter.symbolize_keys}
        metadata.sort_by_date!(order: order)

        longest = 0
        metadata.each do |article|
          article.each do |k,v|
            next if %i[desc datetime].include? k
            str = "#{k}: #{v}"
            longest = str.length if longest < str.length
          end
        end

        output = String.build "\n" do |s|
          s << (chars[:corner]+chars[:horizontal]*(longest+2)+chars[:corner]+"\n")
          metadata.each do |article|
            article.each do |k,v|
              next if k == :datetime
              str = "#{k}: #{v}"
              if k == :desc
                value = v.to_s
                rel = longest-(k.length+5) # 5 is from ": " and "..."
                unless str.length <= longest
                  str = "#{k}: #{value.length > rel ? "#{value[0...rel]}..." : value}"
                end
              end
              len = str.ljust(longest,' ').length-str.length
              s << "#{chars[:vertical]} "
              s << "\e[95m#{k.to_s}\e[0m: #{str[(k.to_s.length+2)..-1]}"
              s << ' '*len
              s << " #{chars[:vertical]}\n"
            end
            s << (chars[:corner]+chars[:horizontal]*(longest+2)+chars[:corner]+"\n")
          end
        end

        puts output
      end

    end
  end
end