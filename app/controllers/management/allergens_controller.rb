class Management::AllergensController < ApplicationController
  before_action :authenticate_admin_user!
  def index
    @allergens = Allergen.all
  end
  def new
    @allergen = Allergen.new
  end
  def create
    @allergen = Allergen.new allergen_params

    if @allergen.save
      redirect_to management_allergens_url
    else
      render 'new'
    end
  end

  private
  def allergen_params
    params.require(:allergen).permit(:name)
  end
    
end
