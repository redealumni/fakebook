module Fakebook
  class User
    attr_reader :name, :params

    def initialize(filename)
      @name   = File.basename(filename, '.yml').to_sym
      @params = YAML.load_file filename
    end

    def image_url
      @params['auth']['info']['image']
    end

    def human_name
      @params['human_name']
    end

    def provider
      @params['auth']['provider'].to_sym
    end

    def oauth_params(origin)
      hash = {
        'omniauth.origin' => origin,
        'omniauth.params' => { 'origin' => origin },
        'omniauth.auth'   => @params['auth']
      }
      OauthHash.new hash
    end

    class << self
      def by_provider(provider)
        users[provider.to_sym].values
      end

      def find(provider, name)
        users[provider.to_sym][name.to_sym] or raise 'Could not find user'
      end

      def source(source_path)
        @users       = nil
        @source_path = source_path
      end

      protected
      def users
        @users ||= load_users
      end

      def load_users
        raise 'Undefined fakebook users source path' unless @source_path

        users = Hash.new
        Dir[File.join(@source_path, '*/*.yml')].each do |filename|
          user = self.new filename

          users[user.provider]          ||= Hash.new
          users[user.provider][user.name] = user
        end

        users
      end
    end
  end
end