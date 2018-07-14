require_relative 'error'
require 'thor'
require 'colorize'

module Simplatra
  class CLI < Thor
    desc "serve [PORT]", "Serves your application."
    def serve(port = 9292)
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        cmd = "bundle exec rackup -p #{port}"
        puts "#{"RUN".colorize(:green).colorize(mode: :bold)}: #{cmd}"
        exec cmd
      else
        Simplatra::Error.wrong_directory
      end
    end
  end
end