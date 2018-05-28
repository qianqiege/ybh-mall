module Helpers
  module ApiStrongParametersHelper
    def match_queue_parameters
      queue = raw_parameters(params)
      queue.permit(:stadium_id, :game_type, :inviter_id, :status)
    end

    def credit_record_parameters
      credit = raw_parameters(params)
      credit.permit(:user_id, :credit_rule_id, :note)
    end

    def user_parameters
      user = raw_parameters(params)
      user.permit(:nick_name, :avatar_url)
    end

    def orders_parameters
      order = raw_parameters(params)
      order[:ip_address] = ip_address

      order[:order_items_attributes] = [{
        product_id: order[:product_id],
        number: order[:number],
        price: order[:price]
      }]

      order.permit(:ip_address, :pay_type, order_items_attributes: [:product_id, :number, :price])
    end

    protected
    def raw_parameters(parameters)
      ActionController::Parameters.new(parameters)
    end

    # usage example: user_params[:avatar] = tempfile_to_uploaded_file(user_params[:avatar])
    def tempfile_to_uploaded_file(tempfile)
      if tempfile && tempfile.is_a?(Hash) && tempfile[:tempfile]
        ActionDispatch::Http::UploadedFile.new tempfile
      else
        tempfile
      end
    end
  end
end
