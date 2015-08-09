require "fakery"

Fakery.configure do |f|
  f.match /name/, "Faker::Internet.http_url"
end

