module Simplatra
  module Error
    class << self
      def wrong_directory
        puts "\e[1;91mERROR\e[0m: Couldn't find \e[1m.simplatra\e[0m file in current directory."
        puts "\e[1mINFO\e[0m: Try:"
        puts " - Changing the current working directory to your application's root directory."
        puts " - Creating a new application with `\e[1msimplatra init your-app-name\e[0m`."
        puts " - Creating a .simplatra file if you deleted it."
      end

      def no_articles
        puts "\e[1;91mERROR\e[0m: Couldn't find any blog articles."
      end

      def delete_article_warning
        puts "\e[1;93mWARNING\e[0m: Deleting an article will delete both the markdown file and all assets!"
      end

      def no_mvc(mvc_file)
        puts "\e[1;91mERROR\e[0m: Couldn't find any #{mvc_file}s."
      end

      def no_scaffolds
        puts "\e[1;91mERROR\e[0m: Couldn't find any scaffolds."
      end
    end
  end
end