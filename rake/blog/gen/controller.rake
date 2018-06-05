namespace :blog do
    namespace :gen do

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
                        end
                    EOF
                end
                puts "\n#{"Created a controller file at".colorize(:light_black)} #{controller_file.colorize(:green)}"
            end

            controller_spec_file = "#{Simplatra::ROOT}/spec/controllers/blog_controller_spec.rb"
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
                                            expect(true).to eq(false)
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
end