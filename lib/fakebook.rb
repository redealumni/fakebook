lib = File.expand_path '..', __FILE__
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sinatra'
require 'omniauth'
require 'omniauth-facebook'

require 'fakebook/version'

require 'fakebook/user'
require 'fakebook/oauth_app'
require 'fakebook/oauth_callbacks'

module Fakebook
  def self.config
    yield self
  end

  def self.source_path=(path)
    Fakebook::User.source path
  end

  def self.app_host=(host)
    @app_host = host
  end

  def self.app_host
    @app_host
  end
end
