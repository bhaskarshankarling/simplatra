module Simplatra
  module Error
    class << self
      def wrong_directory
        puts "\e[1;91mERROR\e[0m: Couldn't find \e[1m.simplatra\e[0m file in current directory."
        puts "\e[1mINFO\e[0m:"
        puts "  » Try changing the current working directory to your application's root directory."
        puts "  » Or try creating a new application with `\e[1msimplatra init your-app-name\e[0m`."
      end
    end
  end
end