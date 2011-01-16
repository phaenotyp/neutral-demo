require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'SECRET', 'SECRET'
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  provider :google_apps,  OpenID::Store::Filesystem.new('/tmp'), :domain => 'googlemail.com'
end