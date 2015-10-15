require 'sinatra/base'

module Fakebook
  class OAuthApp < Sinatra::Base
    set :public_folder, File.expand_path('../public', __FILE__)
    set :views,         File.expand_path('../views', __FILE__)

    get '/facebook' do
      @origin = params['origin']
      @users  = Fakebook::User.by_provider :facebook
      erb :facebook
    end

    get '/user/:id' do
      redirect "/"
    end

    helpers do
      def sign_in_url(name)
        "/auth/facebook/callback?origin=#{ CGI.escape @origin }&fakebook_id=#{ CGI.escape name.to_s }"
      end
    end
  end
end
