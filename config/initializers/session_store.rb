# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_TestPsicologico_session',
  :secret      => '544a47209b4d82d120f1599930972d744d22438748e5b4e48046cdbceeff5658e5f7eba450a3d0c8834a15a72e761b9b05a6bd2a1fcbf3f10c6a3970871ff744'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
