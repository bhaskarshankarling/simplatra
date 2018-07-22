require 'simplatra/cli/error'
require 'simplatra/cli/blog/article'
require 'simplatra/cli/blog/article/edit/urltitle'
require 'simplatra/cli/blog/article/edit/datetime'
require 'thor'

module Simplatra
  class Edit < Thor
    include Thor::Actions
    def self.banner(task, namespace = false, subcommand = true)
      "#{basename} blog article #{task.formatted_usage(self, true, subcommand).split(':').join(' ')}"
    end
  end
end