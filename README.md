# Yandex.Money notification validator

[![Gem Version](https://badge.fury.io/rb/integral-yandex-money-notification_validator.svg)](http://badge.fury.io/rb/integral-yandex-money-notification_validator)
[![Maintainability](https://api.codeclimate.com/v1/badges/5b7ba150248e751ccbc9/maintainability)](https://codeclimate.com/github/sergeypedan/integral-yandex-money-notification_validator/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/5b7ba150248e751ccbc9/test_coverage)](https://codeclimate.com/github/sergeypedan/integral-yandex-money-notification_validator/test_coverage)
[![Build Status](https://travis-ci.org/sergeypedan/integral-yandex-money-notification_validator.svg?branch=master)](https://travis-ci.org/sergeypedan/integral-yandex-money-notification_validator)

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Features](#features)
  - [Requirements](#requirements)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Tests](#tests)
  - [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Features

Checks integrity of Yandex.Money payment notification by comparing SHA of strigified params including a secret shared with Yandex.

Here are the official docs for the [notification service](https://tech.yandex.ru/money/doc/dg/reference/notification-p2p-incoming-docpage/) and [validating notifications specifically](https://tech.yandex.ru/money/doc/dg/reference/notification-p2p-incoming-docpage/#notification-p2p-incoming__verify-notification).

## Requirements

- [Ruby 2.5.0](https://www.ruby-lang.org) or higher.
- An account in [Yandex.Money](https://money.yandex.ru)
- A notifications secret key (obtained from Yandex.Money [somewehre in the settings](https://money.yandex.ru/myservices/online.xml))
- Rails is assumed but not required

## Setup

Add the following to your Gemfile:

```ruby
gem "integral-yandex-money-notification_validator"
```

## Usage

Intended to use in a Rails controller like so:

```ruby
class YandexMoneyReceiptsController < ApplicationController

  def create
    secret    = "YOUR_YANDEX_MONEY_NOTIFICATIONS_SHARED_SECRET"
    validator = Integral::Yandex::Money::NotificationValidator.new(params: params, secret: secret)

    if validator.valid?
      # Do your thing here, for example create a new `YandexMoneyReceipt` record in DB
    else
      render text: validator.errors.join(". "), status: :bad_request and return
    end
  end

end
```

`params` are supposed to be an `ActionController::Parameters` or just a `Hash`.

`validator.errors` returns an Array of message strings — most often only 1 message, but who knows.

`secret` is recommended to be kept in an ENV variable, Rails credentials or elsewhere secure.

## Tests

To test, run:

```sh
bundle exec rake
```

## Credits

Developed by [Sergey Pedan](http://sergeypedan.ru) at [Integral Design](http://integral-design.ru).
