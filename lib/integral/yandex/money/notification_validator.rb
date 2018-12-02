# frozen_string_literal: true

require_relative "notification_validator/identity"
require_relative "notification_validator/helpers"

module Integral
  module Yandex
    module Money

      # Validation is documented here: https://tech.yandex.ru/money/doc/dg/reference/notification-p2p-incoming-docpage/#notification-p2p-incoming__verify-notification
      class NotificationValidator

        include Helpers

        # Order is crucial for `KEYS_FOR_DIGEST`
        KEYS_FOR_DIGEST = %w[notification_type operation_id amount currency datetime sender codepro notification_secret label].freeze
        REQUIRED_KEYS   = %w[amount codepro datetime notification_type operation_id sender].freeze

        def initialize params:, secret:
          fail ArgumentError, "Yandex.Money notifications secret is required" if secret.to_s == ""
          validate_argument_type! argument: params, permitted_types: ["ActionController::Parameters", "Hash"]
          @secret = secret
          @params = params
          @errors = []
        end

        attr_reader :errors

        def valid?
          return false unless all_param_values_present?
          return false unless integrity_correct?
          true
        end

        private

        def all_param_values_present?
          missing_keys = find_missing_hash_values required_keys: REQUIRED_KEYS, hash: @params
          return true if missing_keys.empty?
          (@errors << "Required `params` keys missing: #{missing_keys.uniq.join(", ")}") and return false
        end

        def integrity_correct?
          return true if @params["sha1_hash"] == encode_sha(stringified_params)
          (@errors << "SHA hashes do not match") and return false
        end

        def params_with_secret
          @params.merge("notification_secret" => @secret)
        end

        def stringified_params
          stringify_params_with_order KEYS_FOR_DIGEST, params_with_secret
        end

      end
    end
  end
end
