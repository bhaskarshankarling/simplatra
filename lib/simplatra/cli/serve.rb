require_relative 'error'
require 'thor'
require 'colorize'

module Simplatra
  class CLI < Thor
    method_options :rerun => false
    map %w[--rerun] => :rerun
    desc "serve [PORT]", "Serves your application."
    def serve(port = 9292)
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        cmd = if options[:rerun]
          "rerun --quiet bundle exec thin start -p #{port}"
        else
          "bundle exec thin start -p #{port}"
        end
        puts "#{"RUN".colorize(:green).colorize(mode: :bold)}: #{cmd}"
        %x{#{cmd}}
      else
        Simplatra::Error.wrong_directory
      end
    end
  end
end