class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_success(msg = nil, data = {})
    render :json => {
      success: true,
      message: msg.to_s
    }.merge(data)
  end
end
