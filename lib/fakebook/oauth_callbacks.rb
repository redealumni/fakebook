module Fakebook
  class OauthCallbacks
    FILTER_REGEX = /\A\/auth\/(?<provider>[^\/]+)\/callback\Z/

    def initialize(app)
      @app = app
    end

    def call(env)
      filter(env) do |provider, user_id|
        user = Fakebook::User.find provider, user_id
        oauth_params = user.oauth_params( params(env)['origin'] )
        env.merge! oauth_params
      end
      @app.call env
    end

    protected
    def filter(env, &block)
      return false unless path(env)

      match = path(env).match(FILTER_REGEX)
      if match
        yield match[:provider], params(env)['fakebook_id']
      end
    end

    def path(env)
      env['REQUEST_PATH']
    end

    def params(env)
      env['rack.request.query_hash']
    end
  end
end