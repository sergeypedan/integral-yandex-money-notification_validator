# frozen_string_literal: true

$LOAD_PATH.append File.expand_path("lib", __dir__)
require "integral/yandex/money/notification_validator/identity"

Gem::Specification.new do |spec|
  spec.name     = Integral::Yandex::Money::NotificationValidator::Identity.name
  spec.version  = Integral::Yandex::Money::NotificationValidator::Identity.version
  spec.platform = Gem::Platform::RUBY
  spec.authors  = ["Sergey Pedan"]
  spec.email    = ["sergey.pedan@gmail.com"]
  spec.homepage = "https://github.com/sergeypedan/integral-yandex-money-notification_validator"
  spec.summary  = "Checks integrity of Yandex.Money payment notification by comparing SHA of strigified params including a secret shared with Yandex."
  spec.license  = "MIT"

  spec.metadata = {
    "source_code_uri" => "https://github.com/sergeypedan/integral-yandex-money-notification_validator/blob/master/lib/integral/yandex/money/notification_validator.rb",
    "changelog_uri"   => "https://github.com/sergeypedan/integral-yandex-money-notification_validator/blob/master/CHANGES.md",
    "bug_tracker_uri" => "https://github.com/sergeypedan/integral-yandex-money-notification_validator/issues"
  }


  spec.required_ruby_version = "~> 2.5"
  spec.add_development_dependency "bundler-audit", "~> 0.6"
  spec.add_development_dependency "gemsmith", "~> 12.3"
  spec.add_development_dependency "git-cop", "~> 2.2"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-byebug", "~> 3.5"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "reek", "~> 5.0"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "rubocop", "~> 0.58"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]
end
