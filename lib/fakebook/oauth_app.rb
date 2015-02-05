require 'sinatra/base'

module Fakebook
  class OAuthApp < Sinatra::Base
    set :public_folder, File.expand_path('../public', __FILE__)
    set :views,         File.expand_path('../views', __FILE__)

    get '/facebook' do
      @origin = params['origin']
      @users  = Fakebook::User.by_provider :facebook
      # redirect "http://localhost:3000/auth/facebook/callback?origin=#{ CGI.escape params['origin'] }&fakebook_id=john_doe"
      erb :facebook
    end

    get '/user/:id' do
      redirect 'http://localhost:3000'
    end

    helpers do
      def sign_in_url(name)
        "#{Fakebook.app_host}/auth/facebook/callback?origin=#{ CGI.escape @origin }&fakebook_id=#{ CGI.escape name.to_s }"
      end
    end
  end
end