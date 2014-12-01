class OtherAllergy < ActiveRecord::Base
  belongs_to :customer

  def to_s
    description
  end
end
