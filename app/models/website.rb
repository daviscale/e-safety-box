class Website < ActiveRecord::Base
  validates :name, presence: true

  before_save do |website|
    EncryptionWrapper.encrypt(website)
  end

  after_save do |website|
    EncryptionWrapper.decrypt(website)
  end

  after_find do |website|
    EncryptionWrapper.decrypt(website)
  end
end
