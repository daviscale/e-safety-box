require 'securerandom'

class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]
  skip_before_filter :require_whitelisted
  
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      if IpWhitelist.whitelisted?(request.remote_ip)
        redirect_back_or_to(:websites, notice: 'Login successful')
      else
	code = SecureRandom.hex(5)
	Rails.cache.write('code', code, expires_in: 300.seconds)
	blowerio = RestClient::Resource.new(ENV['BLOWERIO_URL'])
        blowerio['/messages'].post :to => '+1555555555', :message => code
	redirect_to two_factor_auth_path
      end	
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(login_path, notice: 'Logged out!')
  end
end
