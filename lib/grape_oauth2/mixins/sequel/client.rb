module GrapeOAuth2
  module Sequel
    module Client
      extend ActiveSupport::Concern

      # TODO: Make as plugin
      included do
        plugin :validation_helpers
        plugin :timestamps

        one_to_many :access_tokens, class: GrapeOAuth2.config.access_token_class

        def before_validation
          generate_keys if new?
          super
        end

        def validate
          super
          validates_presence [:key, :secret]
          validates_unique [:key]
        end

        def self.authenticate(key, secret, need_secret = true)
          if need_secret
            find(key: key, secret: secret)
          else
            find(key: key)
          end
        end

        protected

        def generate_keys
          self.key = SecureRandom.hex(16) if key.nil? || key.empty?
          self.secret = SecureRandom.hex(16) if secret.nil? || secret.empty?
        end
      end
    end
  end
end
