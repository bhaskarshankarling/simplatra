namespace :blog do
    using String::Builder

    desc 'Sets up the blog environment (parameters: ROUTE)'
    task :setup do
        route = ENV['ROUTE'] ||= 'blog'
        route = route.sub(?/,'') if route.start_with?(?/)

        sh "rake mvc:gen:helper NAME=blog"
        sh "rake blog:controller ROUTE=#{route}"

        layout_path = "#{Simplatra::ROOT}/app/views/templates/post.erb"
        if File.exist? layout_path
            puts "\n#{"ERR".colorize(:light_red)} » Post layout '#{layout_path}' already exists."
        else
            File.open(layout_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    <html>
                        <head>
                        <title></title>
                            <%= application :css, :js %>
                        </head>
                        <body>
                            <%= content %>
                        </body>
                    </html>
                EOF
            end
            puts "\n#{"Created post layout at".colorize(:light_black)} #{layout_path.colorize(:green)}"
        end

        blog_path = "#{Simplatra::ROOT}/app/views/blog.erb"
        if File.exist? blog_path
            puts "\n#{"ERR".colorize(:light_red)} » Blog view '#{blog_path}' already exists."
        else
            sh "touch #{blog_path}"
            puts "\n#{"Created blog view at".colorize(:light_black)} #{blog_path.colorize(:green)}"
        end

        blog_search_path = "#{Simplatra::ROOT}/app/views/blog_search.erb"
        if File.exist? blog_search_path
            message = "\n#{"ERR".colorize(:light_red)} » Blog search view '#{blog_search_path}' already exists."
            puts message, ?=*(message.uncolorize.length-1)
        else
            sh "touch #{blog_search_path}"
            message = "\n#{"Created blog search view at".colorize(:light_black)} #{blog_search_path.colorize(:green)}"
            puts message, ?=*(message.uncolorize.length-1)
        end
    end

    namespace :post do

        desc 'Creates a new post (parameters: URLTITLE, HEADER)'
        task :gen do
            asset_base = "#{Simplatra::ROOT}/app/assets/images/posts"
            sh "mkdir #{asset_base}" unless File.directory? asset_base

            unless ENV.has_key? 'URLTITLE'
                message = "\n#{"ERR".colorize(:light_red)} » Post urltitle must be specified e.g. rake blog:post:gen URLTITLE=simplatra-blog-aware"
                puts message, ?=*(message.uncolorize.length-1)
                next
            end

            urltitle = ENV['URLTITLE']

            dt = Hash.new
            dt[:full] = Time.now.strftime("%Y-%m-%d %H:%M:%S")
            dt[:date] = dt[:full].split(' ').first

            # Assets file and path generation
            asset_path = String.build do |s|
                s << Simplatra::ROOT
                s << '/app/assets/images/posts'
                s << "/#{urltitle}"
            end

            sh "mkdir #{asset_path}" unless File.directory? asset_path

            header = ENV['HEADER']
            unless (header == nil) || (header.downcase == 'false')
                header_file = (header.downcase == 'true') ? 'header' : header
                sh "touch #{asset_path}/#{header_file}.png"
            end

            # Markdown file and path generation
            post_base = String.build do |s|
                s << Simplatra::ROOT
                s << '/app/views/posts'
            end

            sh "mkdir #{post_base}" unless File.directory? post_base

            post_path = String.build do |s|
                s << post_base
                s << "/#{dt[:date].gsub(?-,?/)}"
                s << "/#{urltitle}.md"
            end

            y, m, d = dt[:date].split ?-
            sh "mkdir #{post_base}/#{y}" unless File.directory? "#{post_base}/#{y}"
            sh "mkdir #{post_base}/#{y}/#{m}" unless File.directory? "#{post_base}/#{y}/#{m}"
            sh "mkdir #{post_base}/#{y}/#{m}/#{d}" unless File.directory? "#{post_base}/#{y}/#{m}/#{d}"

            if File.exist? post_path
                message = "\n#{"ERR".colorize(:light_red)} » Post '#{post_path}' already exists."
                puts message, ?=*(message.uncolorize.length-1)
            else
                File.open(post_path, 'w+') do |f|
                    f.write(<<-EOF.strip_heredoc)
                        ---
                        title: "TODO"
                        desc: "TODO"
                        tags: ["TODO"]
                        # Only change the below front-matter with the `blog:post:edit` rake task
                        time: "#{dt[:full]}"
                        urltitle: "#{urltitle}"
                        assetpath: "/assets/posts/#{urltitle}/"
                        ---
                    EOF
                end
                message = "\n#{"Created a post at".colorize(:light_black)} #{post_path.colorize(:green)}"
                puts message, ?=*(message.uncolorize.length-1)
            end
        end

    end

    desc 'Creates a blog controller (parameters: ROUTE)'
    task :controller do
        # Array.sort_by_date monkey-patch
        initializer_file = "#{Simplatra::ROOT}/config/initializers/sort_by_date.rb"
        if File.exist? initializer_file
            puts "\n#{"ERR".colorize(:light_red)} » Initializer file '#{initializer_file}' already exists."
        else
            File.open(initializer_file, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    module Array::DateSort
                        refine Array do
                            def sort_by_date(order: :descending)
                                obj = self.map!{|x|x['datetime'] = Date.strptime(x['time'], "%Y-%m-%d %H:%M:%S"); x}
                                if order == :descending
                                    obj.sort!{|x1, x2| x2['datetime'] <=> x1['datetime']}
                                elsif order == :ascending
                                    obj.sort!{|x1, x2| x1['datetime'] <=> x2['datetime']}
                                end
                            end
                        end
                    end
                EOF
            end
            puts "\n#{"Created an initializer file at".colorize(:light_black)} #{initializer_file.colorize(:green)}"
        end

        # Controller
        controller_file = "#{Simplatra::ROOT}/app/controllers/blog_controller.rb"
        if File.exist? controller_file
            puts "\n#{"ERR".colorize(:light_red)} » Controller file '#{controller_file}' already exists."
        else
            route = ENV['ROUTE'] ||= 'blog'
            route = route.sub(?/,'') if route.start_with?(?/)
            File.open(controller_file, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    require_relative 'application_controller'
                    Bundler.require :blog
                    require 'date'

                    class BlogController < ApplicationController
                        helpers BlogHelper
                        using Array::DateSort

                        FILES = Dir.glob("\#{Simplatra::ROOT}/app/views/posts/**/*.md")

                        get "/#{route}" do
                            @posts = FILES.map{|md|FrontMatterParser::Parser.parse_file(md).front_matter}
                            @posts.sort_by_date(order: :descending)
                            erb :blog
                        end

                        FILES.each do |md|
                            parsed = FrontMatterParser::Parser.parse_file(md)
                            yaml = {front_matter: parsed.front_matter, content: parsed.content}
                            subpath = yaml[:front_matter]['time'].split(' ').first.gsub(?-,?/)
                            get "/#{route}/\#{subpath}/\#{yaml[:front_matter]['urltitle']}" do
                                @front_matter = yaml[:front_matter]
                                erb :'templates/post', locals: {content: markdown(yaml[:content])}, layout: false
                            end
                        end

                        query = lambda do
                            @query = params[:query]
                            redirect "/#{route}" unless @query.match /^[a-zA-Z]+[a-zA-Z0-9\\-_.]*[a-zA-Z0-9]$/
                            @posts = FILES.map{|md|
                                FrontMatterParser::Parser.parse_file(md).front_matter
                            }.select{|post| post['tags'].any?{|tag| tag.include?(@query)}}
                            @posts.sort_by_date(order: :descending)
                            erb :blog_search
                        end
                        get "/#{route}/search/:query", &query
                        post "/#{route}/search/:query", &query

                        redirect_posts = ->{redirect '/#{route}'}
                        get "/#{route}/search", &redirect_posts
                        post "/#{route}/search", &redirect_posts
                    end
                EOF
            end
            puts "\n#{"Created a controller file at".colorize(:light_black)} #{controller_file.colorize(:green)}"
        end

        controller_spec_file = "#{Simplatra::ROOT}/app/spec/controllers/blog_controller_spec.rb"
        if File.exist? controller_spec_file
            message = "\n#{"ERR".colorize(:light_red)} » Controller spec file '#{controller_spec_file}' already exists."
            puts message, ?=*(message.uncolorize.length-1)
        else
            route = ENV['ROUTE'] ||= 'blog'
            route = route.sub(?/,'') if route.start_with?(?/)
            File.open(controller_spec_file, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    require_relative '../spec_helper'
                    require 'front_matter_parser'
                    describe BlogController do
                        def app() BlogController end

                        POSTS = Dir.glob("\#{Simplatra::ROOT}/app/views/posts/**/*.md").map do |md|
                            FrontMatterParser::Parser.parse_file(md).front_matter
                        end

                        describe 'blog page' do
                            # Implement this test!
                            it "should display all posts" do
                                expect(true).to eq(false)
                            end
                        end

                        POSTS.each do |post|
                            # Implement these tests!
                            describe "Post: \#{post['title']}" do
                                it "should have a timestamp" do
                                    get "/#{route}/\#{post['urltitle']}"
                                    expect(true).to eq(false)
                                end
                                it "should have a title" do
                                    get "/#{route}/\#{post['urltitle']}"
                                    expect(true).to eq(false)
                                end
                                it "should have a description" do
                                    get "/#{route}/\#{post['urltitle']}"
                                    expect(true).to eq(false)
                                end
                                it "should have tags" do
                                    get "/#{route}/\#{post['urltitle']}"
                                    post['tags'].each do |tag|
                                        expect(true).to eq(true)
                                    end
                                end
                            end
                        end
                    end
                EOF
            end
            message = "\n#{"Created a controller spec file at".colorize(:light_black)} #{controller_spec_file.colorize(:green)}"
            puts message, ?=*(message.uncolorize.length-1)
        end
    end
end