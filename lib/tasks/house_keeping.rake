namespace :house_keeping do
  desc "TODO"
  task create_subscription: :environment do
    customers = Customer.includes(:subscription).where(subscriptions: { id:nil })
    puts "There are #{customers.count} customers without subscription"
    customers.each do |cust|
      Subscription.create(customer: cust)
      # puts cust
    end
  end

end
