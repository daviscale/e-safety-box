require 'azure'
require 'base64'

Azure.config.storage_blob_host = ENV['STORAGE_BLOB_HOST']
Azure.config.storage_account_name = ENV['STORAGE_ACCOUNT_NAME']
Azure.config.storage_access_key = ENV['STORAGE_ACCESS_KEY']

azure_blob_service = Azure::BlobService.new
blob, keystore = azure_blob_service.get_blob("e-safety-box","keystore.txt")

index = 0

keystore.each_line do |full_key|
  encoded_key, encoded_iv = full_key.to_s.strip.split("-")
  key = Base64.decode64(encoded_key)
  iv = Base64.decode64(encoded_iv)
  Rails.cache.write(index, [key, iv])
  index = index + 1
end
