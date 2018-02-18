class ApplicationController < Sinatra::Base
    helpers ApplicationHelper, Hanami::Helpers, Hanami::Assets::Helpers

    %w[/ /index /home].each do |path|
        get path do
            erb :index
        end
    end

    error Sinatra::NotFound do
        redirect '/404'
    end

    get '/404' do
        redirect '/'
    end

    # Add your other routes here...
    # Or generate another controller for other routes:
    # `rake generate:controller NAME=ControllerName`
end