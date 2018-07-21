require 'simplatra/cli/error'
require 'simplatra/cli/blog'
require 'simplatra/version'
require 'thor'

module Simplatra
  class CLI < Thor
    include Thor::Actions
    method_option :blog, type: :hash, lazy_default: {}, aliases: '-b'
    desc "init [NAME]", "Sets up the application"
    def init(name)
      current_directory = File.expand_path ?.
      root = File.join(current_directory, name)
      if Dir.exist? root
        puts "\e[1;91mERROR\e[0m: Directory \e[1m#{name}\e[0m already exists."
        return
      end
      if Dir.exist? File.join(current_directory, 'frame')
        puts "\e[1;91mERROR\e[0m: Directory \e[1mframe\e[0m already exists."
        return
      else
        Simplatra::CLI.source_root(File.dirname(__dir__))
        directory 'frame', root
        Dir.chdir(root) {
          puts "#{' '*6}\e[1;90mchdir\e[0m  #{name}"
          args = %w[blog setup]
          unless options[:blog].empty?
            route = options[:blog]['route']
            args.concat(route ? ['-r', route] : [])
          end
          Simplatra::CLI.start(args)
        } unless options[:blog].nil?
      end
    end

    method_option :port, type: :numeric, aliases: '-p'
    desc "serve [ENV]", "Serves your application"
    def serve(env = ENV['RACK_ENV']||'development')
      unless %w[production development test].include? env
        puts "\e[1;91mERROR\e[0m: Invalid Rack environment \e[1m#{env}\e[0m."
        return
      end

      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        cmd = "bundle exec rackup -p #{options[:port]||9292}"
        puts "Running command: \e[1m#{cmd}\e[0m"
        puts "Rack environment: \e[1m#{env}\e[0m"
        exec "env RACK_ENV=#{env} #{cmd}"
      else
        Simplatra::Error.wrong_directory
      end
    end

    desc "spec", "Run all application specs"
    def spec
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        exec "rspec -fd spec"
      else
        Simplatra::Error.wrong_directory
      end
    end

    map %w[--version -v] => :__print_version
    desc "--version, -v", "Display installed Simplatra version"
    def __print_version
      puts Simplatra::VERSION
    end
  end
end