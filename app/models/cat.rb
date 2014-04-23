class Cat < ActiveRecord::Base
  include ActiveModel::Validations
  validates :age, :color, :sex, :birth_date, :name, presence: true
  validates :age, numericality: true
  validates_with Validators

end


