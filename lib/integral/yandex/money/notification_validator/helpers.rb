# frozen_string_literal: true

require "digest"

module Integral
  module Yandex
    module Money

      module Helpers

        module_function

        def encode_sha string
          Digest::SHA1.hexdigest string
        end

        def find_missing_hash_values required_keys:, hash:
          required_keys.select { |key| hash[key].to_s == "" }
        end

        def stringify_params_with_order keys, params
          keys.map { |key| params[key] }.join("&")
          # this way and not just `.to_s` is to enforce required order of params
        end

        def validate_argument_type! argument:, permitted_types:
          names = permitted_types.map { |name| "`#{name}`" }.join(" or ")
          valid = permitted_types.include? argument.class.to_s
          fail ArgumentError, "`argument` must be a #{names}, you passed #{argument.inspect}" unless valid
        end

      end
    end
  end
end
