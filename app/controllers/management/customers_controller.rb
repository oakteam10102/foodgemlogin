class Management::CustomersController < ApplicationController 
  before_action :authenticate_admin_user!
  
  def show
    @customer = Customer.find(params[:id])
    @subscription = Subscription.find_by_customer_id(@customer.id)
    @preferences = @subscription.preferences
    @lunches = @subscription.lunch
    @dinners = @subscription.dinner
    @extra_notes = @subscription.extra_notes
    @upcoming_meal = @subscription.upcoming_meal
    @lunch_time = @subscription.lunch_time_string
    @dinner_time = @subscription.dinner_time_string
    @address = Address.find_by_customer_id(@customer.id)
    @delivered_meals = @customer.delivered_meals
    @delivered_meal = DeliveredMeal.new(customer: @customer)

  end
end