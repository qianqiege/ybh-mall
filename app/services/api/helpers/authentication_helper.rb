module Helpers
  module AuthenticationHelper

    def require_authentication?
      !(request.path =~ /users\/auth|users\/reset_password|users\/verify|users\/verify_code|users\/login|doc|examples/)
    end

    def authenticate!
      unauthorized! unless current_user || current_admin_user
    end

    def current_user
      auth_token = request.headers["Access-Token"]
      @current_user ||= User.find_by(authentication_token: auth_token) if auth_token
    end
    def current_admin_user
      auth_token = request.headers["Access-Token"]
      @current_admin_user ||= AdminUser.find_by(authentication_token: auth_token) if auth_token
    end

    def unauthorized!
      response_error '401 Unauthorized', 401
    end

    def authenticate(user)
      user.update_attribute :verified_at, Time.now
      user.generate_authentication_token
      user
    end
  end
end
