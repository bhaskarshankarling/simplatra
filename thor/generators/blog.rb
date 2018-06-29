require './config/root'
require 'active_support'
require 'active_support/core_ext'
require 'string/builder'
require 'front_matter_parser'
require 'bundler'
Bundler.require :thor

module Simplatra
    module Generators
        class Blog < Thor::Group
            using String::Builder
            include Thor::Actions
            desc 'Generate blog files'

            TEMPLATES =  "#{Simplatra::ROOT}/thor/generators/templates"

            def self.source_root() TEMPLATES end

            def post(urltitle:)
                dt = Hash.new
                dt[:full] = Time.now.strftime("%Y-%m-%d %H:%M:%S")
                dt[:date] = dt[:full].split(' ').first

                # Assets path generation
                asset_base = "#{Simplatra::ROOT}/app/assets/images/posts"
                asset_path = asset_base.build do |s|
                    s << "/#{dt[:date].gsub(?-,?/)}"
                    s << "/#{urltitle}"
                end

                empty_directory(asset_path)

                # Markdown file and path generation
                post_base = "#{Simplatra::ROOT}/app/views/posts"
                post_path = String.build post_base do |s|
                    s << "/#{dt[:date].gsub(?-,?/)}"
                    s << "/#{urltitle}.md"
                end

                config = {datetime: dt[:full], date: dt[:date], urltitle: urltitle}

                template("#{TEMPLATES}/blog/post.tt", post_path, config)
            end

            def views
                config = {erb: ["<%= application :css, :js %>","<%= content %>"]}
                template("#{TEMPLATES}/blog/post.erb", "#{Simplatra::ROOT}/app/views/templates/post.erb", config)
                config = {erb: "<%= @posts %>"}
                template("#{TEMPLATES}/blog/blog.erb", "#{Simplatra::ROOT}/app/views/blog.erb", config)
                template("#{TEMPLATES}/blog/blog_search.erb", "#{Simplatra::ROOT}/app/views/blog_search.erb", config)
            end

            def helper
                template("#{TEMPLATES}/blog/helper.tt", "#{Simplatra::ROOT}/app/helpers/blog_helper.rb")
            end

            def controller(route:)
                route = route[0] == ?/ ? route : "/#{route}"
                config = {route: route}
                template("#{TEMPLATES}/blog/controller.tt", "#{Simplatra::ROOT}/app/controllers/blog_controller.rb", config)
                template("#{TEMPLATES}/blog/spec.tt", "#{Simplatra::ROOT}/spec/controllers/blog_controller_spec.rb")
            end

            def list
                chars = {corner: ?+, vertical: ?║, horizontal: ?═}

                files = Dir.glob("#{Simplatra::ROOT}/app/views/posts/**/*.md")
                return if files.empty?

                metadata = files.map{|md|FrontMatterParser::Parser.parse_file(md).front_matter.symbolize_keys}

                longest = 0
                metadata.each do |post|
                    post.each do |k,v|
                        next if k == :desc
                        str = "#{k}: #{v}"
                        longest = str.length if longest < str.length
                    end
                end

                output = String.build "\n" do |s|
                    s << (chars[:corner]+chars[:horizontal]*(longest+2)+chars[:corner]+"\n")
                    metadata.each do |post|
                        post.each do |k,v|
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
                            s << "#{k.to_s.colorize(:magenta)}: #{str[(k.to_s.length+2)..-1]}"
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