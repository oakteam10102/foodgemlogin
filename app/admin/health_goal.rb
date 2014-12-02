ActiveAdmin.register HealthGoal do

  permit_params :name#, :customer

  form do |f|
    f.inputs do
      f.input :name
      f.submit
    end
  end

end
