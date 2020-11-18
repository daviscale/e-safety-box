#!/usr/bin/env ruby

require 'openssl'
require 'base64'
require 'sqlite3'

db = SQLite3::Database.new "/Volumes/katiecale/keystore.db"

1.upto(1000) { |index|
  cipher = OpenSSL::Cipher::AES256.new(:CBC)
  key = Base64.encode64(cipher.random_key).gsub("\n", "")
  iv = Base64.encode64(cipher.random_iv).gsub("\n", "")
  full_key = "#{key}-#{iv}"
  db.execute "INSERT INTO keys(key) VALUES (\"#{full_key}\")"
}

