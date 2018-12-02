# frozen_string_literal: true

require "integral/yandex/money/notification_validator"

RSpec.describe Integral::Yandex::Money::NotificationValidator do

  describe "#valid?" do

    subject { described_class.new(params: params, secret: other_values["secret"]) }

    context "if nil params passed" do
      let(:params) { nil }
      it { expect{ subject.valid? }.to raise_error ArgumentError }
    end

    context "if any of requried params missing" do
      let(:params) { insufficient_params }

      it { expect(subject.valid?).to be_falsey }

      it "has correct error message" do
        subject.valid?
        expect(subject.errors.first).to eq "Required `params` keys missing: codepro, operation_id, sender"
      end
    end

    context "if all of requried params are present" do

      context "if hash is incorrect" do
        let(:params) {
          hash = correct_params
          hash["label"] = "a.different.label"
          hash
        }

        it { expect(subject.valid?).to be_falsey }

        it "has correct error message" do
          subject.valid?
          expect(subject.errors.first).to eq "SHA hashes do not match"
        end

      end

      context "if hash is correct" do
        let(:params) { correct_params }

        it { expect(subject.valid?).to be_truthy }

        it "Should have no errors" do
          subject.valid?
          expect(subject.errors).to be_empty
        end
      end

    end
  end
end
