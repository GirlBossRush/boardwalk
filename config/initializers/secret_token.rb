# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.


SECRET_COOKIE_TOKEN = if Rails.env.production?
                        ENV['SECRET_COOKIE_TOKEN']
                      else
                        "f23897532768a54b3e0049b49feb2718a28c76d22ffcdc05440b8b6c8f25b9d0eb3288ae7c4e04b175b49ed359b6bdfbfe7899606ce7f01d641fa00fb9383114"
                      end

if SECRET_COOKIE_TOKEN.nil? || SECRET_COOKIE_TOKEN.blank?
  puts "Secret cookie token not set!"
  puts "Run heroku config:add SECRET_COOKIE_TOKEN=YOUR_SECRET_KEY"
  exit
else
  Boardwalk::Application.config.secret_token = SECRET_COOKIE_TOKEN
end