class CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer

    @subscription = @customer.subscription
    @subscription = Subscription.create(customer: @customer) unless @subscription
    if @subscription
      @preferences = @subscription.preferences
      @lunches = @subscription.lunch
      @dinners = @subscription.dinner
      @extra_notes = @subscription.extra_notes
      @lunch_time = @subscription.lunch_time ? @subscription.lunch_time.strftime('%H:%M') : 'time unset'
      @dinner_time = @subscription.dinner_time ? @subscription.dinner_time.strftime('%H:%M') : 'time unset'
    end
    
    @allergens = @customer.allergens


    @address = @customer.address
    @address = Address.create(customer: @customer) unless @address
    @phone = @address.phone


  end

  def edit_allergies
    @customer = Customer.find(params[:id])
    redirect_to root_url if @customer != current_customer
  end
end
