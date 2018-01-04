class Application < Sinatra::Base
    error Sinatra::NotFound do
        redirect to('/')
    end
    get '/404' do
        redirect to('/')
    end
end