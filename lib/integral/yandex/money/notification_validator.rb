# frozen_string_literal: true

require "digest"
require "integral/yandex/money/notification_validator/identity"

module Integral
  module Yandex
    module Money

      # Validation is documented here: https://tech.yandex.ru/money/doc/dg/reference/notification-p2p-incoming-docpage/#notification-p2p-incoming__verify-notification
      class NotificationValidator

        # Order is crucial for `KEYS_FOR_DIGEST`
        KEYS_FOR_DIGEST      = %w[notification_type operation_id amount currency datetime sender codepro notification_secret label].freeze
        PERMITTED_HASH_TYPES = ["ActionController::Parameters", "Hash"].freeze
        REQUIRED_KEYS        = %w[amount codepro datetime notification_type operation_id sender].freeze

        def initialize(params:, secret:)
          fail ArgumentError, "Yandex.Money notifications secret is required" if secret.to_s == ""
          validate_params_hash!(params)

          @secret = secret
          @params = params
          @errors = []
        end

        def errors
          @errors
        end

        def valid?
          return false unless all_param_values_present?
          return false unless integrity_correct?
          return true
        end


        private

        def all_param_values_present?
          missing_keys = REQUIRED_KEYS.select { |key| @params[key].to_s == "" }
          return true if missing_keys.empty?
          (@errors << "Required `params` keys missing: #{missing_keys.uniq.join(', ')}") and return false
        end


        def encode_sha(string)
          Digest::SHA1.hexdigest string
        end


        def integrity_correct?
          stringified_params = stringify_params params_with_secret(@params)
          return true if @params["sha1_hash"] == encode_sha(stringified_params)
          (@errors << "SHA hashes do not match") and return false
        end


        def params_with_secret(params)
          params.merge({ "notification_secret" => @secret })
        end


        def stringify_params(params)
          KEYS_FOR_DIGEST.map { |key| params[key] }.join("&")
          # this way and not just `.to_s` is to enforce required order of params
        end


        def validate_params_hash!(params)
          names = PERMITTED_HASH_TYPES.map { |name| "`#{name}`" }.join(" or ")
          valid = PERMITTED_HASH_TYPES.include? params.class.to_s
          fail ArgumentError, "`params` must be a #{names}, you passed #{params.inspect}" unless valid
        end

      end
    end
  end
end
