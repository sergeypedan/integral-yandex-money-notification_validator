require "pry"

# The following values come from an example in Yandex documentation:
# https://tech.yandex.ru/money/doc/dg/reference/notification-p2p-incoming-docpage/#notification-p2p-incoming__verify-notification

def correct_params
  {
    "amount"            => "300.00",
    "codepro"           => "false",
    "currency"          => "643",
    "datetime"          => "2011-07-01T09:00:00.000+04:00",
    "label"             => "YM.label.12345",
    "notification_type" => "p2p-incoming",
    "operation_id"      => "1234567",
    "sender"            => "41001XXXXXXXX",
    "sha1_hash"         => "a2ee4a9195f4a90e893cff4f62eeba0b662321f9"
  }
end

def insufficient_params
  {
    "amount"            => "300.00",
    "datetime"          => "2011-07-01T09:00:00.000+04:00",
    "notification_type" => "p2p-incoming"
  }
end

def other_values
  {
    "expected_sha" => "a2ee4a9195f4a90e893cff4f62eeba0b662321f9",
    "secret"       => "01234567890ABCDEF01234567890"
  }
end

def stringify_params(hash)
  [
    hash["notification_type"],
    hash["operation_id"],
    hash["amount"],
    hash["currency"],
    hash["datetime"],
    hash["sender"],
    hash["codepro"],
    other_values["secret"],
    hash["label"]
  ].select { |value| value.to_s != "" }.join("&")
end
