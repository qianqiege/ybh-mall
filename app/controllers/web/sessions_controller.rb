class Web::SessionsController < ::Devise::SessionsController
  layout "web"

  def after_sign_out_path_for(resource_or_scope)
    '/web'
  end
end
