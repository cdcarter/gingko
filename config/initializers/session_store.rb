# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bracketology_session',
  :secret      => 'b81fe97af701e384ecfb43779b4a63d5e894095b3070c8e48e70220b5769c41fabbf0da8eddffa7d427409df691dd4e5c4bc051b09e84278d7706ef2d3cb99a1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
