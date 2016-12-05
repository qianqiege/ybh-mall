namespace :hotfix do
  desc "generate order number"
  task generate_order_number: :environment do
    Order.where(number: nil).each do |order|
      order.generate_number
      puts order.number
      order.save
    end
  end
end
