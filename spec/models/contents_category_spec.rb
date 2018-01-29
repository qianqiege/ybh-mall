require 'rails_helper'

RSpec.describe ContentsCategory, type: :model do
  context "test contents_category" do
    it "should" do
      contents_category = ContentsCategory.create(name: "保值产品", is_display: true)
      expect(contents_category.name).to eq("保值产品")
      expect(contents_category.up_id).to eq(nil)
      expect(contents_category.is_display).to eq(true)
    end
  end
end
