namespace :house_keeping do
  desc "TODO"
  task create_subscriptions: :environment do
    customers = Customer.includes(:subscription).where(subscriptions: { id:nil })
    puts "There are #{customers.count} customers without subscription"
    customers.each do |cust|
      Subscription.create(customer: cust)
      # puts cust
    end
  end

  task create_addresses: :environment do
    customers = Customer.includes(:address).where(addresses: { id:nil })
    puts "There are #{customers.count} customers without address"
    customers.each do |cust|
      Address.create(customer: cust)
      # puts cust
    end
  end

end
