# frozen_string_literal: true

require "integral/yandex/money/notification_validator"
require_relative "../support/params"

RSpec.describe Integral::Yandex::Money::NotificationValidator do

  describe "#encode_sha()" do

    let(:params) { { "sha1_hash": "anything" } }
    let(:secret) { other_values["secret"] }

    subject { described_class.new(params: params, secret: secret) }

    it "Local digest calculation must match examples provided by Yandex" do
      expect( subject.send(:encode_sha, stringify_params(correct_params)) ).to eq other_values["expected_sha"]
    end

  end

end
