ActiveAdmin.register Address do

  permit_params :customer_id, :first_name, :last_name, :street_address, :suite, :city, :state, :zip, :phone, :email
  
end
