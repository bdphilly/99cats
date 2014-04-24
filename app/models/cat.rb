class Cat < ActiveRecord::Base
  include ActiveModel::Validations
  validates :age, :color, :sex, :birth_date, :name, presence: true
  validates :age, numericality: true
  validates_with Validators

  has_many(
    :cat_rental_requests,
    :class_name => "CatRentalRequest",
    :foreign_key => :cat_id,
    :primary_key => :id
  )

end


