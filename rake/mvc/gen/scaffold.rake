namespace :mvc do
    namespace :gen do

        desc 'Generates a scaffold (parameters: NAME, CONTROLLER, HELPER, MODEL)'
        task :scaffold do
            unless ENV.has_key? 'NAME'
                message = "\n#{"ERR".colorize(:light_red)} » Scaffold name must be specified e.g. rake generate:scaffold NAME=User"
                puts message, ?=*(message.uncolorize.length-1)
                next
            end
            sh "rake mvc:gen:helper NAME=#{ENV['NAME']}" if ENV['HELPER'].nil? || ENV['HELPER'].downcase == 'true'
            sh "rake mvc:gen:controller NAME=#{ENV['NAME']}" if ENV['CONTROLLER'].nil? || ENV['CONTROLLER'].downcase == 'true'
            sh "rake mvc:gen:model NAME=#{ENV['NAME']}" if ENV['MODEL'].nil? || ENV['MODEL'].downcase == 'true'
        end

    end
end