module PresentedConcern
  extend ActiveSupport::Concern

  included do
    has_many :presented_records, as: :presentable
    include InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
  end
end
