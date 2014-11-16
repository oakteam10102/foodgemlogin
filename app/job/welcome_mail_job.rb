class WelcomeMailJob
  include SuckerPunch::Job

  def perform(customer_id)
    ActiveRecord::Base.connection_pool.with_connection do
      customer = Customer.find(customer_id)
      customer.send_welcome_email
    end
  end

end