class Allergen < ActiveRecord::Base
  validates :name, presence: true
  has_many :allergies
  has_many :customers, through: :allergies
  def to_s
    name
  end
end
