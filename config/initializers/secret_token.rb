# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
SaferstallsRails::Application.configure do

  # config.secret_key_base = ENV['RAILS_SECRET_KEY']
  config.secret_key_base = 'e36c9a123faf0f5eb89dbc0250f7ab3d760bac3796fe41b7c47b5c3f256024c59d498cddda6fc3c1880e4f118cacf80edfa24a49da97b98ce01c02e5941ee54e'

end
