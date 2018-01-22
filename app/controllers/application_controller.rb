class ApplicationController < Sinatra::Base
    helpers ApplicationHelper, Hanami::Helpers, Hanami::Assets::Helpers

    %w[/ /index /home].each do |path|
        get path do
            erb :index, layout: :'templates/layout'
        end
    end

    error Sinatra::NotFound do
        redirect to('/')
    end
    get '/404' do
        redirect to('/')
    end

    # Add your other routes here...
    # Or generate another controller for other routes:
    # `rake generate:controller NAME=ControllerName`
end