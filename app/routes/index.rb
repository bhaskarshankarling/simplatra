class Application < Sinatra::Base
    %w(/ /index /home).each do |path|
        get path do
            erb :index, layout: 'templates/default'.to_sym
        end
    end
end