require 'colorize'

module Simplatra
  module Error
    class << self
      def wrong_directory
        puts "#{"ERROR".colorize(:light_red).colorize(mode: :bold)}: Couldn't find #{'.simplatra'.colorize(mode: :bold)} file in current directory."
        puts "#{"INFO".colorize(mode: :bold)}:"
        puts "  » Try changing the current working directory to your application's root directory."
        puts "  » Or try creating a new application with `#{"simplatra init your-app-name".colorize(mode: :bold)}`."
      end
    end
  end
end