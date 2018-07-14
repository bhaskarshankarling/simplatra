Bundler.require :hanami
class ApplicationController < Sinatra::Base
    helpers ApplicationHelper, Hanami::Helpers, Hanami::Assets::Helpers

    get '/' do
        erb :index
    end

    get '/404' do
        erb :lost
    end

    error Sinatra::NotFound do
        redirect '/404'
    end
end