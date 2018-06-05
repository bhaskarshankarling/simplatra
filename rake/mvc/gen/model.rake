namespace :mvc do
    namespace :gen do

        desc 'Generates a model file (parameters: NAME)'
        task :model do
            unless ENV.has_key? 'NAME'
                puts "\n\e[91mERR\e[0m » Model name must be specified e.g. rake generate:model NAME=User", ?=*69
                next
            end

            name = ENV['NAME'].singularize.camelize
            file_name = "#{ENV['NAME'].singularize.underscore}.rb"
            file_path = "#{Simplatra::ROOT}/app/models/#{file_name}"
            spec_name = file_name.gsub('.rb','_spec.rb')
            spec_path = "#{Simplatra::ROOT}/spec/models/#{spec_name}"

            if File.exist? file_path
                puts "\n#{"ERR".colorize(:light_red)} » Model file '#{file_path}' already exists."
            else
                File.open(file_path, 'w+') do |f|
                    f.write(<<-EOF.strip_heredoc)
                        class #{name} < ActiveRecord::Base
                            # Add your model methods here...
                        end
                    EOF
                end
                puts "\n#{"Created a model file at".colorize(:light_black)} #{"app/models/#{file_name}".colorize(:green)}"
            end
            if File.exist? spec_path
                message = "\n#{"ERR".colorize(:light_red)} » Model spec '#{file_path}' already exists."
                puts message, ?=*(message.uncolorize.length-1)
            else
                File.open(spec_path, 'w+') do |f|
                    f.write(<<-EOF.strip_heredoc)
                        require_relative '../spec_helper'
                        describe #{name}, type: :model do

                            it "should expect true to be true" do
                                expect(true).to be true
                            end

                        end
                    EOF
                end
                message = "\n#{"Created a model spec at".colorize(:light_black)} #{spec_path.colorize(:green)}"
                puts message, ?=*(message.uncolorize.length-1)
            end
        end

    end
end