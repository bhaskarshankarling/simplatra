Bundler.require :hanami
class ApplicationController < Sinatra::Base
    helpers ApplicationHelper, Hanami::Helpers, Hanami::Assets::Helpers

    %w[/ /index /home].each do |path|
        get path do
            erb :index
        end
    end

    %w[/404 /lost].each do |path|
        get path do
            erb :lost
        end
    end

    error(Sinatra::NotFound){redirect '/404'}
end