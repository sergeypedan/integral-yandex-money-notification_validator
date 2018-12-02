# frozen_string_literal: true

module Integral
  module Yandex
    module Money
      class NotificationValidator
        # Gem identity information.
        module Identity
          def self.name
            "integral-yandex-money-notification_validator"
          end

          def self.label
            "Yandex.Money notification validator by Integral Design"
          end

          def self.version
            "0.1.1"
          end

          def self.version_label
            "#{label} #{version}"
          end
        end
      end
    end
  end
end
