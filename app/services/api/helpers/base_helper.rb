module Helpers
  module BaseHelper
    def short_message(message, success_status = true)
      {
        message: message,
        success: success_status
      }
    end

    def is_api_detecting?
      request.path =~ /swagger_doc/
    end

    def check_app_secret
      app_secret = request.headers["App-Secret"]
      if app_secret
        error!("非法的 app_secret", 403) unless allow_app_secrets.include?(app_secret)
      else
        error! "app_secret 未找到", 403
      end
    end

    def allow_app_secrets
      Rails.application.secrets["allow_app_secrets"]
    end

    def log_request
      ApiRequestLog.log(request)
    end

    def per_page
      params[:per_page] || Rails.application.config.per_page
    end

    def page
      params[:page] || 1
    end

    def ip_address
      (request.env['action_dispatch.remote_ip'] || request.ip).to_s
    end

  end
end
