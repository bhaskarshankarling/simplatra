require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'active_support/core_ext'
require './app.rb'

namespace :generate do
    desc 'Generates a new model class file in app/models (parameters: NAME)'
    task :model do
        unless ENV.has_key? 'NAME'
          raise "ERR » Model name must be specified e.g. rake generate:model NAME=User"
        end

        name = ENV['NAME'].camelize
        file_name = ENV['NAME'].underscore+'.rb'
        file_path = File.dirname(__FILE__)+'/app/models/'+file_name

        if File.exist? file_path
          raise "ERR » Model file '#{file_path}' already exists."
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    class #{name} < ActiveRecord::Base
                        # Add your model methods here...
                    end
                EOF
            end
        end
    end

    desc 'Generates a new controller class file in app/controllers (parameters: NAME)'
    task :controller do
        unless ENV.has_key? 'NAME'
            raise "ERR » Controller name must be specified e.g. rake generate:controller NAME=User"
        end

        file_name = ENV['NAME'].underscore+'.rb'
        file_path = File.dirname(__FILE__)+'/app/controllers/'+file_name

        if File.exist? file_path
            raise "ERR » Controller file '#{file_path}' already exists."
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    class Application < Sinatra::Base
                        # Add your routes here...
                    end
                EOF
            end
        end
    end

    desc 'Generates a new helper class file in app/helpers (parameters: NAME)'
    task :helper do
        unless ENV.has_key? 'NAME'
            raise "ERR » Helper name must be specified e.g. rake generate:helper NAME=User"
        end

        file_name = ENV['NAME'].underscore+'.rb'
        file_path = File.dirname(__FILE__)+'/app/helpers/'+file_name

        if File.exist? file_path
            raise "ERR » Helper file '#{file_path}' already exists."
        else
            File.open(file_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    class Application < Sinatra::Base
                        module Helpers
                            # Add your helper methods here...
                        end
                    end
                EOF
            end
        end
    end
end