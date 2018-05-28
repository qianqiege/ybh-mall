module Helpers
  module SharedParamsHelper
    extend Grape::API::Helpers

    # usage:
    # use :period, :pagination
    params :period do
      optional :start_date
      optional :end_date
    end

    params :pagination do
      optional :page, type: Integer, desc: '获取第几页数据'
      optional :per_page, type: Integer, desc: '每页数据大小'
    end

    # usage:
    # use :order, order_by:%i(id created_at), default_order_by: :created_at, default_order: :asc
    params :order do |options|
      optional :order_by, type:Symbol, values:options[:order_by], default: options[:default_order_by]
      optional :order, type:Symbol, values:%i(asc desc), default: options[:default_order]
    end

  end
end
