module Entities
  class ResourcesCollection < Grape::Entity
    expose :meta do
      expose :total
      expose :per_page
      expose :page
    end

    private

    def total
      object[:entries].respond_to?(:total_count) ? object[:entries].total_count : object[:entries].count
    end

    def page
      options[:page]
    end

    def per_page
      options[:per_page].present? ? options[:per_page] : Rails.application.config.per_page
    end
  end
end
