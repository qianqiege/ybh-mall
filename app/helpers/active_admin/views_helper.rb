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
    if status
      :yes
    else
      :no
    end
  end
end
