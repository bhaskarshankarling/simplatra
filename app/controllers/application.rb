class Application < Sinatra::Base
    # Index routes
    %w(/ /index /home).each do |path|
        get path do
            erb :index, layout: :'templates/layout'
        end
    end

    # 404 routes
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