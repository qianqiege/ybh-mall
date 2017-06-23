module RecordableConcern
  extend ActiveSupport::Concern


  included do
    has_many :idata_records, as: :recordable
    after_create :create_recordable
    include InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    def create_recordable
      if user && user.wechat_user
        idata_records.create!(wechat_user: user.wechat_user)
      end
    end
  end
end
