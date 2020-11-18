class IpWhitelist < ActiveRecord::Base
  def self.whitelisted?(ip_address)
    return !self.where("ip_address = ?", ip_address).empty?
  end
end
