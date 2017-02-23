# https://github.com/activeadmin/activeadmin/blob/master/app/assets/stylesheets/active_admin/components/_status_tags.scss
module ActiveAdmin::ViewsHelper
  def order_status_color(status)
    case status
      when 'pending'
        :green
      when 'wait_send'
        :yes
      when 'wait_confirm'
        :orange
      when 'received'
        :green
      when 'cancel'
        :red
    end
  end

  def order_pay_type_state_color(status)
    if status.to_i == 0
      :yes
    else
      :no
    end
  end
end
