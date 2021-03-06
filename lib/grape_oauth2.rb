require 'grape'
require 'rack/oauth2'

require 'grape_oauth2/version'
require 'grape_oauth2/configuration'
require 'grape_oauth2/scope'

# Mixins
if defined?(ActiveRecord)
  require 'grape_oauth2/mixins/active_record/access_token'
  require 'grape_oauth2/mixins/active_record/access_grant'
  require 'grape_oauth2/mixins/active_record/client'
elsif defined?(Sequel)
  require 'grape_oauth2/mixins/sequel/access_token'
  require 'grape_oauth2/mixins/sequel/access_grant'
  require 'grape_oauth2/mixins/sequel/client'
end

# Authorization Grants (Strategies)
require 'grape_oauth2/strategies/base'
require 'grape_oauth2/strategies/password'
require 'grape_oauth2/strategies/client_credentials'

# Generators
require 'grape_oauth2/generators/base'
require 'grape_oauth2/generators/token'
require 'grape_oauth2/generators/authorization_code'

# Helpers
require 'grape_oauth2/helpers/access_token_helpers'
require 'grape_oauth2/helpers/oauth_params'

# Responses
require 'grape_oauth2/responses/token_response'

# Endpoints
require 'grape_oauth2/endpoints/token'
require 'grape_oauth2/endpoints/authorize'

module GrapeOAuth2
  def self.config
    @config ||= GrapeOAuth2::Configuration.new
  end

  def self.configure
    yield config
  end
end
