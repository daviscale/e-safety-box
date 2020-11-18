require 'base64'
require 'openssl'
require 'securerandom'

class EncryptionWrapper

  def self.encrypt(website)
    if website.key_uuid.nil?
      website.key_uuid = SecureRandom.uuid() 
    end
    
    key_lookup = website.key_uuid.gsub(/[a-z-]/,'').slice(0,3).to_i
    if key_lookup < 10
      key_lookup = 10
    end

    key, iv = Rails.cache.read(key_lookup)
    
    website.username = encrypt_single_value(key, iv, website.username)
    website.password = encrypt_single_value(key, iv, website.password)
  end

  def self.decrypt(website)
    key_lookup = website.key_uuid.gsub(/[a-z-]/, '').slice(0,3).to_i
    if key_lookup < 10
      key_lookup = 10
    end

    key, iv = Rails.cache.read(key_lookup)
    website.username = decrypt_single_value(key, iv, website.username)
    website.password = decrypt_single_value(key, iv, website.password)
  end

  private
    def self.encrypt_single_value(key, iv, plaintext)
      if (plaintext.nil? || (plaintext == ''))
        return plaintext
      else	
        cipher = OpenSSL::Cipher::AES256.new(:CBC)
        cipher.encrypt
        cipher.key = key
        cipher.iv = iv
        encrypted = cipher.update(plaintext) + cipher.final
        return Base64.encode64(encrypted)
      end	
    end

    def self.decrypt_single_value(key, iv, secret)
      if (secret.nil? || (secret == ''))
        return secret
      else	
        decipher = OpenSSL::Cipher::AES256.new(:CBC)
        decipher.decrypt
        decipher.key = key
        decipher.iv = iv
        plaintext = decipher.update(Base64.decode64(secret)) + decipher.final
        return plaintext
      end	
    end
end
