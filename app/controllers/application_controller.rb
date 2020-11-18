class ApplicationController < ActionController::Base
  before_filter :require_login
  before_filter :require_whitelisted

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def not_authenticated
      redirect_to login_path, alert: "Please login first"
    end

    def require_whitelisted
      unless IpWhitelist.whitelisted?(request.remote_ip)
        redirect_to login_path, alert: "IP Not Valid"
      end
    end
end
