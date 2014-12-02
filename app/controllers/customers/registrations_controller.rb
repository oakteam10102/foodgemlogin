class Customers::RegistrationsController < Devise::RegistrationsController

  DAYS = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    redirect_to root if customer_signed_in?
    @address = Address.new()
    super
    
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    id = resource.id
    @address = Address.new(address_params)
    @address.customer = resource


    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved

      @address.save

      subscription = Subscription.new()
      subscription.customer = resource
      subscription.save
      
      WelcomeMailJob.new.async.perform(@address.customer.id)

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource, subscription)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
    # if resource.save
    # super
    # end
  end

def edit_subscription
  @subscription = current_customer.subscription
  @lunches = @subscription.lunch
  @lunches = [] unless @lunches
  @dinners = @subscription.dinner
  @dinners = [] unless @dinners
  @address = current_customer.address
  @tracks = Track.all
  @main_tracks = Track.find_tracks('Main')
  @follow_a_friend_tracks = Track.find_tracks('Follow a Friend')
  @health_goals = HealthGoal.all rescue nil
  @preferences = Preference.where(subscription: @subscription)
  @days = DAYS
  @other_allergy = OtherAllergy.find_or_create_by(customer: current_customer)
end

  # GET /resource/edit
  # def edit

  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource, subscription)
    edit_subscription_registration_url

  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
    def address_params
      params.require(:address).permit(:phone)
    end
end
