Bundler.require :hanami
class ApplicationController < Sinatra::Base
    helpers ApplicationHelper, Hanami::Helpers, Hanami::Assets::Helpers

    get '/' do
        erb :index
    end
end