# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_migrate_session',
  :secret      => 'b27dd0feb54fe5b05e0aa86dd6d055fef10f11e95a0d14de2afd58303ac4aa33e9e9ae49c74e142d689e7b26636e374084b11df5a6642a3e721441f4a0902861'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
