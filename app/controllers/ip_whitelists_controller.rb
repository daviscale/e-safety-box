class IpWhitelistsController < ApplicationController
  skip_before_filter :require_whitelisted

  def new
  end

  def create
    if Rails.cache.read('code') == params[:code]
      IpWhitelist.create(ip_address: request.remote_ip)
      redirect_to(:websites, notice: 'Entered successful code')
    else
      redirect_to two_factor_auth_path, alert: "Invalid Code"	
    end
  end	  
end
